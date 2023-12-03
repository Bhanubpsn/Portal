import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restro_portal/RestroPortal/resources/StorageMethod.dart';
import '../resources/PickImage.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  Uint8List? _image;
  final ScaffoldKey = GlobalKey<ScaffoldState>();
  int option = 1;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  var Stream = 'restroRequests';



  Future<bool> checkIfDocExists(String docId) async {
    try {
      var collectionRef = _firestore.collection('restaurants');
      var doc = await collectionRef.doc(docId).get();
    return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  void checkIfVerified()async{
    bool verified = await checkIfDocExists(firebaseUser!.email!);
    if(verified){
      setState(() {
        Stream = 'restaurants';
      });
    }
    else{
      setState(() {
        Stream = 'restroRequests';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkIfVerified();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection("restroRequests").snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        else{
          print(firebaseUser?.email);
          var restrodata = snapshot.data?.docs.firstWhere(
                  (doc) => doc.id == firebaseUser?.email,);
          // print(restrodata?['email']);
        return Scaffold(
            resizeToAvoidBottomInset: false,
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
                        option = 1;
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
                        option = 2;
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
                          "Edit Restaurant Info",
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
                        option = 3;
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
                          "Add/Edit Food Items",
                          style: TextStyle(
                            fontFamily: 'JosefinSans',
                            color: Colors.white,

                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
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
                      child: (restrodata?['isVerified']) ?
                      const Row(
                        children: [
                          Icon(Icons.verified,color: Colors.green,),
                          Text(
                            "Verified",
                            style: TextStyle(
                                fontFamily: 'JosefinSans',
                                color: Colors.white
                            ),
                          )
                        ],
                      ) :
                      const Row(
                        children: [
                          Icon(Icons.close,color: Colors.red,),
                          Text(
                            "Not Verified",
                            style: TextStyle(
                                fontFamily: 'JosefinSans',
                                color: Colors.white
                            ),
                          )
                        ],
                      )
                    ),
                  ),

                ],
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: const Text(
                "Thaiseva - RestroPortal",
                style: TextStyle(
                  fontFamily: 'JosefinSans',
                ),
              ),
              centerTitle: true,
            ),
            body: menu(option,context)
        );}
      },
    );
  }



  Widget menu(int option,BuildContext context){
    if(option == 1){
      return Center(
        child: Text(
          "Welcome To Restaurant Portal Of Thaiseva",
          style: TextStyle(
              fontFamily: 'JosefinSans',
              fontSize: 22
          ),
        ),
      );
    }
    else if(option == 2){
      return Center(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(child: EditRestroInfo(context)),
      ));
    }
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AddItem(context),
        )
    );
  }



  // Editing Restaurant Info

  void selectImage()async{
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      if(im != null){
        _image = im;
        ImageWidget = Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: Colors.grey,
                  width: 3
              ),
            image: DecorationImage(
              fit: BoxFit.fill,
                image: MemoryImage(
                  _image!,
                )
            )
          ),


        );
      }

    });
  }

  Widget ImageWidget = Container(
    height: 200,
    width: 200,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Colors.grey,
            width: 3
        )
    ),
    child: Center(
        child: Text(
          "Add Photo",
          style: TextStyle(
              fontFamily: "JosefinSans",
              fontSize: 20
          ),
        )
    ),

  );



  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController keywordController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Widget EditRestroInfo(BuildContext context){

    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Colors.deepPurple,
                  ),
                ),
                alignLabelWithHint: true,
                labelText: "Restro name",
                labelStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Colors.deepPurple,
                  ),
                ),
                alignLabelWithHint: true,
                labelText: "Address",
                labelStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Colors.deepPurple,
                  ),
                ),
                alignLabelWithHint: true,
                labelText: "Description",
                labelStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: keywordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Colors.deepPurple,
                    ),
                  ),
                  alignLabelWithHint: true,
                  labelText: "Keywords",
                  labelStyle: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "Three Keywords Separated with ."
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: idController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Colors.deepPurple,
                  ),
                ),
                alignLabelWithHint: true,
                labelText: "Restro ID",
                labelStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          InkWell(
              onTap: (){
                selectImage();
              },
              child: ImageWidget
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.all(16.0)
                ),
                onPressed: ()async {
                  if(nameController.text.isNotEmpty &&
                     descriptionController.text.isNotEmpty &&
                     idController.text.isNotEmpty &&
                     addressController.text.isNotEmpty &&
                     keywordController.text.isNotEmpty
                  ){
                    print("Saving");
                    String filename = "${firebaseUser?.email}+Restrophoto";
                    String url = await StorageMethods().uploadImageToStorage('${firebaseUser?.email}',filename, _image!);

                    _firestore.collection(Stream).doc(firebaseUser?.email).update({
                      'name' : nameController.text,
                      'description' : descriptionController.text,
                      'id' : idController.text,
                      'keywords' : keywordController.text,
                      'address' : addressController.text,
                      'photo' : url
                    });

                    const snackBar = SnackBar(
                      content: Text('Info Edited Successfully!'),
                      backgroundColor: Colors.green,
                      duration: Duration(
                          seconds: 1
                      ),
                      dismissDirection: DismissDirection.up,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    setState(() {
                      option = 1;
                    });

                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.white
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.all(16.0)
                ),
                onPressed: () {
                  setState(() {
                    option = 1;
                  });
                },
                child: const Text(
                  "Back",
                  style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.white
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  TextEditingController ItemNameController = TextEditingController();
  TextEditingController ItemIDController = TextEditingController();
  TextEditingController ItemTypeController = TextEditingController();
  TextEditingController ItemPriceController = TextEditingController();
  TextEditingController ItemDescriptionController = TextEditingController();


  Widget AddItem(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: TextFormField(
              controller: ItemNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Colors.deepPurple,
                  ),
                ),
                alignLabelWithHint: true,
                labelText: "Item name",
                labelStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: ItemTypeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Colors.deepPurple,
                  ),
                ),
                alignLabelWithHint: true,
                labelText: "Item Type",
                labelStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
                hintText: "Veg or NonVeg"
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: ItemPriceController,
              keyboardType: TextInputType.numberWithOptions(signed: false,decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Colors.deepPurple,
                  ),
                ),
                alignLabelWithHint: true,
                labelText: "Price",
                labelStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: ItemDescriptionController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Colors.deepPurple,
                    ),
                  ),
                  alignLabelWithHint: true,
                  labelText: "Description",
                  labelStyle: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: ItemIDController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Colors.deepPurple,
                  ),
                ),
                alignLabelWithHint: true,
                labelText: "Item ID",
                labelStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          InkWell(
              onTap: (){
                selectImage();
              },
              child: ImageWidget
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.all(16.0)
                ),
                onPressed: ()async {
                  if(ItemNameController.text.isNotEmpty &&
                      ItemDescriptionController.text.isNotEmpty &&
                      ItemIDController.text.isNotEmpty &&
                      ItemPriceController.text.isNotEmpty &&
                      ItemTypeController.text.isNotEmpty
                  ){
                    print("Saving");
                    String filename = "${firebaseUser?.email}+${ItemIDController.text}";
                    String url = await StorageMethods().uploadImageToStorage('${firebaseUser?.email}/items',filename, _image!);

                    _firestore.collection(Stream).doc(firebaseUser?.email).set({
                      'items' : FieldValue.arrayUnion([
                        {
                          'name' : ItemNameController.text,
                          'type' : ItemTypeController.text,
                          'description' : ItemDescriptionController.text,
                          'photo' : url,
                          'price' : double.parse(ItemPriceController.text),
                          'id' : ItemIDController.text,
                        }
                      ])
                    },SetOptions(merge: true));

                    const snackBar = SnackBar(
                      content: Text('Item Added Successfully!'),
                      backgroundColor: Colors.green,
                      duration: Duration(
                        seconds: 1
                      ),
                      dismissDirection: DismissDirection.up,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    setState(() {
                      option = 1;
                    });
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.white
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.all(16.0)
                ),
                onPressed: () {
                  setState(() {
                    option = 1;
                  });
                },
                child: const Text(
                  "Back",
                  style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.white
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }






}
