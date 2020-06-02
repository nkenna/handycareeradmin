import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:handycareerweb/models/users.dart';
import 'package:handycareerweb/ui/navbars/dashboardnavbar.dart';
import 'package:handycareerweb/ui/navbars/sidebar.dart';
import 'package:handycareerweb/utils/httpservice.dart';
import 'package:handycareerweb/utils/projectcolors.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({Key key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  HttpService httpService = new HttpService();
  final Storage storage = window.localStorage;

  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<User> users;
  List<User> selectedUsers;
  bool sort;

  @override
  void initState() {
    sort = false;
    selectedUsers = [];
    users = User.getUsers();
    //joblocation = locations[0];
    //retrieveJobs();
    super.initState();
  }

   onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        users.sort((a, b) => a.firstname.compareTo(b.firstname));
      } else {
        users.sort((a, b) => b.firstname.compareTo(a.firstname));
      }
    }
  }
 
  onSelectedRow(bool selected, User user) async {
    setState(() {
      if (selected) {
        selectedUsers.add(user);
      } else {
        selectedUsers.remove(user);
      }
    });
  }
 
  deleteSelected() async {
    setState(() {
      if (selectedUsers.isNotEmpty) {
        List<User> temp = [];
        temp.addAll(selectedUsers);
        for (User user in temp) {
          users.remove(user);
          selectedUsers.remove(user);
        }
      }
    });
  }

  SingleChildScrollView userDataBody(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("First Name"),
            numeric: false,
            tooltip: "Name",
            onSort: (columnIndex, ascending){
              setState(() {
                sort = !sort;
              });
              onSortColumn(columnIndex, ascending);
            }),

             DataColumn(
              label: Text("Email"),
              numeric: false,
              tooltip: "Email",
             ),

             
             DataColumn(
              label: Text("Age"),
              numeric: true,
              tooltip: "Age",
             ),

             DataColumn(
              label: Text("Status"),
              numeric: false,
              tooltip: "Status",
             ),

             DataColumn(
              label: Text("Joined"),
              numeric: false,
              tooltip: "Joined",
             ),

             DataColumn(
              label: Text(""),
              numeric: false,
              tooltip: "job industry",
             ),

             

             
        ], 
        rows: users.map(
          (user) => DataRow(
            selected: selectedUsers.contains(user),
            onSelectChanged: (b) {
              print("onselect");
              onSelectedRow(b, user);
            },
            
            cells: [
              DataCell(
                Text(user.firstname ?? '' + user.middlename ?? '' + user.lastname ?? '' ),
                onTap: () {
                  print("selected ${user.firstname}");
                },
              ),

              DataCell(
                Text(user.email ?? ''),
              ),

            
              DataCell(
                Text("${((DateTime.now().difference(DateTime.parse(user.dob)).inDays) / 365).round()}"),
              ),

              DataCell(
                Text(user.status ?? ''),
              ),

              DataCell(
                Text(user.joined),
              ),

              
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    IconButton(
                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      
                      color: Colors.red,
                      onPressed: (){}, 
                      icon: Icon(Icons.edit, color: secondaryColor), 
                      //label: Text("Trash", style: TextStyle(color: Colors.white),),
                      ), 

                    IconButton(
                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      
                      color: Colors.red,
                      onPressed: (){}, 
                      icon: Icon(Icons.delete, color: badColor), 
                      //label: Text("Trash", style: TextStyle(color: Colors.white),),
                      ),                  

                      
                      IconButton(
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        //color: Color(0xFF2fcc76),
                      onPressed: (){
                        //var vjob = json.encode(job.toMap());
                       // print(vjob);
                      //  storage['job'] = vjob;
                        Navigator.of(context).pushNamed('/viewjob');
                      }, 
                      icon: Icon(Icons.visibility, color: secondaryColor,), 
                      //label: Text("View", style: TextStyle(color: secondaryColor),),
                      ),

                  ],
                )
                
                
              ),

              
            ]
          ),
        ).toList(),
      ),
    );
  }
 

  @override
  Widget build(BuildContext context) => Scaffold(
    key: _scaffoldKey,
    body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          color: Color(0xFF2fcc76),
          opacity: 0.5,
          progressIndicator: SpinKitFadingCube(color: secondaryColor, size: 50,),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              children: [
                Sidebar(),
                Container(
                 width: MediaQuery.of(context).size.width * 0.8,                 
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisSize: MainAxisSize.max,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //verticalDirection: VerticalDirection.down,
                   children: [
                     DashboardNavbar(),
                     Expanded(
                       child: userDataBody(),
                     )
                     
                     
                   ],
                 ),
               ),
              ],
            ),
          )  
    )
  );
}