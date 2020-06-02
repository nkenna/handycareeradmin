import 'dart:html';

import 'package:flutter/material.dart';
import 'package:handycareerweb/utils/providers/authprovider.dart';
//import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class DashboardNavbar extends StatelessWidget {
  
  //final LocalStorage storage;

  const DashboardNavbar({Key key}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
          builder: (context, bconstraints) => Container(
        child: Material(
          color: Color(0xFF2fcc76),
          elevation: 5.0,
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),       
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Handy Careers",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold 
                    ),
                  ),
                  SizedBox(
                    width: 30
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Consumer<AuthProvider>(
                        builder: (context, ad, child) {
                          print("look data");
                          //print(ad.admin.firstname);
                          return FlatButton.icon(
                          
                          onPressed: (){}, 
                          icon: Icon(Icons.supervisor_account, color: Colors.white,), 
                          label: Text(ad.admin.firstname ?? "", style: TextStyle(color: Colors.white),),
                        );
                        },
                        
                      ),
                      
                      FlatButton.icon(
                        onPressed: (){
                         // storage.clear();
                           Navigator.of(context).pushNamed('/');
                        }, 
                        icon: Icon(Icons.settings_power, color: Colors.white,), 
                        label: Text("Logout", style: TextStyle(color: Colors.white),),
                      ),

                      
                    ],
                  ),

                
                  
                ],
              ),
            
          ),
        ),
      )
  
        );
      
    
  }
}