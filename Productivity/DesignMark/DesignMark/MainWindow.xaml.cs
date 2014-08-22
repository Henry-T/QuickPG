using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace DesignMark
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    public partial class MainWindow : Window
    {
        public Widget RootWidget;       // 根控件 根据目标设计尺寸来定义

        public int CanvasWidth;     // 画布宽度
        public int CanvasHeight; 

        public MainWindow()
        {
            InitializeComponent();
        }

        private void Window_Initialized(object sender, EventArgs e)
        {
            RootWidget = new Widget();
            RootWidget.Anchor = new Point(0.5, 0.5);
            RootWidget.Position = new Point(CanvasWidth / 2, CanvasHeight / 2);
            RootWidget.Size = new Size(CanvasWidth, CanvasHeight);

            TreeViewItem triRoot = new TreeViewItem();
            

            // tst
            var imgBg = new Widget();
            imgBg.Name = "imgBg";
            RootWidget.Children.Add(imgBg);

            Button btnImgBg = new Button();
            btnImgBg.Content = "imgBg";
            triRoot.Items.Add(btnImgBg);

            var btnClose = new Widget();
            btnClose.Name = "btnClose";
            RootWidget.Children.Add(btnClose);

            Button btnBtnClose = new Button();
            btnBtnClose.Content = "btnClose";
            triRoot.Items.Add(btnBtnClose);

            trvWidgetTree.Items.Add(triRoot);


        }
    }
}
