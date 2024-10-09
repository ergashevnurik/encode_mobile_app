import 'package:flutter/material.dart';

class AppMainBar extends StatelessWidget {
  const AppMainBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      // title: Text('Encode school'),
      backgroundColor: Color.fromRGBO(82, 180, 110, 1),
      actions: [

      ],
    );
  }
}
