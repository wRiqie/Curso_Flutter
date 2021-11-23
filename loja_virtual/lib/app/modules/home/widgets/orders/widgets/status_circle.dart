import 'package:flutter/material.dart';

Widget StatusCircle(String title, String subtitle, int status, int thisStatus) {
  Color? backColor;
  Widget child;

  if (status < thisStatus) {
    backColor = Colors.grey[500];
    child = Text(
      title,
      style: const TextStyle(color: Colors.white),
    );
  } else if (status == thisStatus) {
    backColor = Colors.blue;
    child = Stack(
      alignment: Alignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ],
    );
  } else{
    backColor = Colors.green;
    child = const Icon(Icons.check, color: Colors.white,);
  }

  return Column(
    children: [
      CircleAvatar(
        radius: 20,
        backgroundColor: backColor,
        child: child,
      ),
      Text(subtitle),
    ],
  );
}
