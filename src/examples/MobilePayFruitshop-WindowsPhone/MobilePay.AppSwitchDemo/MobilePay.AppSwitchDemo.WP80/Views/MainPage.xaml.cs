using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;
using Microsoft.Phone.Controls;
using Microsoft.Phone.Shell;
using MobilePay.AppSwitchDemo.ViewModel;

namespace MobilePay.AppSwitchDemo.Views
{
    public partial class MainPage : PhoneApplicationPage
    {

        public MainViewModel ViewModel
        {
            get
            {
                return (MainViewModel)DataContext;
            }
        }

        // Constructor
        public MainPage()
        {
            InitializeComponent();
            this.Loaded += MainPage_Loaded;
        }

        void MainPage_Loaded(object sender, RoutedEventArgs e)
        {
            //Get result from the QueryString
            var queryString = NavigationContext.QueryString;
            ViewModel.LoadFromQueryString(queryString); //Simple solution: Parse it to the ViewModel to handle it for us
        }

        private void AppBarHelpButton_Click(object sender, EventArgs e)
        {
            App.RootFrame.Navigate(new Uri("/Views/HelpPage.xaml", UriKind.Relative));
        }
    }
}