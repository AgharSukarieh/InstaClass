import 'package:flutter/material.dart';

class EditTextInfo extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String imageicon;

  EditTextInfo({
    super.key,
    required this.controller,
    required this.labelText,
    required this.imageicon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, 15)),
        ],
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "$labelText";
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(40),
          ),
          hintText: labelText,
          prefixIcon: Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(imageicon, width: 14, height: 14),
          ),
        ),
      ),
    );
  }
}
