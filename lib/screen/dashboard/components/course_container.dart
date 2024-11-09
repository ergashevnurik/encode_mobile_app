import 'package:flutter/material.dart';

class CourseContainer extends StatelessWidget {
  final String title;
  final String description;
  final Icon icon;
  const CourseContainer({Key? key, required this.title, required this.description, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 250,
          width: 250,
          decoration: BoxDecoration(
              color: Color.fromRGBO(21, 28, 51, 1),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                icon,
                SizedBox(height: 15),
                Text(
                  '$title',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  '$description',
                  style: TextStyle(
                      color: Colors.white
                  ),
                  overflow: TextOverflow.fade,
                  softWrap: true,
                  maxLines: 6,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 25,
        )
      ],
    );
  }
}
