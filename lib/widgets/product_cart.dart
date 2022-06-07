import 'package:ecomerce/constants.dart';
import 'package:ecomerce/screens/product_page.dart';
import 'package:flutter/material.dart';


class ProductCart extends StatelessWidget {
  const ProductCart({ Key? key,   required this.imageUrl, required this.title, required this.productId, required this.price,}) : super(key: key);

final String productId;
  // final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProductPage(productId: productId,),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 350.0,
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              height: 350.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  // ignore: unnecessary_string_interpolations
                  "$imageUrl",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Constants.regularheading,
                    ),
                    Text(
                      price,
                      style: TextStyle(
                          fontSize: 18.0,
                          // ignore: deprecated_member_use
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ); 
    
  }
}