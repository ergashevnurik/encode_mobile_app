import 'package:flutter/material.dart';

class CustomAppBarWithNotification extends StatefulWidget {
  const CustomAppBarWithNotification({super.key});

  @override
  State<CustomAppBarWithNotification> createState() =>
      _CustomAppBarWithNotificationState();
}

class _CustomAppBarWithNotificationState
    extends State<CustomAppBarWithNotification> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logo_dark.png',
              width: 150,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}