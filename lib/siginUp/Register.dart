import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restro_portal/RestroPortal/Homepage/homepage.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

void registerUser(BuildContext context, email, password) async {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(child: CircularProgressIndicator());
    },
  );
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _firestore.collection('restroRequests').doc(email).set({
      'name' : "",
      'description' : "",
      'id' : "",
      'keywords' : "",
      'photo' : "",
      'items' : [],
      'address' : "",
      'isVerified' : false,
      'email' : email,
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage()));
    print("Succes");
  } on FirebaseAuthException catch (e) {

    Navigator.pop(context);
    if (e.code == 'weak-password') {
      wrongMessage('Password is too weak.', context);
    } else if (e.code == 'email-already-in-use') {
      wrongMessage('Account already exists.', context);
    }
    else{
      wrongMessage('Invalid Email', context);
    }

  } catch (e) {
    Navigator.pop(context);
    print(e);
    wrongMessage("Enter valid email", context);
  }
}
void wrongMessage(String s, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(s),
      );
    },
  );
}

void signUserIn(String email, String password, BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(child: CircularProgressIndicator());
    },
  );
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Homepage()));

  } on FirebaseAuthException catch (e) {
    Navigator.pop(context); // Close the loading dialog
    if (e.code == 'user-not-found') {
      wrongMessage2(context);
    } else if (e.code == 'wrong-password') {
      wrongMessage2(context);
    } else {
      wrongMessage2(context);
    }
  }
}
void wrongMessage2(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        title: Text("Invalid credential"),
      );
    },
  );
}