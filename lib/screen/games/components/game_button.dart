import 'package:flutter/material.dart';

class GameButtonCard extends StatefulWidget {
  final String title;
  final void Function() onPressed;
  const GameButtonCard({
    super.key, 
    required this.title, 
    required this.onPressed
  });

  @override
  State<GameButtonCard> createState() => _GameButtonCardState();
}

class _GameButtonCardState extends State<GameButtonCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onPressed();  // Trigger the onPressed callback
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        height: size.height / 4,
        margin: EdgeInsets.only(right: 15, top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: _isPressed ? Color.fromRGBO(70, 145, 91, 1) : Color.fromRGBO(82, 180, 110, 1),
          border: _isPressed ? Border.all(color: Color.fromRGBO(70, 145, 91, 1), width: 2) : Border.all(color: Color.fromRGBO(82, 180, 110, 1), width: 2), 
        ),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              color: _isPressed ? Colors.white : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
