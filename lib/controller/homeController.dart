import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/user_model.dart';

class Homectrl extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  RxString? name = ''.obs;
  RxString? email = ''.obs;
  RxString? id = ''.obs;
  RxString? image = ''.obs;
  @override
  void onInit() {
    super.onInit();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      name!.value = loggedInUser.name!;
      email!.value = loggedInUser.email!;
      image!.value = loggedInUser.image!;
      id!.value = loggedInUser.uid!;
      final store = GetStorage();
      print("adsgfgdsafg");
      
      print(image!.value);
     

      store.write('user', loggedInUser.uid!);
    });
  }
}
