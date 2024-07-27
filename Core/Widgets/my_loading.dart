import 'package:flutter/material.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: const CircularProgressIndicator(),
    );
  }
}
