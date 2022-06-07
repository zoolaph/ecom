import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:ecomerce/constants.dart';
import 'package:ecomerce/services/firebase_services.dart';
import 'package:ecomerce/widgets/custom_input.dart';
import 'package:ecomerce/widgets/product_cart.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({ Key? key }) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
   // ignore: prefer_final_fields
   FirebaseServices _firebaseServices = FirebaseServices();

    // ignore: unused_field
    String _searchString = "";

  // ignore: prefer_typing_uninitialized_variables, unused_field
 late FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers, prefer_typing_uninitialized_variables
    
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Stack(
        children: [
          if (_searchString.isEmpty)
            Center(
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: const Text(
                  "Search Results",
                  style: Constants.regularDarkText,
                ),
              ),
            )
          else
             FutureBuilder<QuerySnapshot<Object?>>(
              future: _firebaseServices.productsRef
                  .orderBy("search_string")
                  .startAt([_searchString])
                  .endAt(["$_searchString\uf8ff"])
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                // Collection Data ready to display
                if (snapshot.connectionState == ConnectionState.done) {
                  // Display the data inside a list view
                  return ListView(
                    padding: const EdgeInsets.only(
                      top: 128.0,
                      bottom: 12.0,
                    ),
                     children: snapshot.data!.docs.map((document) {


                        // ignore: avoid_unnecessary_containers
                        return ProductCart(
                          imageUrl: document['images'][0], 
                          price: "", 
                           productId: document.id, 
                          title: document['name'],
                          );
                    }).toList(),
                  );
                }

                // Loading State
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.only(
              top: 45.0,
            ),
            child: CustomInput(
             
              focusNode: _passwordFocusNode, 
              isPasswordField: false,
              onChanged: (value){}, 
              onSubmit: (value) {
                setState(() {
                  _searchString = value.toLowerCase();
                });
              }, 
              text: '"Search here..."', 
              textInputAction: TextInputAction.next,
            ),
          ),
        ],
      ),
    );
  }
}