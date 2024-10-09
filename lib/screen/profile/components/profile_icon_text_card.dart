import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  final String title;
  final String text;
  final Icon icon;
  final Function(String) onSave; // Callback for when the value is saved

  const ProfileCard(
      {super.key, required this.title, required this.text, required this.icon, required this.onSave});

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool _isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(82, 180, 110, 1),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: widget.icon,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  _isEditing
                      ? TextField(
                          controller: _controller,
                          onSubmitted: (value) {
                            setState(() {
                              _isEditing = false;
                            });
                            widget.onSave(value); // Save value via API
                          },
                        )
                      : Text(
                          widget.text,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                _isEditing ? Icons.check : Icons.edit,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
                if (!_isEditing) {
                  widget.onSave(_controller.text); // Save when done editing
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
