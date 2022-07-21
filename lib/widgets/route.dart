import 'package:flutter/material.dart';

void nextPage(BuildContext context, dynamic page) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

void nextPageReplacement(BuildContext context, dynamic page) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

void backScreen(BuildContext context) {
  Navigator.of(context).pop();
}

void nextPageRemove(BuildContext context, dynamic page) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => page,
    ),
    (route) => false,
  );
}
