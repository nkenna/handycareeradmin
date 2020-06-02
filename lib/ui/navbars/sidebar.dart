import 'package:flutter/material.dart';
import 'package:handycareerweb/utils/projectcolors.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key key}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
               width: MediaQuery.of(context).size.width * 0.2,
               color: Color(0xFF2fcc76),
               child: Expanded(
                 child: Column(
                   children: [
                     Material(
                        elevation: 5,
                        color: mainColor,
                          child: Container(
                         height: MediaQuery.of(context).size.height * 0.2,
                         width: double.infinity,
                         
                       ),
                     ),
                     ListTile(
                        onTap: (){
                          Navigator.of(context).pushNamed('/dashboard');
                        },
                        leading: Icon(Icons.branding_watermark, color: Colors.white,),
                        title: Text("Jobs", style: TextStyle(color: Colors.white),),
                        
                      ),

                      ListTile(
                        onTap: (){
                          Navigator.of(context).pushNamed('/users');
                        },
                        leading: Icon(Icons.supervised_user_circle, color: Colors.white,),
                        title: Text("Users", style: TextStyle(color: Colors.white),),
                      ),

                      ListTile(
                        
                        onTap: (){
                          Navigator.of(context).pushNamed('/dashboard');
                        },
                        leading: Icon(Icons.contact_mail, color: Colors.white,),
                        title: Text("Admins", style: TextStyle(color: Colors.white),),
                      ),
                      

                     
                                           
                   ],
                 ),
               ),
             );
   
  }
}