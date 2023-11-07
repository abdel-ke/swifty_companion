import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.title, required this.icon});
  final String title;

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
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
