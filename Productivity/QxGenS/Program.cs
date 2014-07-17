using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Text.RegularExpressions;

namespace QxGen
{
    // 类型做成枚举的目的是 在生成代码时按控件类别排序
    public enum EControlType
    {
        Label,
        Image,
        Button,
        List,
        Templete,       // 模板类型
    }

    public class ControlInfo
    {
        public string Name;
        public EControlType Type;        // 1-Label 2-Image 3-Button
        public string Base;     // "Top"(顶级) 或 tpl名称
    }

    class Program
    {
        static void Main(string[] args)
        {
            //System.Environment.CurrentDirectory = 

            // 载入文本模板
            string modHead = File.ReadAllText("Templete/ModHead.lua");
            string modReturn = File.ReadAllText("Templete/ModReturn.lua");
            string modClassLevel = File.ReadAllText("Templete/ModClassLevel.lua");
            string modTopLabelDef = File.ReadAllText("Templete/ModTopLabelDef.lua");
            string modTopImageDef = File.ReadAllText("Templete/ModTopImageDef.lua");
            string modTopButtonDef = File.ReadAllText("Templete/ModTopButtonDef.lua");
            string modListDef = File.ReadAllText("Templete/ModListDef.lua");
            string modListFunc = File.ReadAllText("Templete/ModListFunc.lua");
            string modSubLabelDef = File.ReadAllText("Templete/ModSubLabelDef.lua");
            string modSubImageDef = File.ReadAllText("Templete/ModSubImageDef.lua");
            string modSubButtonDef = File.ReadAllText("Templete/ModSubButtonDef.lua");

            // 预先定义
            string json_className = "PanelMissingName";
            List<ControlInfo> json_controls = new List<ControlInfo>();

            // ==============================
            // 读取json
            // ==============================
            string jsonStr = File.ReadAllText("PanelCollectMailBonus.json", Encoding.UTF8);
            // 匹配类名
            Regex regClassName = new Regex(@"Panel\w+");
            Match matchClassName = regClassName.Match(jsonStr);
            if (matchClassName.Success)
            {
                json_className = matchClassName.Value;
            }

            // 匹配顶级控件
            Regex retControl = new Regex(@"(lb|img|btn|lst|tpl)\w+");

            foreach (Match match in retControl.Matches(jsonStr))
            {
                // 名称
                string matchStr = match.Value;
                ControlInfo ctrlInfo = new ControlInfo() { Name = match.Value, Type = EControlType.Label, Base = "Top"};

                // 类型检查
                if (matchStr.StartsWith("lb"))
                {
                    ctrlInfo.Type = EControlType.Label;
                }
                else if (matchStr.StartsWith("img"))
                {
                    ctrlInfo.Type = EControlType.Image;
                }
                else if (matchStr.StartsWith("btn"))
                {
                    ctrlInfo.Type = EControlType.Button;
                }
                else if (matchStr.StartsWith("lst"))
                {
                    ctrlInfo.Type = EControlType.List;
                }
                else if(matchStr.StartsWith("tpl"))
                {
                    ctrlInfo.Type = EControlType.Templete;
                }

                // 顶级检查
                Regex regValidTop = new Regex("(" + matchStr + @")[\s\S]+?\n(\s+)\S[\s\S]+\n(\s+)[\s\S]+?(tpl\w+)");
                Match matchValid = regValidTop.Match(jsonStr);
                if (matchValid.Success && matchValid.Groups[2].Value.Length > matchValid.Groups[3].Value.Length)
                {
                    string nakeName = matchValid.Groups[4].Value.Replace("tpl", "");
                    ctrlInfo.Base = nakeName;
                }

                json_controls.Add(ctrlInfo);
            }

            // 按类型排序
            json_controls.Sort((a, b) => { return a.Type.CompareTo(b.Type); });

            // =============================
            // 构造新lua
            // =============================
            StringBuilder sbLuaStr = new StringBuilder();

            // 模块 - 信息前缀

            // 模块 - 类定义与构造
            sbLuaStr.AppendFormat(modHead, json_className);

            // 模块 - 顶级控件定义 (基础控件和容器)
            StringBuilder sbTopCtrlDef = new StringBuilder();

            foreach(ControlInfo ctrlInfo in json_controls)
            {
                if(ctrlInfo.Type == EControlType.Label && ctrlInfo.Base == "Top")
                {
                    sbTopCtrlDef.AppendFormat(modTopLabelDef, ctrlInfo.Name);
                }
                else if (ctrlInfo.Type == EControlType.Image && ctrlInfo.Base == "Top")
                {
                    sbTopCtrlDef.AppendFormat(modTopImageDef, ctrlInfo.Name);
                }
                else if (ctrlInfo.Type == EControlType.Button && ctrlInfo.Base == "Top")
                {
                    sbTopCtrlDef.AppendFormat(modTopButtonDef, ctrlInfo.Name);
                }
                else if (ctrlInfo.Type == EControlType.List)
                {
                    string nakeName = ctrlInfo.Name.Replace("lst", "");
                    sbTopCtrlDef.AppendFormat(modListDef, nakeName);
                }
            }

            Regex regTopCtrlDef = new Regex(@"-- QXGEN_TOP_CONTROL_DEFINE\s*\n");
            Match matchTopCtrlDef = regTopCtrlDef.Match(sbLuaStr.ToString());
            if (matchTopCtrlDef.Success)
            {
                sbLuaStr.Replace("-- QXGEN_TOP_CONTROL_DEFINE", "");
                sbLuaStr.Insert(matchTopCtrlDef.Index + matchTopCtrlDef.Length - "-- QXGEN_TOP_CONTROL_DEFINE".Length, sbTopCtrlDef.ToString());
            }

            // 模块 - 容器常用功能函数
            foreach (ControlInfo ctrlInfo in json_controls)
            {
                if (ctrlInfo.Type == EControlType.List)
                {
                    string listName = ctrlInfo.Name;
                    string nakeName = ctrlInfo.Name.Replace("lst", "");
                    sbLuaStr.AppendFormat(modListFunc, matchClassName, nakeName);

                    // 容器子控件定义
                    StringBuilder sbSubCtrlDef = new StringBuilder();
                    foreach (ControlInfo subCtrlInfo in json_controls.Where(i => i.Base == nakeName))
                    {
                        if (subCtrlInfo.Type == EControlType.Label)
                        {
                            sbSubCtrlDef.AppendFormat(modSubLabelDef, nakeName, subCtrlInfo.Name);
                        }
                        else if (subCtrlInfo.Type == EControlType.Image)
                        {
                            sbSubCtrlDef.AppendFormat(modSubImageDef, nakeName, subCtrlInfo.Name);
                        }
                        else if (subCtrlInfo.Type == EControlType.Button)
                        {
                            sbSubCtrlDef.AppendFormat(modSubButtonDef, nakeName, subCtrlInfo.Name);
                        }
                    }

                    // 向add函数中嵌入子控件定义
                    string matchStr = "-- QxGEN_SUB_CTRL_DEF " + nakeName;
                    Regex regSubCtrlDef = new Regex(matchStr);
                    Match matchSubCtrlDef = regSubCtrlDef.Match(sbLuaStr.ToString());
                    if (matchSubCtrlDef.Success)
                    {
                        sbLuaStr.Replace(matchStr, "");
                        sbLuaStr.Insert(matchSubCtrlDef.Index + matchSubCtrlDef.Length - matchStr.Length, sbSubCtrlDef.ToString());
                    }
                }
            }
                        
            // 模块 - 自定义类级代码
            sbLuaStr.Append(modClassLevel);

            // 模块 - 返回
            sbLuaStr.AppendFormat(modReturn, json_className);


            // ==============================
            // 备份旧lua文件
            // ==============================
            string luaFileName = json_className + ".lua";
            if (File.Exists(luaFileName))
            {
                // 备份
                int backUpId = 1;
                bool backUpDone = false;
                do
                {
                    string backUpFile = json_className + ".backup" + backUpId.ToString("D4") + ".lua";
                    if (File.Exists(backUpFile))
                    {
                        backUpId++;
                        continue;
                    }
                    else
                    {
                        File.Copy(luaFileName, backUpFile, false);
                        backUpDone = true;
                    }
                }
                while (!backUpDone);
            }

            // ==============================
            // 合并旧lua文件中的自定义脚本
            // ==============================
            // Dictionary<string, string> CustomCodeBlock = new Dictionary<string, string>();
            if (File.Exists(luaFileName))
            {
                string oldLuaStr = File.ReadAllText(luaFileName);
                // 初始化脚本
                Regex regCustomCodeInit = new Regex(@"-- QxGEN_CUSTOM_CLASS_INIT_BEGIN\s*?\n([\s\S]*?)-- QxGEN_CUSTOM_CLASS_INIT_END");
                Match oldCustomCodeInit = regCustomCodeInit.Match(oldLuaStr);
                if(oldCustomCodeInit.Success)
                {
                    Match newCustomCodeInit = regCustomCodeInit.Match(sbLuaStr.ToString());
                    if (newCustomCodeInit.Success)
                    {
                        sbLuaStr.Remove(newCustomCodeInit.Groups[1].Index, newCustomCodeInit.Groups[1].Length);
                        sbLuaStr.Insert(newCustomCodeInit.Groups[1].Index, oldCustomCodeInit.Groups[1].Value);
                    }
                    else
                    {
                        Console.WriteLine("警告 在新版本中找不到标记 丢弃自定义代码: QxGEN_CUSTOM_CLASS_INIT");
                        Console.Write(oldCustomCodeInit.Groups[1] + "\n");
                    }
                }

                // 类级脚本
                Regex regCustomCodeLevel = new Regex(@"-- QxGEN_CUSTOM_CLASS_LEVEL_BEGIN\s*?\n([\s\S]*?)-- QxGEN_CUSTOM_CLASS_LEVEL_END");
                Match oldCustomCodeLevel = regCustomCodeLevel.Match(oldLuaStr);
                if (oldCustomCodeLevel.Success)
                {
                    string oldStr = oldCustomCodeLevel.Groups[1].Value;
                    Match newCustomCodeLevel = regCustomCodeLevel.Match(sbLuaStr.ToString());
                    if (newCustomCodeLevel.Success)
                    {
                        string newStr = newCustomCodeLevel.Groups[1].Value;
                        sbLuaStr.Remove(newCustomCodeLevel.Groups[1].Index, newCustomCodeLevel.Groups[1].Length);
                        sbLuaStr.Insert(newCustomCodeLevel.Groups[1].Index, oldStr);
                    }
                    else
                    {
                        Console.WriteLine("警告 在新版本中找不到标记 丢弃自定义代码: QxGEN_CUSTOM_CLASS_LEVEL");
                        Console.Write(oldCustomCodeInit.Groups[1] + "\n");
                    }
                }

                // 控件事件处理脚本
                Regex regCustomBtnTouch = new Regex(@"-- QxGEN_CUSTOM_BTN_TOUCH_BEGIN\s+?([\w\.]+)\s*\n([\s\S]*?)-- QxGEN_CUSTOM_BTN_TOUCH_END");
                foreach (Match oldMatch in regCustomBtnTouch.Matches(oldLuaStr))
                {
                    string eventName = oldMatch.Groups[1].Value;
                    string eventBody = oldMatch.Groups[2].Value;

                    Regex regNewCustomBtnTouch = new Regex(@"-- QxGEN_CUSTOM_BTN_TOUCH_BEGIN\s+?"+eventName+@"\s*\n([\s\S]*?)-- QxGEN_CUSTOM_BTN_TOUCH_END");
                    Match newMatch = regNewCustomBtnTouch.Match(sbLuaStr.ToString());
                    {
                        if(newMatch.Success)
                        {
                            sbLuaStr.Remove(newMatch.Groups[1].Index, newMatch.Groups[1].Length);
                            sbLuaStr.Insert(newMatch.Groups[1].Index, eventBody);
                        }
                        else
                        {
                            Console.WriteLine("警告 在新版本中找不到标记 丢弃自定义代码: QxGEN_CUSTOM_BTN_TOUCH_BEGIN " + eventName);
                            Console.Write(oldCustomCodeInit.Groups[1] + "\n");
                        }
                    }
                }
            }
            
            // =================================
            // 写入文件
            // =================================
            StreamWriter writer = File.CreateText(json_className + ".lua");
            writer.WriteLine("-- 这是由QxGen生成的UI类\n\n");
            writer.Write(sbLuaStr.ToString());
            writer.Close();

            //Console.ReadKey();
        }
    }
}
