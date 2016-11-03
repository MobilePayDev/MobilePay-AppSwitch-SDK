using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;

namespace MobilePay.AppSwitchDemo.Helpers
{
    /// <summary>
    /// Usage:
    ///<code>IsItemClickEnabled="True" helpers:ListViewBaseCommand.ItemClickCommand="{Binding Command}"</code>
    /// </summary>
    public static class ListViewBaseCommand
    {
        public static readonly DependencyProperty ItemClickCommandProperty =
                DependencyProperty.RegisterAttached(
                "ItemClickCommand",
                typeof(ICommand),
                typeof(ListViewBaseCommand),
                new PropertyMetadata(null, OnItemClickCommandPropertyChanged));

        public static ICommand GetItemClickCommand(DependencyObject d)
        {
            return (ICommand)d.GetValue(ItemClickCommandProperty);
        }

        public static void SetItemClickCommand(DependencyObject d, ICommand value)
        {
            d.SetValue(ItemClickCommandProperty, value);
        }

        private static void OnItemClickCommandPropertyChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            var view = d as ListViewBase;

            view.Loaded += gridView_Loaded;
            view.Unloaded += gridView_Unloaded;
        }

        static void gridView_Loaded(object sender, RoutedEventArgs e)
        {
            var view = sender as ListViewBase;
            view.ItemClick += gridView_ItemClick;
        }

        static void gridView_Unloaded(object sender, RoutedEventArgs e)
        {
            var view = sender as ListViewBase;
            view.ItemClick -= gridView_ItemClick;
        }

        static void gridView_ItemClick(object sender, ItemClickEventArgs e)
        {
            var gridView = sender as ListViewBase;
            var command = (ICommand)gridView.GetValue(ItemClickCommandProperty);

            var item = e.ClickedItem;

            command.Execute(item);
        }
    }
}
