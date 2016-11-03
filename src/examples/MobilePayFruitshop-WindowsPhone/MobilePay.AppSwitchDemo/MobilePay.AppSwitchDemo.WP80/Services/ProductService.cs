using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MobilePay.AppSwitchDemo.Services
{
    public class ProductService : IProductService
    {

        public IEnumerable<Models.Product> GetAllProducts()
        {
            var products = new List<Models.Product>();

            products.Add(new Models.Product()
            {
                Title = "Orange",
                Price = 10.0m,
                ImageUrl = "/Images/orange.png"
            });

            products.Add(new Models.Product()
            {
                Title = "Kiwi",
                Price = 0.56m,
                ImageUrl = "/Images/kiwi.png"
            });

            products.Add(new Models.Product()
            {
                Title = "Strawberry",
                Price = 4.43m,
                ImageUrl = "/Images/strawberry.png"
            });

            products.Add(new Models.Product()
            {
                Title = "Fruit basket",
                Price = 1501.52m,
                ImageUrl = "/Images/fruit_basket.png"
            });

            return products;
        }
    }
}