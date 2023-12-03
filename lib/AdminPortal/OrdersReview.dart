import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restro_portal/AdminPortal/OrderDetails.dart';

class OrdersReview extends StatefulWidget {
  const OrdersReview({Key? key}) : super(key: key);

  @override
  State<OrdersReview> createState() => _OrdersReviewState();
}

class _OrdersReviewState extends State<OrdersReview> {
  @override
  Widget build(BuildContext context) {
    CollectionReference reviewRef =
    FirebaseFirestore.instance.collection('reviews');
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: const Text(
            "Orders Review",
            style: TextStyle(
                fontFamily: 'JosefinSans',
                fontWeight: FontWeight.w400,
                fontSize: 25),
          ),
        ),
        body: StreamBuilder(
            stream: reviewRef.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final allReviews = snapshot.data?.docs;

                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      var reviewData = allReviews?[index].data() as Map<String, dynamic>;
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            OrderDetails(reviewData['orderId'])
                          ));
                        },
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text(
                                "Order ID - ${reviewData['orderId']}"+
                                    " Rating - ${reviewData['rating'].toString()}/5.0  "
                            ),
                            subtitle: Text(
                                "Comment - ${reviewData['comment']}"
                            ),
                            trailing:
                                IconButton(
                                    onPressed:(){
                                      reviewRef
                                          .doc(reviewData['orderId'])
                                          .delete()
                                          .then((_) => print('Deleted'))
                                          .catchError((error) => print('Delete failed: $error'));
                                    } ,
                                    icon: Icon(Icons.delete_forever,color: Colors.red,)
                                )
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: allReviews?.length ?? 0,
                  ),
                );
              } else  if(snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              else{
                return Center(
                  child: Text(
                    "No Reviews."
                  ),
                );
              }
            }),
      ),
    );
  }
}
