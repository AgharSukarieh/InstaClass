import 'package:flutter/material.dart';

class EditTextSearch extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String imageicon;

  EditTextSearch({
    super.key,
    required this.controller,
    required this.labelText,
    required this.imageicon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, 12)),
        ],
      ),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(40),
          ),
          hintText: labelText,
          suffix: Image.asset(imageicon, width: 30, height: 20),
        ),
      ),
    );
  }
}
