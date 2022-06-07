import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  const BottomTabs({ Key? key, required this.selectedTab, required this.tabPressed }) : super(key: key);

   final int selectedTab;
   final Function(int) tabPressed;

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
late int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {

    _selectedTab = widget.selectedTab;
    // ignore: avoid_unnecessary_containers
    return Container(
      //  height: 56, // Set height as per your need
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0)
        ),
        boxShadow: [
           BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1.0,
            blurRadius: 30.0,
          )
        ]
      ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // ignore: prefer_const_literals_to_create_immutables
              children:    [
                // ignore: prefer_const_constructors
                Expanded(
                  child: BottomTabBtn(
                    imagePath: 'assets/images/tab_home.png', 
                    onPressed: (){
                      widget.tabPressed(0);
                    }, 
                    selected: _selectedTab == 0 ? true : false,
                  ),
                ),
                // ignore: prefer_const_constructors
                Expanded(
                  child: BottomTabBtn(
                    imagePath: 'assets/images/tab_search.png', 
                    onPressed: (){
                       widget.tabPressed(1);
                    }, 
                    selected: _selectedTab == 1 ? true : false,
                    ),
                ),
                // ignore: prefer_const_constructors
                Expanded(
                  child: BottomTabBtn(
                    imagePath: 'assets/images/tab_saved.png', 
                   onPressed: (){
                     widget.tabPressed(2);
                    }, 
                  selected: _selectedTab == 2 ? true : false,
                  ),
                ),
                // ignore: prefer_const_constructors
                Expanded(
                  child: BottomTabBtn(
                    imagePath: 'assets/images/tab_logout.png', 
                     onPressed: (){
                      FirebaseAuth.instance.signOut();
                    },  
                    selected: _selectedTab == 3 ? true : false,
                    ),
                )
              ],
            ),
          );
  }
}

class BottomTabBtn extends StatelessWidget {
  const BottomTabBtn({ Key? key, required this.imagePath, required this.selected, required this.onPressed }) : super(key: key);

final String imagePath;
  final bool selected;
  final Function onPressed; 
  @override
  Widget build(BuildContext context) {
 // ignore: unused_local_variable
 bool _selected = selected;

    // ignore: avoid_unnecessary_containers
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 28.0,
          horizontal: 24.0,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              // ignore: deprecated_member_use
              color: _selected ?Theme.of(context).accentColor: Colors.transparent,
              width: 2.0,
            )
          )
        ),
        child: Image(
          image: AssetImage(
           imagePath 
            ),
            width: 22.0,
            height: 22.0,
            // ignore: deprecated_member_use
            color: _selected ? Theme.of(context).accentColor : Colors.black,
          ),
      ),
    );
  }
}