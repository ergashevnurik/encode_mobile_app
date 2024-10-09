import 'package:flutter/material.dart';

class TitleForwardRedirect extends StatelessWidget {
  final String title;
  final String description;
  final void Function()? onPressed;
  const TitleForwardRedirect({Key? key, required this.title, required this.description, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Playwrite USA Modern',
              ),
            ),
            Text(
              '$description',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Playwrite USA Modern',
              ),
            ),
          ],
        ),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 16,
            )
        ),
      ],
    );
  }
}
