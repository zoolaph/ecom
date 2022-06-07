import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/constants.dart';
import 'package:ecomerce/services/firebase_services.dart';
import 'package:ecomerce/widgets/custom_action_bar.dart';
import 'package:ecomerce/widgets/image_swipe.dart';
import 'package:ecomerce/widgets/product_size.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({ Key? key, required this.productId }) : super(key: key);

final String productId;
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

   // ignore: prefer_final_fields
   FirebaseServices _firebaseServices = FirebaseServices();
   // ignore: unused_field
   String _selectedProductSize = "0";

    // ignore: unused_element
    Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  // ignore: unused_element
  Future _addToSaved() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  final SnackBar _snackBar = const SnackBar(content: Text("Product added to the cart"),);

  // get imageList => null;

  // get productSizes => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Stack(
        children: [
          // ignore: avoid_unnecessary_containers
          FutureBuilder<DocumentSnapshot<Object?>>(
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (context, snapshot){
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

               if (snapshot.connectionState == ConnectionState.done){
                 // Firebase Document Data Map
                // ignore: unused_local_variable
             Map<String, dynamic> documentData = snapshot.data!.data() as Map<String, dynamic>;

                // List of images
                List imageList = documentData['images'];
                List productSizes = documentData['size'];

                // Set an initial size
                _selectedProductSize = productSizes[0];

                
                return ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    ImageSwipe(
                      imageList: imageList,
                    ),


                     Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 24.0,
                        right: 24.0,
                        bottom: 4.0,
                      ),
                      child: Text(
                        "${documentData['name']}",
                        style: Constants.boldHeading,
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "\$${documentData['price']}",
                        style: TextStyle(
                          fontSize: 18.0,
                          // ignore: deprecated_member_use
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                     Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "${documentData['desc']}",
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),

                     const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "Select Size",
                        style: Constants.regularDarkText,
                      ),
                    ),

                    ProductSize(
                      productSizes: productSizes,
                      onSelected: (size) {
                        _selectedProductSize = size;
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          // ignore: avoid_unnecessary_containers
                          GestureDetector(
                             onTap: () async {
                              await _addToSaved();
                              // ignore: deprecated_member_use
                              Scaffold.of(context).showSnackBar(_snackBar);
                            },
                            child: Container(
                              width: 65.0,
                                  height: 65.0,
                              decoration: BoxDecoration(
                                    color: const Color(0xFFDCDCDC),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  alignment: Alignment.center,
                              child: const Image(
                                image:  AssetImage(
                                      "assets/images/tab_saved.png",
                                    ),
                                    height: 22.0,
                                    ),
                            ),
                          ),
                          // ignore: avoid_unnecessary_containers
                          Expanded(
                            child: GestureDetector(
                                onTap: () async {
                                await _addToCart();
                                // ignore: deprecated_member_use
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              
                              child: Container(
                                height: 65.0,
                                margin: const EdgeInsets.only(
                                  left: 16.0,
                                ),
                                // width: double.infinity,
                                decoration:BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12.0)
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Add To Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight:FontWeight.w600,
                                  ),
                                  ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )


                  ]
                );
               }
               // Loading State
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } 
            ),
          const CustomActionBar(
            title: "Product Page",
             hasBackArrrow: false, 
             hasTitle: false, 
             hasBackground: false,
             )
      ],
      )
    );
  }
}