import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  UserInfo({super.key, required this.title, required this.icon, required this.color});
  final String title;
  Color color;

  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(child: Container()),
          SizedBox(width: 40, child: Icon(icon, color: Colors.white, size: 16,)),
          Expanded(
            flex: 2,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
