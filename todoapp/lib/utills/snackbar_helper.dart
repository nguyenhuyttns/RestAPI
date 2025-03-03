import 'package:flutter/material.dart';

void showErrorMesage(BuildContext context, {required String message}) {
  final snackbar = SnackBar(
    content: Text(message, style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void showSuccessMesage(BuildContext context, {required String message}) {
  final snackbar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
