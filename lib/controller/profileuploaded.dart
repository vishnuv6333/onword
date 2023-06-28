import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  File? image;

  String? imageUrl;
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionName = "images";
  RxString uploadpath = ''.obs;
  final store = GetStorage();

  Future openGallery(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    try {
      String uploadFilename = '${DateTime.now().millisecondsSinceEpoch}jpg';
      Reference reference =
          storageRef.ref().child(collectionName).child(uploadFilename);
      UploadTask uploadTask = reference.putFile(imageTemp);

      await uploadTask.whenComplete(() async {
        uploadpath.value = await uploadTask.snapshot.ref.getDownloadURL();
      });
      var id=store.read('user');
      await firestoreRef
          .collection("users")
          .doc(id)
          .update({"image": uploadpath.value});
      store.write('image',uploadpath.value);
    
      Fluttertoast.showToast(msg: "Profle updated Sucessfully ");
    } catch (error) {}
  }
}
