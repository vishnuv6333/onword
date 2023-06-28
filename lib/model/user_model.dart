class UserModel {
  String? uid;
  String? email;
  String? name;
  String? password;
  String? image;

  UserModel({this.uid, this.email, this.name, this.password,this.image});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      password: map['password'],
      image:map['image']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'password':password,
      'image':image
    };
  }
}