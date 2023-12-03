import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Individualpage extends StatefulWidget {
  Map<String, dynamic> RestroDetails;
  Individualpage(this.RestroDetails, {Key? key}) : super(key: key);

  @override
  State<Individualpage> createState() => _IndividualpageState();
}

class _IndividualpageState extends State<Individualpage> {
  List<String> items = [
    'images/itemimage/img_1.png', // Replace with your image paths or URLs
    'images/itemimage/img_2.png',
    'images/itemimage/img_3.png',
    'images/itemimage/img_3.png',
    'images/itemimage/img_3.png',
  ];

  List Allitems = [];
  int totalItems = 0;
  bool All = true;
  bool veg = false;
  bool non_veg = false;
  double totalprice = 0;

  Widget vegToggle(){
    if(veg){
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Container(
              width: 40,
              height: 16,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.green.shade400
              ),
            ),
          ),
          Container(
              width: 20,
              height: 20,
              child: Image.asset(
                'images/carasoulimage/img_3.png',
              )),

        ],
      );

    }
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Container(
              width: 20,
              height: 20,
              child: Image.asset(
                'images/carasoulimage/img_3.png',
              )),
        ),
        Container(
          width: 40,
          height: 16,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0xffE6E6E6)
          ),
        )
      ],
    );

  }
  Widget nonvegToggle(){
    if(non_veg){
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Container(
              width: 40,
              height: 16,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.red.shade400
              ),
            ),
          ),
          Container(
              width: 20,
              height: 20,
              child: Image.asset(
                'images/carasoulimage/img_4.png',
              )),

        ],
      );

    }
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Container(
              width: 20,
              height: 20,
              child: Image.asset(
                'images/carasoulimage/img_4.png',
              )),
        ),
        Container(
          width: 40,
          height: 16,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0xffE6E6E6)
          ),
        )
      ],
    );

  }


  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      Allitems = widget.RestroDetails['items'];
      totalItems = Allitems.length;
      for (int i = 0; i < totalItems; i++) {
        Allitems[i]['Quantity'] = 0;
      }
    });
    super.initState();
  }

  var search = '';

  bool SearchInRestro(String name, Map item) {
    List itemName = name.split(' ');
    itemName = itemName.map((element) => element.toLowerCase()).toList();

    List itemMatch = item['name'].split(' ');
    itemMatch = itemMatch.map((element) => element.toLowerCase()).toList();

    bool found = true;
    for (int i = 0; i < itemName.length; i++) {
      if (!itemMatch.contains(itemName[i])) {
        found = false;
      }
    }
    if (found) {
      return true;
    } else {
      List itemDesc = item['description'].split(' ');
      itemDesc = itemDesc.map((element) => element.toLowerCase()).toList();

      found = true;
      for (int i = 0; i < itemName.length; i++) {
        if (itemDesc.contains(itemName[i])) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                    itemBuilder: (_, index) {
                      return restroItems(context, index);
                    },
                    separatorBuilder: (_, index) {
                      return const SizedBox(
                        height: 0,
                      );
                    },
                    itemCount: 6 + totalItems)
            ),
          ]),
    );
  }

  Widget restroItems(BuildContext context, int index) {
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.only(bottom:20.0,left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
    else if (index == 1) {
      return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top:20.0,bottom:20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 26.0),
                  child: Container(
                    width: 90,
                    height: 90,
                    child: Image.network(
                      widget.RestroDetails['photo'],
                    ),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.RestroDetails['name'],
                    style: TextStyle(fontSize: 26),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.green,Colors.green.shade900],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter
                            ),

                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        width: 40,
                        height: 20,
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 10,
                            ),
                            Text(
                              "4.3+",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("(100+)", style: TextStyle(fontSize: 16))
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.RestroDetails['keywords'],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.RestroDetails['address'],
                          style: TextStyle(fontSize: 14)),
                      Icon(Icons.circle, size: 5, color: Colors.black26),
                      Text("30 min away",
                          style: TextStyle(fontSize: 14, color: Colors.black26))
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      _showFoodMenu(context);
                    },
                    child: Container(
                      width: 140,
                      height: 40,
                      child: Center(
                          child: Text("View All Menu",
                              style: TextStyle(fontSize: 17))),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlue, width: 1),
                        borderRadius: BorderRadius.circular(15.0),
                        //color: Colors.lightBlue
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }
    else if (index == 3) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: InkWell(
              onTap: () {},
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search for dishes",
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.transparent), // Make the border invisible
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.transparent), // Make the border invisible
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )),
      );
    }
    else if (index == 4) {
      return Padding(
        padding: const EdgeInsets.only(bottom:14.0),
        child: Container(
          color : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        All = true;
                        veg = false;
                        non_veg = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(79, 40), // Set the minimum width and height
                      padding: EdgeInsets.all(8), // Set padding to increase button size
                      textStyle: TextStyle(
                        fontSize: 20, // Set text size
                      ),
                      backgroundColor: Color(0xff67A5F8),
                    ),
                    child: Center(child: Text("All"))),
                InkWell(
                  onTap: () {
                    setState(() {
                      All = false;
                      veg = true;
                      non_veg = false;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.black26)),
                      width: 79,
                      height: 40,
                      child: vegToggle()
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      All = false;
                      veg = false;
                      non_veg = true;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.black26)),
                      width: 79,
                      height: 40,
                      child: nonvegToggle()
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    else if (index >= 5 && index < totalItems+5) {
      if (search == '') {
        if (All) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15,bottom:15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 10) / 2.7,
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      Allitems[index - 5]['type'].toString().toLowerCase()[0] == 'v' ?
                                      'images/carasoulimage/img_3.png' :
                                      'images/carasoulimage/img_4.png',
                                    ))),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            width: ((MediaQuery.of(context).size.width - 10) / 2),
                            child: Text(
                              Allitems[index - 5]['name'],
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            width: (MediaQuery.of(context).size.width - 10) / 4.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    width: 27,
                                    height: 27,
                                    child: Image.asset(
                                        'images/carasoulimage/img_5.png')),
                                Text(
                                  Allitems[index - 5]['price'].toString(),
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.green,
                              ),
                              Text(
                                " 4.3 ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(" (22) ",
                                  style: TextStyle(
                                      color: Colors.black26, fontSize: 18))
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          InkWell(
                            onTap: () {
                              _showDetails(context, Allitems[index - 5]);
                            },
                            child: Container(
                              width: (MediaQuery.of(context).size.width - 10) / 3.7,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Colors.black26,
                                  )
                              ),
                              child: Center(child: Text("Know More")),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width) / 2,
                              height: 200,
                              child: Column(
                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width) / 2,
                                    height: 175,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              Allitems[index - 5]['photo'],
                                            )
                                        )
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (veg) {
          if (Allitems[index - 5]['type'].toString().toLowerCase()[0] == 'v') {
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15,bottom:15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 10) / 2.7,
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        Allitems[index - 5]['type'].toString().toLowerCase()[0] == 'v' ?
                                        'images/carasoulimage/img_3.png' :
                                        'images/carasoulimage/img_4.png',
                                      ))),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              width:
                              ((MediaQuery.of(context).size.width - 10) / 2),
                              child: Text(
                                Allitems[index - 5]['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              width:
                              (MediaQuery.of(context).size.width - 10) / 4.5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 27,
                                      height: 27,
                                      child: Image.asset(
                                          'images/carasoulimage/img_5.png')),
                                  Text(
                                    Allitems[index - 5]['price'].toString(),
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                Text(
                                  " 4.3 ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(" (22) ",
                                    style: TextStyle(
                                        color: Colors.black26, fontSize: 18))
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            InkWell(
                              onTap: () {
                                _showDetails(context, Allitems[index - 5]);
                              },
                              child: Container(
                                width: (MediaQuery.of(context).size.width - 10) /
                                    3.7,
                                height: 30,
                                child: Center(child: Text("Know More")),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Colors.black26,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: (MediaQuery.of(context).size.width) / 2,
                                height: 200,
                                child: Column(
                                  children: [
                                    Container(
                                      width: (MediaQuery.of(context).size.width) / 2,
                                      height: 175,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                Allitems[index - 5]['photo'],
                                              )
                                          )
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          else {
            return Container();
          }
        }
        if (non_veg) {
          if (Allitems[index - 5]['type'].toString().toLowerCase()[0] == 'n') {
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 10) / 2.7,
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        Allitems[index - 5]['type'].toString().toLowerCase()[0] == 'v' ?
                                        'images/carasoulimage/img_3.png' :
                                        'images/carasoulimage/img_4.png',
                                      ))),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              width:
                              ((MediaQuery.of(context).size.width - 10) / 2),
                              child: Text(
                                Allitems[index - 5]['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              width:
                              (MediaQuery.of(context).size.width - 10) / 4.5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 27,
                                      height: 27,
                                      child: Image.asset(
                                          'images/carasoulimage/img_5.png')),
                                  Text(
                                    Allitems[index - 5]['price'].toString(),
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                Text(
                                  " 4.3 ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(" (22) ",
                                    style: TextStyle(
                                        color: Colors.black26, fontSize: 18))
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            InkWell(
                              onTap: () {
                                _showDetails(context, Allitems[index - 5]);
                              },
                              child: Container(
                                width: (MediaQuery.of(context).size.width - 10) /
                                    3.7,
                                height: 30,
                                child: Center(child: Text("Know More")),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Colors.black26,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: (MediaQuery.of(context).size.width) / 2,
                                height: 200,
                                child: Column(
                                  children: [
                                    Container(
                                      width: (MediaQuery.of(context).size.width) / 2,
                                      height: 175,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                Allitems[index - 5]['photo'],
                                              )
                                          )
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          else {
            return Container();
          }
        }
      }
      else {
        if (SearchInRestro(search, Allitems[index - 5])) {
          if (All) {
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15,bottom:15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration : BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 10) / 2.7,
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        Allitems[index - 5]['type'].toString().toLowerCase()[0] == 'v' ?
                                        'images/carasoulimage/img_3.png' :
                                        'images/carasoulimage/img_4.png',
                                      ))),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              width:
                              ((MediaQuery.of(context).size.width - 10) / 2),
                              child: Text(
                                Allitems[index - 5]['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              width:
                              (MediaQuery.of(context).size.width - 10) / 4.5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 27,
                                      height: 27,
                                      child: Image.asset(
                                          'images/carasoulimage/img_5.png')),
                                  Text(
                                    Allitems[index - 5]['price'].toString(),
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                Text(
                                  " 4.3 ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(" (22) ",
                                    style: TextStyle(
                                        color: Colors.black26, fontSize: 18))
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            InkWell(
                              onTap: () {
                                _showDetails(context, Allitems[index - 5]);
                              },
                              child: Container(
                                width: (MediaQuery.of(context).size.width - 10) /
                                    3.7,
                                height: 30,
                                child: Center(child: Text("Know More")),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Colors.black26,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: (MediaQuery.of(context).size.width) / 2,
                                height: 200,
                                child: Column(
                                  children: [
                                    Container(
                                      width: (MediaQuery.of(context).size.width) / 2,
                                      height: 175,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                Allitems[index - 5]['photo'],
                                              )
                                          )
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (veg) {
            if (Allitems[index - 5]['type'].toString().toLowerCase()[0] == 'v') {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15,bottom:15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  decoration : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width - 10) / 2.7,
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          Allitems[index - 5]['type'].toString().toLowerCase()[0] == 'v' ?
                                          'images/carasoulimage/img_3.png' :
                                          'images/carasoulimage/img_4.png',
                                        ))),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                width: ((MediaQuery.of(context).size.width - 10) /
                                    2),
                                child: Text(
                                  Allitems[index - 5]['name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                width: (MediaQuery.of(context).size.width - 10) /
                                    4.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 27,
                                        height: 27,
                                        child: Image.asset(
                                            'images/carasoulimage/img_5.png')),
                                    Text(
                                      Allitems[index - 5]['price'].toString(),
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    " 4.3 ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(" (22) ",
                                      style: TextStyle(
                                          color: Colors.black26, fontSize: 18))
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              InkWell(
                                onTap: () {
                                  _showDetails(context, Allitems[index - 5]);
                                },
                                child: Container(
                                  width:
                                  (MediaQuery.of(context).size.width - 10) /
                                      3.7,
                                  height: 30,
                                  child: Center(child: Text("Know More")),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                        color: Colors.black26,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width) / 2,
                                  height: 200,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: (MediaQuery.of(context).size.width) / 2,
                                        height: 175,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  Allitems[index - 5]['photo'],
                                                )
                                            )
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            else {
              return Container();
            }
          }
          if (non_veg) {
            if (Allitems[index - 5]['type'].toString().toLowerCase()[0] == 'n') {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15,bottom:15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  decoration : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width - 10) / 2.7,
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          Allitems[index - 5]['type'].toString().toLowerCase()[0] == 'v' ?
                                          'images/carasoulimage/img_3.png' :
                                          'images/carasoulimage/img_4.png',
                                        ))),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                width: ((MediaQuery.of(context).size.width - 10) /
                                    2),
                                child: Text(
                                  Allitems[index - 5]['name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                width: (MediaQuery.of(context).size.width - 10) /
                                    4.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 27,
                                        height: 27,
                                        child: Image.asset(
                                            'images/carasoulimage/img_5.png')),
                                    Text(
                                      Allitems[index - 5]['price'].toString(),
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    " 4.3 ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(" (22) ",
                                      style: TextStyle(
                                          color: Colors.black26, fontSize: 18))
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              InkWell(
                                onTap: () {
                                  _showDetails(context, Allitems[index - 5]);
                                },
                                child: Container(
                                  width:
                                  (MediaQuery.of(context).size.width - 10) /
                                      3.7,
                                  height: 30,
                                  child: Center(child: Text("Know More")),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                        color: Colors.black26,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width) / 2,
                                  height: 200,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: (MediaQuery.of(context).size.width) / 2,
                                        height: 175,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  Allitems[index - 5]['photo'],
                                                )
                                            )
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }
        }
        else {
          return Container();
        }
      }
    }

    return Container(
      height: 50,
    );
  }

  void _showFoodMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(27))),
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height *
              1.5 /
              3, // Adjust the height as needed
          child: ListView(
            children: <Widget>[
              ListTile(
                  title: InkWell(
                    onTap: () {
                      //recommended dishes with rating more than 4
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recommended',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          '20',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  )),
              ListTile(
                  title: InkWell(
                    onTap: () {
                      //recommended dishes with item name chicken pizza
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Chicken Pizza',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  )),
              ListTile(
                  title: InkWell(
                    onTap: () {
                      //recommended dishes with item name chicken pizza
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Veg Pizza',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          '20',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  )),
              ListTile(
                  title: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cake',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          '12',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  )),
              ListTile(
                  title: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cold Drinks',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          '20',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  )),
              // ListTile(title: InkWell(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text('Cold Drinks',style: TextStyle(fontSize: 17,),),
              //       Text('20',style: TextStyle(fontSize: 17,),),
              //     ],
              //   ),
              // )),
              ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Paasta',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        '0',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  )),

              // Add more food items as needed
            ],
          ),
        );
      },
    );
  }

  void _showDetails(BuildContext context, Map item) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(27))),
      builder: (BuildContext context) {
        return Stack(alignment: Alignment.topRight, children: [
          Container(
            // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height *2 /2.5,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft:
                    Radius.circular(27.0), // Adjust the radius as needed
                    topRight:
                    Radius.circular(27.0), // Adjust the radius as needed
                  ),
                  child: Image.network(item['photo'],
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 200),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Column(
                    children: [
                      Row(children: [
                        if (item['type'].toString()[0].toLowerCase() == 'v')
                          Image.asset('images/carasoulimage/img_3.png',
                              width: 26, height: 26),
                        if (item['type'].toString()[0].toLowerCase() == 'n')
                          Image.asset('images/carasoulimage/img_4.png',
                              width: 26, height: 26),
                      ]),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 14),
                                width: MediaQuery.of(context).size.width / 2,
                                height: 60,
                                child: Text(
                                  item['name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 27,
                                      height: 27,
                                      child: Image.asset(
                                          'images/carasoulimage/img_5.png')),
                                  Text(
                                    item['price'].toString(),
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 7.0, top: 14, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                item['description'],
                                style: TextStyle(color: Colors.black26),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
                // Add more food items as needed
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton.small(
              onPressed: () {
                // Add your action here
                Navigator.of(context).pop(); // Close the bottom sheet
              },
              child: Icon(Icons.close,color: Colors.black,size: 25,),
              backgroundColor: Colors.white,
            ),
          ),
        ]);
      },
    );
  }
}
