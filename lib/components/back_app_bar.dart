import 'package:flutter/material.dart';

class BackMainAppBar extends StatefulWidget {
  const BackMainAppBar({super.key});

  @override
  State<BackMainAppBar> createState() => _BackMainAppBarState();
}

class _BackMainAppBarState extends State<BackMainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Обратно'),
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
    );
  }
}