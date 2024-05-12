import 'package:flutter/material.dart';

class BlogField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const BlogField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      maxLines: null,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText không được để trống!";
        }
        return null;
      },
    );
  }
}
