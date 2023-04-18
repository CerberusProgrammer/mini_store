import 'package:flutter/material.dart';

import '../object/category.dart';

List<Category> categories = [
  Category(
    name: 'Food',
    color: Colors.red,
    icon: Icons.fastfood,
    image: Image.network(
      'https://th.bing.com/th/id/OIG.hWffkt0gk931jKflFJIf?pid=ImgGn',
      fit: BoxFit.fitWidth,
    ),
  ),
  Category(
    name: 'Clothing and Accesories',
    color: Colors.pink,
    icon: Icons.checkroom,
    image: Image.network(
      'https://th.bing.com/th/id/OIG.aL3U_ibbV0_eZey1Kc7j?pid=ImgGn',
      fit: BoxFit.fitWidth,
    ),
  ),
  Category(
    name: 'Electronics',
    color: Colors.purple,
    icon: Icons.devices,
    image: Image.network(
      'https://th.bing.com/th/id/OIG.JW_mI68RtnRHtWmeSVvL?pid=ImgGn',
      fit: BoxFit.fitWidth,
    ),
  ),
  Category(
    name: 'Home and Garden',
    color: Colors.green,
    icon: Icons.home,
    image: Image.network(
      'https://th.bing.com/th/id/OIG.MFFUcVjYbRw8Hv1dCJYF?pid=ImgGn',
      fit: BoxFit.fitWidth,
    ),
  ),
  Category(
    name: 'Healthy and Beauty',
    color: Colors.orange,
    icon: Icons.spa,
    image: Image.network(
      'https://th.bing.com/th/id/OIG.hDJx6m1ZUgMai2.Pzjou?pid=ImgGn',
      fit: BoxFit.fitWidth,
    ),
  ),
  Category(
    name: 'Toys and Games',
    color: Colors.amber,
    icon: Icons.sports_esports,
    image: Image.network(
      'https://th.bing.com/th/id/OIG.ZfbZVYbGRqU3VfEk.vcr?pid=ImgGn',
      fit: BoxFit.fitWidth,
    ),
  ),
  Category(
    name: 'Sports and Outdoors',
    color: Colors.blue,
    icon: Icons.hiking,
    image: Image.network(
      'https://th.bing.com/th/id/OIG.cFEzguJkbwt9q57mFBhJ?pid=ImgGn',
      fit: BoxFit.fitWidth,
    ),
  ),
];
