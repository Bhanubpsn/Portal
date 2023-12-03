import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restro_portal/AdminPortal/IndividualRestaurant.dart';

class RestroList extends StatefulWidget {
  const RestroList({super.key});

  @override
  State<RestroList> createState() => _RestroListState();
}

class _RestroListState extends State<RestroList> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List RestaurantList = [];

  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('restroRequests');

  Future<void> getData() async {
    print("All Restros--");
    QuerySnapshot querySnapshot = await _collectionRef.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      RestaurantList = allData;
    });
    // print(allData);
  }


  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
            itemBuilder:(_,index){
              return Card(
                elevation: 5,
                child: ListTile(
                  title: Text(
                      RestaurantList[index]['name'],
                      style: TextStyle(
                        fontFamily: "JosefinSans",
                      ),
                  ),
                  subtitle: Text(
                    RestaurantList[index]['address'],
                    style: TextStyle(
                      fontFamily: "JosefinSans",
                    ),
                  ),
                  trailing: Container(
                    width: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                Individualpage(RestaurantList[index])
                              ));
                            } ,
                            child: Text("View")
                        ),
                        ElevatedButton(
                            onPressed:(){

                              _firestore.collection("restroRequests").doc(RestaurantList[index]['email']).delete();

                              _firestore.collection('restaurants').doc(RestaurantList[index]['email']).set({
                                'name' : RestaurantList[index]['name'],
                                'address' : RestaurantList[index]['address'],
                                'description' : RestaurantList[index]['description'],
                                'photo' : RestaurantList[index]['photo'],
                                'id' : RestaurantList[index]['id'],
                                'items' : RestaurantList[index]['items'],
                                'isVerified' : true,
                                'keywords' : RestaurantList[index]['keywords'],
                                'email' : RestaurantList[index]['email'],
                              });

                              setState(() {
                                RestaurantList.removeAt(index);
                              });
                            } ,
                            child: Text("Accept")
                        ),
                        ElevatedButton(
                            onPressed:(){
                              _firestore.collection("restroRequests").doc(RestaurantList[index]['email']).delete();
                              setState(() {
                                RestaurantList.removeAt(index);
                              });
                            } ,
                            child: Text("Reject")
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder:(_,index) {
              return const SizedBox(height: 10,);
            },
            itemCount: RestaurantList.length
        )
      ),
    );
  }
}
