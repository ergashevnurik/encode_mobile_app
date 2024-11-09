import 'package:flutter/material.dart';

class CarouselCard extends StatefulWidget {
  final String title;
  final String description;
  const CarouselCard({required this.title, required this.description,super.key});

  @override
  State<CarouselCard> createState() => _CarouselCardState();
}

class _CarouselCardState extends State<CarouselCard> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(21, 28, 51, 1),
                      image: DecorationImage(
                        image: AssetImage('assets/images/banner_bg.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 25, top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.title}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${widget.description}',
                            style: TextStyle(color: Color(0xE0D7D7D7)),
                          ),
                        ],
                      ),
                    ),
                  );
  }
}