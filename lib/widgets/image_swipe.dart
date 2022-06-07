import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  const ImageSwipe({ Key? key, required this.imageList }) : super(key: key);

final List imageList;
  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {

   // ignore: unused_field
   int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 400.0,
      child: Stack(
        children: [
          PageView(
            // ignore: avoid_types_as_parameter_names
            onPageChanged: (num) {
              setState(() {
                _selectedPage = num;
              });
            },
            children: [
              for(var i=0; i < widget.imageList.length; i++)
                // ignore: avoid_unnecessary_containers
                Container(
                  child: Image.network(
                    "${widget.imageList[i]}",
                    fit: BoxFit.cover,
                  ),
                )
            ],
          ),
          Positioned(
             bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(var i=0; i < widget.imageList.length; i++)
                // ignore: sized_box_for_whitespace
                AnimatedContainer(
                   duration: const Duration(
                      milliseconds: 300
                    ),
                    curve: Curves.easeOutCubic,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                  
                  width:  _selectedPage == i ? 35.0 : 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.0)
                    ),
                )
            ],
            ),
          )
        ]
    ),
    );
  }
}