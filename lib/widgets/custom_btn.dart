import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({ Key? key, required this.text, required this.onPressed, required this.outlineBtn, required this.isLoading,}) : super(key: key);

final String text;
final Function()? onPressed;
  final bool outlineBtn;
  final bool isLoading;
  
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    bool _outlineBtn = outlineBtn;
    // ignore: unused_local_variable
    bool _isLoading = isLoading;
    // ignore: avoid_unnecessary_containers
    return GestureDetector(
      onTap: onPressed,
    child: Container(
      height: 65.0,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _outlineBtn ? Colors.transparent: Colors.black,
        border: Border.all(
          color: Colors.black,
          width: 2.0
        ),
        borderRadius: BorderRadius.circular(12.0),
         ),
         margin: const EdgeInsets.symmetric(
           horizontal: 24.0,
           vertical: 8.0,
         ),
        //  padding: const EdgeInsets.symmetric(
        //    horizontal: 24.0,
        //    vertical: 32.0
        //  ),
      child: Stack(
        children: [
          Visibility(
            visible: _isLoading ? false : true,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: _outlineBtn ? Colors.black: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                ),
            ),
          ),
            Visibility(
              visible: _isLoading,
              child: const Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    ),
    );
  }
}