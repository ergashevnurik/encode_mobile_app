import 'package:encode_app/components/bottom_bar.dart';
import 'package:encode_app/screen/shop/components/shop_details_card.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  final List<Map<String, String>> products = [
    {
      "price": "30",
      "title": "Hat",
      "img": "assets/images/shop/hat.jpg"
    },
    {
      "price": "30",
      "title": "Cup",
      "img": "assets/images/shop/cup.png"
    },
    {
      "price": "30",
      "title": "Pen",
      "img": "assets/images/shop/pen.jpg"
    },
    {
      "price": "30",
      "title": "T-shirt",
      "img": "assets/images/shop/tshirt.jpg"
    },
    {
      "price": "30",
      "title": "Note book",
      "img": "assets/images/shop/white_note_book.png"
    },
    {
      "price": "30",
      "title": "Book",
      "img": "assets/images/shop/black_book.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Обратно'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Color.fromARGB(255, 238, 238, 238),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
          crossAxisCount: 1,
          mainAxisSpacing: 25,
          crossAxisSpacing: 25,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(products.length, (index) {
            return ShopDetailsCard(
              imgSrc: products[index]['img']!, 
              title: products[index]['title']!, 
              price: products[index]['price']!
            );
          }
        ),
      ),
    ),
    bottomNavigationBar: BottomMainBar(activeIndex: 0),
    );
  }
}
