using MobilePay.AppSwitchDemo.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MobilePay.AppSwitchDemo.Services
{
    public interface IProductService
    {
        IEnumerable<Product> GetAllProducts();
    }
}