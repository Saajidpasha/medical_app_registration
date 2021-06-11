import 'package:flutter/material.dart';

buildTextFormField(
    {String label,
    TextEditingController controller,
    String hint,
    Function validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1}) {
  final TextStyle subTitleStyle = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 20,
      ),
      Text(
        label,
        style: subTitleStyle,
      ),
      Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          textInputAction: TextInputAction.next,
          keyboardType: keyboardType,
          decoration:
              InputDecoration(hintText: hint, border: OutlineInputBorder()),
        ),
      ),
    ],
  );
}
