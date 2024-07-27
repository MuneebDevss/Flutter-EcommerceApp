import 'package:ecommerce_app/Core/Entities/product.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  List<int> index=[];
  static List<Product> products = [
    Product(
        subCategory: 'SportShoes',
        category: 'Shoes',
        description: 'High-performance shoes for sport activities.',
        sizes: ['8', '9', '10'],
        imageUrl: ['https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/b8648fa2-c2b4-4767-afb6-1ccfcab3c78e/W+NIKE+FREE+METCON+6.png'
          ,'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/b8648fa2-c2b4-4767-afb6-1ccfcab3c78e/W+NIKE+FREE+METCON+6.png',
        'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/7ab4d70f-1fcf-4299-a619-f8421759a97d/W+NIKE+FREE+METCON+6.png',
        ],
        colors: [
          'amber',
          'amber',
          'white',
        ],
        title: 'Nike Free'
            'Metcon 6',
        brand: 'Nike',
        price: 120,
        likes: 0, id: '1',
      off: '15'
    ),
    Product(
        subCategory: 'SportShoes',
        category: 'Shoes',
        description: 'Comfortable running shoes for daily workouts.',
        sizes: ['7', '8', '9'],
        colors: [
          'blue',
          'red',
          'green',
        ],
        title: 'Adidas Ultraboost',
        brand: 'Adidas',
        price: 150,
        likes: 0,
      imageUrl: ['https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/7c859cc5-133a-4c22-ad15-02dbb826f28e/W+AIR+ZOOM+ALPHAFLY+NEXT%25+3+FP.png',
        'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/b2221e37-ca5e-4207-bead-8ba0fb9507e1/W+AIR+ZOOM+ALPHAFLY+NEXT%25+3+FP.png',
        'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/e4927212-afdc-465b-a3ab-cb9839c9a2bb/W+AIR+ZOOM+ALPHAFLY+NEXT%25+3+FP.png',
        'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/ef2357a7-4992-4d6f-a39c-324b0a8c24ef/W+AIR+ZOOM+ALPHAFLY+NEXT%25+3+FP.png'

      ], id: '2',
      off: '10'
    ),
    Product(
        subCategory: 'SportShoes',
        category: 'Shoes',
        description: 'Durable and lightweight sports shoes.',
        sizes: ['6', '7', '8'],
        colors: [
          'black',
          'yellow',
          'purple',
        ],
        title: 'Puma NRGY Neko',
        brand: 'Puma',
        price: 100,
        likes: 0,
      imageUrl: [
        'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1350,h_1350/global/192358/02/sv01/fnd/PNA/fmt/png/NRGY-Neko-Future-Men%E2%80%99s-Running-Shoes',
        'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1350,h_1350/global/192358/02/fnd/PNA/fmt/png/NRGY-Neko-Future-Men%E2%80%99s-Running-Shoes',
        'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1350,h_1350/global/192358/02/bv/fnd/PNA/fmt/png/NRGY-Neko-Future-Men%E2%80%99s-Running-Shoes',
        'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_1350,h_1350/global/192358/02/sv02/fnd/PNA/fmt/png/NRGY-Neko-Future-Men%E2%80%99s-Running-Shoes'
      ], id: '3'
    ),
    Product(
        subCategory: 'DressShoes',
        category: 'Shoes',
        description: 'Elegant shoes for formal occasions.',
        sizes: ['9', '10', '11'],
        colors: [
          'brown',
          'black',
          'blueGrey',
        ],
        title: 'Oxford Leather Shoes',
        brand: 'Clarks',
        price: 200,
        likes: 0,
      imageUrl: ['https://fhsofficial.com/cdn/shop/files/MSZ00375-010_13_1024x1024@2x.jpg?v=1703240246',
        'https://fhsofficial.com/cdn/shop/files/MSZ00375-010_11_1024x1024@2x.jpg?v=1703240246',
        'https://fhsofficial.com/cdn/shop/files/MSZ00375-010_12_1024x1024@2x.jpg?v=1703240246'
      ], id: '4'
    ),
    Product(
        subCategory: 'DressShoes',
        category: 'Shoes',
        description: 'Stylish and comfortable dress shoes.',
        sizes: ['8', '9', '10'],
        colors: [
          'tan',
          'black',
          'grey',
        ],
        title: 'Derby Classic',
        brand: 'Hush Puppies',
        price: 180,
        likes: 0,
      imageUrl: ['https://adoro.com.pk/cdn/shop/files/ClassicDerby-Black_8e475072-5715-434f-8157-d2bcd5b04e28.jpg?v=1688974131',
      'https://adoro.com.pk/cdn/shop/files/ClassicDerby-Black-1.jpg?v=1688974131',
      'https://adoro.com.pk/cdn/shop/products/62_764ed4d1-2bd9-4502-978d-ac105dc3b6a3.jpg?v=1688974131&width=1946'], id: '5'
    ),
    Product(
        subCategory: 'DressShoes',
        category: 'Shoes',
        description: 'Premium leather shoes for business wear.',
        sizes: ['7', '8', '9'],
        colors: [
          'black',
          'brown',
          'blue',
        ],
        title: 'Cap Toe Oxford',
        brand: 'Johnston & Murphy',
        price: 220,
        likes: 0,
      imageUrl: ['https://www.carminashoemaker.com/cdnassets/captoe_oxfords_tan_boxcalf_80386_l.jpg',
      'https://www.carminashoemaker.com/cdnassets/captoe_oxfords_tan_boxcalf_80386_sadl.jpg',
      'https://www.carminashoemaker.com/cdnassets/captoe_oxfords_tan_boxcalf_80386_fadl.jpg'], id: '6',
    ),

    // Product(
    //     subCategory: 'BasketBallShoes',
    //     category: 'Shoes',
    //     description: 'High-top shoes for maximum support on the court.',
    //     sizes: ['10', '11', '12'],
    //     colors: [
    //       'red',
    //       'black',
    //       'white',
    //     ],
    //     title: 'Air Jordan XXXV',
    //     brand: 'Jordan',
    //     price: 250,
    //     likes: 0, id: '7'
    // ),
    // Product(
    //     subCategory: 'BasketBallShoes',
    //     category: 'Shoes',
    //     description: 'Shoes designed for explosive performance.',
    //     sizes: ['9', '10', '11'],
    //     colors: [
    //       'blue',
    //       'white',
    //       'yellow',
    //     ],
    //     title: 'Nike LeBron 18',
    //     brand: 'Nike',
    //     price: 230,
    //     likes: 0, id: '8'
    // ),
    // Product(
    //     subCategory: 'BasketBallShoes',
    //     category: 'Shoes',
    //     description: 'Lightweight shoes for speed and agility.',
    //     sizes: ['8', '9', '10'],
    //     colors: [
    //       'green',
    //       'black',
    //       'white',
    //     ],
    //     title: 'Adidas Harden Vol. 4',
    //     brand: 'Adidas',
    //     price: 210,
    //     likes: 0, id: '9'
    // ),

  ];
}
