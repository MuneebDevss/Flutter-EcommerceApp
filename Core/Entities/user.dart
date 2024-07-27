import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String userName;
  final String phoneNumber;
  final String? password;
   String profilePicture;

  UserModel(this.id, {required this.firstName, required this.lastName, required this.email, required this.userName, required this.phoneNumber,  this.password, required this.profilePicture});
  static List<String> nameSeparator(String name)
  {
    List<String> fullName=name.split(" ");
    return fullName;
  }
  Map<String,dynamic> toJson()
  {
    return {
      'id':id,
      'firstName':firstName,
      'lastName':lastName,
      'email':email,
      'userName':userName,
      'phoneNumber':phoneNumber,
      'password':password??'',
      'profilePicture':profilePicture
    };
  }
  factory UserModel.fromSnapShot(DocumentSnapshot<Map<String,dynamic>> doc)
  {

    late final Map<String,dynamic> map;
    if(doc.data()!=null)
    {
      map=doc.data()!;
    }

    return UserModel(map['id']??'',firstName: map['firstName']??'', lastName: map['lastName']??'', email: map['email']??'', userName: map['userName']??'', phoneNumber: map['phoneNumber']??'', password: map['password']??'', profilePicture: map['profilePicture']??'');
  }

}