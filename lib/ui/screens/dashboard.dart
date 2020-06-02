import 'dart:convert';
import 'dart:html';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handycareerweb/models/jobs.dart';
import 'package:handycareerweb/ui/navbars/dashboardnavbar.dart';
import 'package:handycareerweb/ui/navbars/sidebar.dart';
import 'package:handycareerweb/utils/allformdata.dart';
import 'package:handycareerweb/utils/httpservice.dart';
import 'package:handycareerweb/utils/projectcolors.dart';
//import 'package:localstorage/localstorage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  //final LocalStorage storage = new LocalStorage('inventory_app');
  final HttpService httpService = new HttpService();
  final Storage storage = window.localStorage;

  TextEditingController titleController = new TextEditingController();
  TextEditingController descrController = new TextEditingController();
  TextEditingController cpController = new TextEditingController();
  TextEditingController deadlineController = new TextEditingController();
  
  List<Job> jobs;
  List<Job> selectedJobs;
  bool sort;
 

  @override
  void initState() {
    sort = false;
    selectedJobs = [];
    jobs = Job.getJobs();
    //joblocation = locations[0];
    retrieveJobs();
    super.initState();
  }

 
  

  void showFancyCustomDialog(BuildContext context) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(),
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Add new Job",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            Align(
        // These values are based on trial & error method
              alignment: Alignment(1.05, -1.05),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
 }



  retrieveJobs() async{
    setState(() {
        _isLoading = true;
      });
    httpService.getAllJobs()
    .then((data) {
      if(data == null){
        setState(() {
        _isLoading = false;
      });

      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
                      backgroundColor: Color(0xFF2fcc76),
                      content: Text(
                        "Error retrieving data. Try again",
                          style: GoogleFonts.dosis(
                            textStyle: TextStyle(color:  Colors.white, fontSize: 16, letterSpacing: .5),
                          )

                      )
                  )
              );
        return;
      }

      var resp = json.decode(data.body);

      if(resp['error'] == null && resp['result'] != null){
        //print(resp['result']);
        print(resp['result'].length);

        List<dynamic> respJobs = resp['result'];
        respJobs.forEach((job) {
          print(job['title']);
          Job jo = Job.fromJson(job);
          print(jo.toString());
          setState(() {
            jobs.add(jo);
          });
        });

        setState(() {
        _isLoading = false;
      });

      }

      
      
    });
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        jobs.sort((a, b) => a.title.compareTo(b.title));
      } else {
        jobs.sort((a, b) => b.title.compareTo(a.title));
      }
    }
  }
 
  onSelectedRow(bool selected, Job job) async {
    setState(() {
      if (selected) {
        selectedJobs.add(job);
      } else {
        selectedJobs.remove(job);
      }
    });
  }
 
  deleteSelected() async {
    setState(() {
      if (selectedJobs.isNotEmpty) {
        List<Job> temp = [];
        temp.addAll(selectedJobs);
        for (Job job in temp) {
          jobs.remove(job);
          selectedJobs.remove(job);
        }
      }
    });
  }
 

  SingleChildScrollView jobDataBody(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("Job Title"),
            numeric: false,
            tooltip: "Job title",
            onSort: (columnIndex, ascending){
              setState(() {
                sort = !sort;
              });
              onSortColumn(columnIndex, ascending);
            }),

             DataColumn(
              label: Text("Location"),
              numeric: false,
              tooltip: "State/location where the job is",
             ),

             
             DataColumn(
              label: Text("Deadline"),
              numeric: false,
              tooltip: "date on which date was added",
             ),

             DataColumn(
              label: Text("Industry"),
              numeric: false,
              tooltip: "job industry",
             ),

             DataColumn(
              label: Text("Job"),
              numeric: false,
              tooltip: "job industry",
             ),

             DataColumn(
              label: Text("Created By"),
              numeric: false,
              tooltip: "job industry",
             ),

             DataColumn(
              label: Text(""),
              numeric: false,
              tooltip: "job industry",
             ),

             

             
        ], 
        rows: jobs.map(
          (job) => DataRow(
            selected: selectedJobs.contains(job),
            onSelectChanged: (b) {
              print("onselect");
              onSelectedRow(b, job);
            },
            
            cells: [
              DataCell(
                Text(job.title ?? ''),
                onTap: () {
                  print("selected ${job.title}");
                },
              ),

              DataCell(
                Text(job.location ?? ''),
              ),

            
              DataCell(
                Text("${DateTime.parse(job.deadline ?? DateTime.now().toString()).difference(DateTime.parse(job.addeddate)).inDays}"),
              ),

              DataCell(
                Text(job.industry ?? ''),
              ),

              DataCell(
                Text(job.jobfunction ?? ''),
              ),

              DataCell(
                Text(job.creator ?? ''),
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
                        var vjob = json.encode(job.toMap());
                        print(vjob);
                        storage['job'] = vjob;
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

  Widget rowButtons(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          color: Color(0xFF2fcc76),
          child: Text("Add Job", style: TextStyle(color: Colors.white),),
          onPressed: (){
            Navigator.of(context).pushNamed('/addjob');
            //showFancyCustomDialog(context);
          },
          elevation: 5.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        )
      ],
    ),
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
          child:Container(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
         child: Row(
           children: [
              Sidebar(),
             Container(
                 width: MediaQuery.of(context).size.width * 0.8,                 
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    verticalDirection: VerticalDirection.down,
                   children: [
                     DashboardNavbar(),
                     //DashboardNavbar(storage: storage),
                     rowButtons(context),
                     Expanded(
                       child: jobDataBody(),
                     )
                   ],
                 ),
               ),
            
           ],
         ),
      ),

          )
          
          
          
    
    
    );
  }
}

