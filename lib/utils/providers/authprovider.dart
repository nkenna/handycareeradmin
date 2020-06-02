import 'package:flutter/material.dart';
import 'package:handycareerweb/models/admin.dart';
//import 'package:localstorage/localstorage.dart';
import 'dart:html';

class AuthProvider with ChangeNotifier{
  final Storage storage = window.localStorage;


  Admin _admin;
  String _token;

  AuthProvider(){
    retrieveAdmin();
    retrieveToken();
  }

  //Getters
  Admin get admin => _admin;  
  String get token => _token;

  //Setters
  void setAdmin(Admin admin){
    _admin = admin;
    notifyListeners();
    saveAdmin();
  }

  void setToken(String token){
    _token = token;
    notifyListeners();
    saveToken(_token);
  }

  saveAdmin() async{
    
    //LocalStorage storage = new LocalStorage('handy_app');
    storage["firstname"] = _admin.firstname;
    storage["middlename"] = _admin.middlename;
    storage["lastname"] = _admin.lastname;
    storage["role"] = _admin.role;
    storage["email"] = _admin.email;
    storage["status"] = _admin.status;
    print("do check");
    print(storage["lastname"]);
    notifyListeners();
  }

  Admin retrieveAdmin(){
   
    print("do rere-check");
    print(storage["lastname"]);

    Admin ad = new Admin(
      firstname: storage["firstname"],
      middlename: storage["middlename"],
      lastname: storage["lastname"],
      role: storage["role"],
      email: storage["email"],
      status: storage["status"],
    );

    setAdmin(ad);

    print("admin details");
    print(storage["firstname"]);
    print(_admin.email);
    print(ad.firstname);

    return ad;
    
  }

  removeAdmin() async{
    
    await storage["firstname"];
    await storage["middlename"];
    await storage["lastname"];
    await storage["role"];
    await storage["email"];
    await storage["status"];
    notifyListeners();
  }

  saveToken(String token){
    
    storage["token"] = token;
    notifyListeners();
  }

  retrieveToken() async{
   
    setToken(storage["token"]);
  }

  removeToken() async{
    
    storage["token"];
    notifyListeners();
  }
  
}