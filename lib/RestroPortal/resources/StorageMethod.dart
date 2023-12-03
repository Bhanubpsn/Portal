import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  Future<String> uploadImageToStorage(String path, String filename, Uint8List file)async{

    Reference ref = _storage.ref().child(path).child(filename);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }

}