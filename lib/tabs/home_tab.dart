// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: unused_import
// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/constants.dart';
import 'package:ecomerce/screens/product_page.dart';
import 'package:ecomerce/services/firebase_services.dart';
import 'package:ecomerce/widgets/custom_action_bar.dart';
import 'package:ecomerce/widgets/product_cart.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {

  final CollectionReference _productsRef = 
     FirebaseFirestore.instance.collection("Products");
   HomeTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return  Container(
                 child: Stack(
                   children:  [
                     FutureBuilder<QuerySnapshot<Object?>>(
                       future: _productsRef.get(),
                       builder: (context, snapshot){
                           if(snapshot.hasError){
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"
                    ),
                  ),
                );
                       }

                // collection data ready to display
                if(snapshot.connectionState == ConnectionState.done){
                    // display the data inside a list view
                    return ListView(
                      padding: const EdgeInsets.only(
                        top: 80.0,
                        bottom: 24.0,
                      ),
                      children: snapshot.data!.docs.map((document) {


                        // ignore: avoid_unnecessary_containers
                        return ProductCart(
                          imageUrl: document['images'][0], 
                          price: "", 
                           productId: document.id, 
                          title: document['name'],
                          );
                      }
                      ).toList(),
                    );
                }



                      //loading state
                       return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                    ),
                  );
                
                       }

                       ),
                     
                     
                     const CustomActionBar(
                       title: "Home",
                       hasTitle: true,
                       hasBackground: true, 
                       hasBackArrrow: false,
                     ),
                   ],
                 ),

                
    );
  }
}