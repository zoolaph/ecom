
// ignore: unused_import
import 'package:ecomerce/constants.dart';
import 'package:ecomerce/services/firebase_services.dart';
import 'package:ecomerce/tabs/home_tab.dart';
import 'package:ecomerce/tabs/saved_tab.dart';
import 'package:ecomerce/tabs/search_tab.dart';
import 'package:ecomerce/widgets/bottom_tabs.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

// ignore: unused_field
final FirebaseServices _firebaseServices = FirebaseServices();

  // ignore: unused_field
  late PageController _tabsPageController;
  // ignore: unused_field
  late int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ignore: avoid_unnecessary_containers
          Expanded(
            child: PageView(
              controller: _tabsPageController,
              // ignore: avoid_types_as_parameter_names
              onPageChanged: (num){
                setState(() {
                   _selectedTab = num;
                });
              },
              children:  [
                // ignore: avoid_unnecessary_containers
                HomeTab(),
                // ignore: avoid_unnecessary_containers
               const SearchTab(),
                // ignore: avoid_unnecessary_containers
                SavedTab(),
              ],
              ),
          ),
         BottomTabs(
           
           selectedTab: _selectedTab, 
           // ignore: avoid_types_as_parameter_names
           tabPressed: (num ) {
              setState(() {
                   _tabsPageController.animateToPage(
                     num, 
                     duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic
                  );
                    
                }
                );
             },
         ),
        ],
      )
    );
  }
}