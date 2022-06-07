import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/constants.dart';
import 'package:ecomerce/screens/cart_page.dart';
import 'package:ecomerce/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CustomActionBar extends StatefulWidget {
  const CustomActionBar({ Key? key, required this.title, required this.hasBackArrrow, required this.hasTitle, required this.hasBackground }) : super(key: key);

final String title;
  final bool hasBackArrrow;
  final bool hasTitle;
  final bool hasBackground;

  @override
  State<CustomActionBar> createState() => _CustomActionBarState();
}

class _CustomActionBarState extends State<CustomActionBar> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _usersRef = FirebaseFirestore
      .instance
      .collection("Users");

  @override
  Widget build(BuildContext context) {

    // ignore: unused_local_variable
    bool _hasBackArrow = widget.hasBackArrrow;
     // ignore: unused_local_variable
     bool _hasTitle = widget.hasTitle;
    bool _hasBackground = widget.hasBackground;

    // ignore: avoid_unnecessary_containers
    return Container(
      decoration: BoxDecoration(
        gradient: _hasBackground ? LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0),
          ],
          begin: const Alignment(0, 0),
          end: const Alignment(0, 1),
        ): null
      ),
      padding: const EdgeInsets.only(
        top: 56.0,
        left: 24.0,
        right: 24.0,
        bottom: 42.0,
      ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(_hasBackArrow)
                // ignore: avoid_unnecessary_containers
                GestureDetector(
                   onTap: () {
                Navigator.pop(context);
              },
                  child: Container(
                     width: 42.0,
                              height: 42.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                    child: const Image(
                      image: AssetImage(
                        "assets/images/back_arrow.png"
                        ),
                        color: Colors.white,
                       width: 16.0,
                    height: 16.0,
                        ),
                  ),
                ),
                if(_hasTitle)
                Text(
                  widget.title,
                  style: Constants.boldHeading,
                  ),
                  // ignore: avoid_unnecessary_containers
                  GestureDetector(
                     onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const CartPage(),
              ));
            },
                    child: Container(
                      width: 42.0,
                                height: 42.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                                  borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: StreamBuilder<QuerySnapshot>(
                         stream: _usersRef.doc(_firebaseServices.getUserId()).collection("Cart").snapshots(),
                                  builder: (context, snapshot) {
                    // ignore: unused_local_variable
                    int _totalItems = 0;
                  
                    if(snapshot.connectionState == ConnectionState.active) {
                      List _documents = snapshot.data!.docs;
                      _totalItems = _documents.length;
                    }
                  
                     return Text(
                      "$_totalItems",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    );
                                  }
                  
                        ),
                    ),
                  ),
              ],
            ),
          );
  }
}