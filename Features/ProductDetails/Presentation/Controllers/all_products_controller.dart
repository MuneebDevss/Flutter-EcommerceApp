

import '../../../../Core/Entities/product.dart';

class AllProductsController{
  late List<Product> products;
  String? selectedValue;
  void filter(){
    switch(selectedValue){
      case 'Name':
        for (int x = 1; x < products.length; x++) {
          Product temp = products[x];
          int y = x - 1;
          for (; y >= 0; y--) {
            if (products[y].title.length > temp.title.length) {
              products[y + 1] = products[y];
            } else {
              break;
            }
          }
          products[y + 1] = temp;
        }
      case "Price":
          for (int x = 1; x < products.length; x++) {
            Product temp = products[x];
            int y = x - 1;
            for (; y >= 0; y--) {
              if (products[y].price > temp.price) {
                products[y + 1] = products[y];
              } else {
                break;
              }
            }
            products[y + 1] = temp;
          }
    }
  }
}