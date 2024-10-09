import 'package:flutter/material.dart';

class ButtonToScreen extends StatelessWidget {
  final String title;
  final Icon icon;
  final Color color;
  final void Function()? onPressed;
  const ButtonToScreen({Key? key, required this.title, required this.icon, required this.color, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(50))
              ),
              child: IconButton(
                onPressed: onPressed,
                icon: icon
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('$title'),
          ],
        ),
        SizedBox(
          width: 25,
        )
      ],
    );
  }
}
