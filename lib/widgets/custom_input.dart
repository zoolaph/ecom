import 'package:ecomerce/constants.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({ Key? key, required this.text, required this.onChanged, required this.onSubmit, required this.focusNode, required this.textInputAction, required this.isPasswordField }) : super(key: key);

final String text;
final Function(String) onChanged;
final Function(String) onSubmit;
final FocusNode focusNode;
final TextInputAction textInputAction; 
 final bool isPasswordField;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    bool _isPasswordField = isPasswordField;
    // ignore: avoid_unnecessary_containers
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12.0)
      ),
      child: TextField(
         obscureText: _isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmit,
         textInputAction: textInputAction,
        decoration: InputDecoration(
          border: InputBorder.none, 
          hintText: text,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          )
          ),
          style: Constants.regularDarkText,
        ),
    );
  }
}