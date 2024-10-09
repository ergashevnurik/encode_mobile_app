import 'package:encode_app/components/bottom_bar.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
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
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          mainAxisSpacing: 25,
          crossAxisSpacing: 25,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(7, (index) {
            return Center(
                child: Container(
              width: size.width,
              height: size.height,
              // margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/playstore.png',
                    width: 80,
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Название\nЦена',
                        style: TextStyle(
                          fontSize: 12
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.warning),
                                      title: Text('Скоро будет добавлено! А пока интригиии')
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.share),
                                      title: Text('Скоро будет добавлено! А пока интригиии'),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.copy),
                                      title: Text('Скоро будет добавлено! А пока интригиии'),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.edit),
                                      title: Text('Скоро будет добавлено! А пока интригиии'),
                                    ),
                                  ],
                                );
                            }
                            );
                          }, 
                          icon: Icon(
                            Icons.add,
                            size: 18,
                            color: Colors.white,
                          )
                        ),
                      )
                    ],
                  )
                ],
              ),
            ));
          }),
        ),
      ),
      // bottomNavigationBar: BottomMainBar(),
    );
  }
}
