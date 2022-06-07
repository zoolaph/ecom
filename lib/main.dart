
import 'package:ecomerce/screens/landing_page.dart';

// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ) ,
       // ignore: deprecated_member_use
       accentColor: const Color(0xFFFF1E00)
         ),
     home: Landingpage(),
      );
      
    
  }
}

