import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:handycareerweb/models/admin.dart';
import 'package:handycareerweb/ui/navbars/topnavbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handycareerweb/utils/httpservice.dart';
import 'package:handycareerweb/utils/providers/authprovider.dart';
//import 'package:localstorage/localstorage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static TextEditingController emailController = new TextEditingController();
  static TextEditingController passwordController = new TextEditingController();

  HttpService httpService = new HttpService();
  //final LocalStorage storage = new LocalStorage('inventory_app');

  bool _isLoading = false;
  bool _passwObscure = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  loginAdmin(BuildContext context) async{
    //var adminDetails = Provider.of<AuthProvider>(context);
    setState(() {
        _isLoading = true;
      });
    const message_good = "successful";
    const message_error = "not found";

    await httpService.loginAdminReq(emailController.text, passwordController.text)
    .then((data)  {
      if(data == null){

        _scaffoldKey.currentState.showSnackBar(
                  new SnackBar(
                      backgroundColor: Color(0xFF2fcc76),
                      content: Text(
                        "Network error. Ensure you have proper network and try again",
                          style: GoogleFonts.dosis(
                            textStyle: TextStyle(color:  Colors.white, fontSize: 16, letterSpacing: .5),
                          )

                      )
                  )
              );
     

      setState(() {
        _isLoading = false;
      });
      //Navigator.of(context).pushNamed('/dashboard');
      return;
      }

      final int statusCode = data.statusCode;
      
      print(data.body);
      print("after data.body\n\n");
      var resp = json.decode(data.body);
      print(resp["message"]);

      if(statusCode < 200 || statusCode > 400 || json == null){
        setState(() {
        _isLoading = false;
      });
        _scaffoldKey.currentState.showSnackBar(
                  new SnackBar(
                      backgroundColor: Color(0xFF2fcc76),
                      content: Text(
                        "Authentication error occurred. Try again",
                          style: GoogleFonts.dosis(
                            textStyle: TextStyle(color:  Colors.white, fontSize: 16, letterSpacing: .5),
                          )

                      )
                  )
              );
     
        return;
      }

      if(resp["message"] != null && message_good == resp["message"]){
        print("good to login");
        setState(() {
        _isLoading = false;
      });
      saveAdminData(context, resp["result"], resp["token"]);
      

      }else if(resp["message"] != null && message_error == resp["message"]){
        setState(() {
        _isLoading = false;
      });
        print("user not found");
        _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
                      backgroundColor: Color(0xFF2fcc76),
                      content: Text(
                        "Invalid login details. Try again",
                          style: GoogleFonts.dosis(
                            textStyle: TextStyle(color:  Colors.white, fontSize: 16, letterSpacing: .5),
                          )

                      )
                  )
              );
      }else{
        setState(() {
        _isLoading = false;
      });
        print("error logining in");
        _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
                      backgroundColor: Color(0xFF2fcc76),
                      content: Text(
                        "Error in operation. Try again",
                          style: GoogleFonts.dosis(
                            textStyle: TextStyle(color:  Colors.white, fontSize: 16, letterSpacing: .5),
                          )

                      )
                  )
              );
      }
    });
  }

  saveAdminData(BuildContext context, dynamic data, dynamic token){
    var adminDetails = Provider.of<AuthProvider>(context, listen: false);
    try{

      //storage.setItem("token", token.toString());
      Admin admin = Admin.fromJson(data);
      print("admin middle");
      print(admin.middlename);
      adminDetails.setAdmin(admin);
      adminDetails.setToken(token.toString());
      //storage.setItem("firstname", admin.firstname);
      //storage.setItem("middlename", admin.middlename);
      //storage.setItem("lastname", admin.lastname);
      //storage.setItem("role", admin.role);
      //storage.setItem("email", admin.email);
      //storage.setItem("status", admin.status);

      
      Navigator.of(context).pushNamed('/dashboard');
    }catch(e){
      print(e);
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
                      backgroundColor: Color(0xFF2fcc76),
                      content: Text(
                        "Error parsing response data. Try again",
                          style: GoogleFonts.dosis(
                            textStyle: TextStyle(color:  Colors.white, fontSize: 16, letterSpacing: .5),
                          )

                      )
        )
        );
        return;
    }
  }

  Widget loginText() => Text(
    "Admin Login",
    style: TextStyle(
      fontSize: 20,
      color: Color(0xFF2fcc76)
    ),

  );

   Widget emailField(BuildContext context){
    return TextFormField(

                  controller: emailController,
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    fillColor: Color(0xFFFFFFFF),
                      filled: true,
                      hintStyle: TextStyle(fontSize: 16,color: Color(0xFF2fcc76)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 2,color: Color(0xFF2fcc76)),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 2,color: Color(0xFF2fcc76)),
                      ),

                      prefixIcon: Icon(Icons.email, color: Color(0xFF2fcc76)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Email",
                      border:
                      OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2fcc76)),
                          borderRadius: BorderRadius.circular(10.0))),
                );
              
    
  }

  Widget passwordField(BuildContext context){
    return TextFormField(
              controller: passwordController,
              obscureText: _passwObscure,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  fillColor: Color(0xFFFFFFFF),
                  filled: true,
                  hintStyle: TextStyle(fontSize: 16,color: Color(0xFF2fcc76)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2,color: Color(0xFF2fcc76)),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2,color: Color(0xFF2fcc76)),
                  ),

                  prefixIcon: Icon(Icons.vpn_key, color: Color(0xFF2fcc76)),


                  suffixIcon: IconButton(
                    icon: _passwObscure ? Icon(Icons.visibility_off, color: Color(0xFF2fcc76)) : Icon(Icons.visibility, color: Color(0xFF000080)),
                    onPressed: (){
                      setState(() {
                        _passwObscure = !_passwObscure;
                      });
                    },
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Color(0xFF2fcc76)),
                      borderRadius: BorderRadius.circular(10.0)   )
              ),
            );
          
    
    
  }

  Widget loginBtn(BuildContext context){
    return Material(

        elevation: 5.0,
        borderRadius: BorderRadius.circular(16.0),
        color: Color(0xFF2fcc76),
        child: MaterialButton(

          minWidth: 0.5 * MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            if(emailController.text.trim().length == 0 && passwordController.text.trim().length == 0){

              _scaffoldKey.currentState.showSnackBar(
                  new SnackBar(
                      backgroundColor: Color(0xFF2fcc76),
                      content: Text(
                        "Credentials cannot be empty. Please enter valid credentials.",
                          style: GoogleFonts.dosis(
                            textStyle: TextStyle(color:  Colors.white, fontSize: 16, letterSpacing: .5),
                          )

                      )
                  )
              );
             // Navigator.push(
              //    context,
              //    BouncyPageRoute(widget: SignupScreen()));
            }else{
             loginAdmin(context);
            }
          },
          child: Text("SIGN IN",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,  fontSize: 18)
          ),
        )

    );
  }

  Widget formContainer(BuildContext context) => Center(
    child: LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth > 1200){
          return Material(
            elevation: 5.0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: 20, right: 20),
                      child: loginText(),
                    ),

                    
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: 20, right: 20),
                      child: emailField(context)
                    ),

                    Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03, left: 20, right: 20),
                        child: passwordField(context)
                    ),

                    Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03, left: 100, right: 100,  bottom: 50),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: loginBtn(context),
                        )
                    ),
                  ],
                
                ),
            ),
          );
        }else {
          return Material(
            elevation: 5.0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: 20, right: 20),
                      child: loginText(),
                    ),

                    
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: 20, right: 20),
                      child: emailField(context)
                    ),

                    Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03, left: 20, right: 20),
                        child: passwordField(context)
                    ),

                    Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03, left: 100, right: 100,  bottom: 50),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: loginBtn(context),
                        )
                    ),
                  ],
                
                ),
            ),
          );
        }
      }
      
      )
    
    
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          color: Color(0xFF2fcc76),
          opacity: 0.5,
          progressIndicator: SpinKitFadingCube(color: Colors.pink, size: 50,),
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white38,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopNavBar(),
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: formContainer(context),
            )
          ],
        ),
      ),
    
        )
      
      
    
    );
  }
}