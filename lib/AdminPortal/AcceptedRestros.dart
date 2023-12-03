import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restro_portal/AdminPortal/IndividualRestaurant.dart';


class AcceptedRestro extends StatefulWidget {
  const AcceptedRestro({super.key});

  @override
  State<AcceptedRestro> createState() => _AcceptedRestroState();
}

class _AcceptedRestroState extends State<AcceptedRestro> {

  List RestaurantList = [];

  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('restaurants');

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
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      Individualpage(RestaurantList[index])
                    ));
                  },
                  child: Card(
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
