import '../../../Core/Entities/product.dart';

class StoreController{
  static List<Product> products=[
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
      imageUrl: ['https://affinity.com.pk/cdn/shop/products/Product_-MJTODioQAMtET1DFhOe_1024x1024@2x.jpg?v=1618258824'],
        subCategory: 'RunningShoes',
        category: 'Shoes',
        description: 'Comfortable running shoes for daily use.',
        sizes: ['7', '8', '9'],
        colors: [
          'black',
          'gray',
          'blue',
        ],
        title: 'Nike Air Zoom Pegasus 38',
        brand: 'Nike',
        price: 150,
        likes: 0,
        id: '2',
        off: '10'
    ),
    Product(
      imageUrl: ['https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/f9fbfeaf-2262-4fbb-bd1c-46acb6322a48/AIR+JORDAN+1+MID.png'],
        subCategory: 'BasketballShoes',
        category: 'Shoes',
        description: 'High-performance basketball shoes for court dominance.',
        sizes: ['9', '10', '11'],
        colors: [
          'red',
          'black',
          'white',
        ],
        title: 'Jordan Mid 1',
        brand: 'Nike',
        price: 125,
        likes: 0,
        id: '3',
        off: '20'
    ),
    Product(
      imageUrl:['https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/b5a8c1df-dc86-4b8d-b3e9-c90e042ecb74/W+AIR+MAX+270.png'] ,

        subCategory: 'CasualShoes',
        category: 'Shoes',
        description: 'Stylish casual shoes for everyday wear.',
        sizes: ['8', '9', '10'],
        colors: [
          'white',
          'black',
          'green',
        ],
        title: 'Nike Air Max 270',
        brand: 'Nike',
        price: 130,
        likes: 0,
        id: '4',
        off: '5'
    ),

  ];
  static List<Product> sport=[
    Product(
      imageUrl: ['https://cdn11.bigcommerce.com/s-yh4gh/images/stencil/1280x1280/products/832/4535/battle-sports-triple-threat-football-receiver-gloves-adult-and-youth__01315.1710731631.jpg?c=2'],
        subCategory: 'FootBall Gloves',
        category: 'Equipment',
        description: 'Durable basketball shoes with excellent grip and support.',
        sizes: ['8', '9', '10', '11'],
        colors: [
          'black',
          'red',
          'white',
        ],
        title: 'Triple Threat Receiver',
        brand: 'Under Armour',
        price: 160,
        likes: 0,
        id: '5',
        off: '15'
    )
,
    Product(
      imageUrl: ['https://pk-live-21.slatic.net/kf/S74053311fa8445cb9fe8e12338330649X.jpg_750x750.jpg_.webp'],
        subCategory: 'BaseballBat',
        category: 'Equipment',
        description: 'Outdoor Sports Natural Wood Baseball Bat Self Defence Wooden Bat Round Bat Ideal For Playing, Exercise & Training, For kids, Men, Women, Boys And Girls (Black), Lightweight Wooden Baseball Bat',
        sizes: ['32', '33', '34'],
        colors: [
          'black',
          'silver',
          'blue',
        ],
        title: 'Under Armour Vapor Pro',
        brand: 'Under Armour',
        price: 120,
        likes: 0,
        id: '6',
        off: '10'
    ),

    Product(
      imageUrl: ['https://static-01.daraz.pk/p/d91b50d36ebad53cfebbfc7a23ef3bdf.jpg_750x750.jpg_.webp'],
        subCategory: 'TrainingShirt',
        category: 'Apparel',
        description: 'Breathable and moisture-wicking training shirt for high-intensity workouts.',
        sizes: ['S', 'M', 'L', 'XL'],
        colors: [
          'black',
          'green',
          'red',
        ],
        title: 'Under Armour Tech 2.0',
        brand: 'Under Armour',
        price: 30,
        likes: 0,
        id: '8',
        off: '5'
    )
  ];
  static List<Product> electronics=[
    Product(
      subCategory: 'Smartphone',
      imageUrl: ['https://images.samsung.com/is/image/samsung/assets/pk/smartphones/galaxy-s24-ultra/buy/01_S24Ultra-Group-KV_PC.jpg?imbypass=true',
        'https://images.samsung.com/is/image/samsung/assets/pk/smartphones/socialimage/02_S24Ultra-Group-KV_Exclusive-P.jpg?imbypass=true',
        'https://images.samsung.com/is/image/samsung/assets/pk/smartphones/galaxy-s24-ultra/buy/03_S24Ultra-GalaxyAI-KV_PC.jpg?imbypass=true'
      ],
      category: 'Electronics',
      description: 'A high-end smartphone with latest features.',
      sizes: ['128GB', '256GB'],
      colors: ['silver', 'black'],
      off: '5',
      title: 'Galaxy S24 Ultra',
      brand: 'Samsung',
      price: 1419.99,
      likes: 0, id: '13',
    ),
    Product(
      imageUrl: ['https://images.samsung.com/is/image/samsung/assets/us/galaxybooks/05172024/GB-PCD-FT12-GB4-Edge-D-V2.jpg?\$570_N_JPG\$'],
        subCategory: 'Laptop',
        category: 'Electronics',
        description: 'Lightweight and powerful laptop for work and entertainment.',
        sizes: ['13"', '15"', '17"'],
        colors: [
          'silver',
          'gray',
          'gold',
        ],
        title: 'Galaxy Book 4 Edge',
        brand: 'Apple',
        price: 1999,
        likes: 0,
        id: '10',
        off: '15'
    ),

    Product(

      imageUrl: ['https://i.pinimg.com/564x/91/46/e7/9146e74d5eaf9901df260d3bbf4f3618.jpg'],
        subCategory: 'Headphones',
        category: 'Electronics',
        description: 'Noise-canceling over-ear headphones with superior sound quality.',
        sizes: ['One Size'],
        colors: [
          'black',
          'white',
          'red',
        ],
        title: 'Samsung',
        brand: 'Samsung',
        price: 349,
        likes: 0,
        id: '11',
        off: '20'
    ),
  ];
}