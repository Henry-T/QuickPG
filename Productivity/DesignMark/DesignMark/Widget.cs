using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace DesignMark
{
    // 一个控件标记物
    public class Widget
    {
        public string Name;         // 名称
        public EWidgetType WidgetType;      // 控件类型

        public Point Position;      // 位置
        public Size Size;           // 尺寸
        public Point Anchor;        // 锚点

        public Rect Caps;           // 九宫格分割信息

        HorizontalAlignment HorizontalAlignment;        // 水平对齐
        VerticalAlignment VerticalAlignment;            // 垂直对齐


        public List<Widget> Children = new List<Widget>();
    }
}
