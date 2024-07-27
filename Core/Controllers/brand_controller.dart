import '../Entities/brand.dart';
import '../constants/imageString.dart';

class BrandController{
  static List<Brand> brands=[
    Brand(name: 'Nike', image: ConstantImage.nikeLogo),

  ];
  String getImage(String name)
  {
    for(Brand brand in brands){
      if(brand.name==name) {
        return brand.image;
      }
    }
    return "as";
  }
}