import 'package:flutter/material.dart';

class ShopDetailsCard extends StatefulWidget {
  final String imgSrc;
  final String title;
  final String price;

  const ShopDetailsCard({
    super.key,
    required this.imgSrc,
    required this.title,
    required this.price,
  });

  @override
  State<ShopDetailsCard> createState() => _ShopDetailsCardState();
}

class _ShopDetailsCardState extends State<ShopDetailsCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(115, 179, 179, 179),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjust height based on content
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use Flexible to prevent overflow by letting the image resize
          Flexible(
            child: Container(
              width: double.infinity,
              height: size.height, // Fixed height for the image container
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    widget.imgSrc,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            '${widget.title}\n${widget.price}',
            style: TextStyle(
              fontSize: 16
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10),
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Преобрести',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  )
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            ListTile(
                              leading: Icon(Icons.warning),
                              title: Text('Скоро будет добавлено! А пока интригиии'),
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
                      },
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
