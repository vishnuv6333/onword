
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onword/screens/screens.dart';
import '../controller/homeController.dart';
import '../controller/profileuploaded.dart';
import 'package:get/get.dart';

// import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Homectrl homeControllers = Get.put(Homectrl());
  ProductController productController = Get.put(ProductController());
    final store = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               InkWell(
                  onTap: () async {
                    print("object");
                    productController.openGallery(context);
                  },
                  child: Obx(
                    ()=> SizedBox(
                        width: 70,
                        height: 150,
                        child: productController.uploadpath.value == '' &&  store.read('image')==null
                            ? Image.asset("assets/img/login.png",
                                fit: BoxFit.contain)
                            : Image.network(
                              productController.uploadpath.value==''?  store.read('image'): productController.uploadpath.value,
                              )),
                  ),
                ),
              
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Text("${homeControllers.name}",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Obx(
                () => Text("${homeControllers.email}",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              ActionChip(
                  label: const Text("Logout"),
                  onPressed: () {
                    logout(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    store.remove('user');
    
    Get.offAll(LoginScreen());
  }
}
