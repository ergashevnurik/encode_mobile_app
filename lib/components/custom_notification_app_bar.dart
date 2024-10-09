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
          height: 15,
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
                // Container(
                //   child: IconButton(
                //       onPressed: () {},
                //       icon: Icon(Icons.search)
                //   ),
                // ),
                Container(
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.notifications)),
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
