
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyMacroWidget extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  const MyMacroWidget({
    required this.title,
    required this.value,
    required this.icon,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  offset: Offset(2, 2),
                  blurRadius: 5,
                )
              ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                FaIcon(
                  icon,
                  color: Colors.redAccent,
                ),
                SizedBox(height: 4,),
                Text(
                  title == "Calories"
                  ? '$title $value'
                  : '$title ${value}g',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
