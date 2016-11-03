using System;
using Windows.UI.Xaml.Data;

namespace MobilePay.AppSwitchDemo.Converters
{
    public class PriceToStringConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, string language)
        {
            if (value is decimal)
            {
                decimal price = (decimal)value;
                return price.ToString("0.00") + " kr.";
            }
            return "";
        }

        public object ConvertBack(object value, Type targetType, object parameter, string language)
        {
            throw new NotImplementedException();
        }
    }
}