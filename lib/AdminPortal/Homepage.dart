
import 'package:flutter/material.dart';
import 'package:restro_portal/AdminPortal/OrdersReview.dart';

import 'AcceptedRestros.dart';
import 'RestroList.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {

  final ScaffoldKey = GlobalKey<ScaffoldState>();
  int menuOption = 1;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(25),),
        ),
        backgroundColor: Colors.deepPurple.withOpacity(0.5),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  menuOption = 1;
                });
              },
              child: Container(
                height: 55,
                color: Colors.deepPurple,
                child: Center(
                  child: Text(
                    "ThaiSeva",
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                setState(() {
                  menuOption = 2;
                });
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepPurple,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 3),
                      blurRadius: 5,
                      color: Colors.black
                    )
                  ]
                ),
                child: Center(
                  child: Text(
                    "Restaurant Requests",
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      color: Colors.white,

                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                setState(() {
                  menuOption = 3;
                });
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurple,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 3),
                          blurRadius: 5,
                          color: Colors.black
                      )
                    ]
                ),
                child: Center(
                  child: Text(
                    "Accepted Restaurant",
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      color: Colors.white,

                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                setState(() {
                  menuOption = 4;
                });
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurple,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 3),
                          blurRadius: 5,
                          color: Colors.black
                      )
                    ]
                ),
                child: Center(
                  child: Text(
                    "Orders Review",
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      color: Colors.white,

                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title:const Text(
          "Admin Portal",
          style: TextStyle(
            fontFamily: 'JosefinSans',
            fontWeight: FontWeight.w400,
            fontSize: 25
          ),
        ),
        actions: [
          IconButton(
              onPressed:() {
                ScaffoldKey.currentState?.openDrawer();
              },
              icon: Icon(Icons.menu)
          )
        ],
      ),
      body: Menu(menuOption),
    );
  }


  Widget Menu(int option){
    if(option == 1){
      return Container(
        child: Center(
          child: Text(
            "Welcome to Thaiseva\n    Admin Portal",
            style: TextStyle(
              fontFamily: 'JosefinSans',
              fontSize: 25,
            ),
          ),
        ),
      );
    }
    else if(option == 2){
      return RestroList();
    }
    else if(option == 3){
      return AcceptedRestro();
    }
    else if(option == 4){
      return OrdersReview();
    }
    return Container();
  }



}
