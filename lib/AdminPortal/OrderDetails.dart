import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  String OrderID;
  OrderDetails(this.OrderID,{super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    CollectionReference ordersRef = FirebaseFirestore.instance.collection('orders');
    return SafeArea(
        child: Scaffold(
          body: StreamBuilder(
              stream: ordersRef.snapshots(),
              builder:(context,snapshot){
                if(snapshot.hasData){
                  final targetDocument = snapshot.data?.docs.firstWhere((doc) => doc.id == widget.OrderID);
                  final Order = targetDocument?['OrderItems'];
                  final Restro = targetDocument?['Restaurant'];
                  final OrderTime = (targetDocument?['TimeStamp'] as Timestamp).toDate();
                  String OrderTimeFormatted =
                      "${OrderTime.day}/"+ "${OrderTime.month}/"+ "${OrderTime.year}"+
                      " ${OrderTime.hour}:"+ "${OrderTime.minute}";

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed:(){
                                    Navigator.pop(context);
                                  } ,
                                  icon: Icon(Icons.arrow_back_outlined),
                                ),
                                const SizedBox(width: 10,),
                                Text(
                                  "Order Details",
                                  style: TextStyle(
                                      fontSize: 20
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width-40,
                              height: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey.shade300
                                  )
                              ),
                              child: ListView.separated(
                                  itemBuilder:(context,index){
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ItemTile(context,index,Order),
                                    );
                                  } ,
                                  separatorBuilder:(context,index)=>SizedBox(height: 10,),
                                  itemCount: Order.length
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 15,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Order Confirmed",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18
                                              ),
                                            ),
                                            Text(
                                                "At $OrderTimeFormatted"
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width-40,
                              height: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey.shade300
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: NetworkImage(Restro['photo']),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            "Restaurant - "
                                        ),
                                        Text(
                                          Restro['name'],
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            "ID - "
                                        ),
                                        Text(
                                            Restro['id'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );

                }
                else if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                else{
                  return Center(
                    child: Text(
                      "No Data Found",
                      style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                  );
                }

              }
          ),
        )
    );
  }

  Widget ItemTile(BuildContext context,int index,List Order){
    return Container(
      height: 122,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        Order[index]['item']['photo']
                    )
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Container(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Order[index]['item']['name'],
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                  Text(
                    "${Order[index]['item']['Quantity']} item",
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  Text(
                    "${Order[index]['item']['price']*Order[index]['item']['Quantity']}",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
