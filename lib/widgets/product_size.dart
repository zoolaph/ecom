import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  const ProductSize({ Key? key, required this.productSizes, required this.onSelected }) : super(key: key);

   final List productSizes;
  final Function(String) onSelected;

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {

  // ignore: unused_field
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Row(
          children: [
            for (var i = 0; i < widget.productSizes.length; i++)
              GestureDetector(
                onTap: () {
                  widget.onSelected("${widget.productSizes[i]}");
                  setState(() {
                    _selected = i;
                  });
                },
                child: Container(
                  width: 42.0,
                  height: 42.0,
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: _selected == i ? Theme.of(context).accentColor : const Color(0xFFDCDCDC),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  child: Text(
                    "${widget.productSizes[i]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _selected == i ? Colors.white : Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
      ),
          ]
      ),
    );
  }
}