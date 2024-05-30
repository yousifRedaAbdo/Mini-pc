import 'package:flutter/material.dart';


Widget mainColorTitle(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.blue,
      fontSize: 24,
      fontFamily: 'dinfont',
    ),
  );
}

Widget appBarTitle(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 28,
      fontFamily: 'dinfont',
      fontWeight: FontWeight.bold
    ),
  );
}

Widget tabText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'dinfont',
    ),
  );
}

Widget title(String text, {Color color = Colors.black87}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: 30,
      fontWeight: FontWeight.w700,
      fontFamily: 'dinfont',
    ),
  );
}

Widget mediumText(String text,{Color color = Colors.black}) {
  return Text(
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    text,
    style: TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'dinfont',
    ),
  );
}

Widget mediumTextInBox(String text) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.w600,
      fontFamily: 'dinfont',
    ),
  );
}

Widget smallText(String text) {
  return Text(
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: 13,
      fontWeight: FontWeight.bold,
      fontFamily: 'dinfont',
    ),
  );
}

Widget smallTextLogin(String text) {
  return Text(
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
    text,
    style: TextStyle(
      color: Colors.grey,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'dinfont',
    ),
  );
}

Widget smallBoldTitle(String text, {Color color = Colors.cyan}) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w700,
      fontFamily: 'dinfont',
    ),
  );
}

Widget miniText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.red,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      fontFamily: 'dinfont',
    ),
  );
}

Widget userText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontFamily: 'dinfont',
    ),
  );
}
