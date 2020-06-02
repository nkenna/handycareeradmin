import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:handycareerweb/models/jobs.dart';
import 'package:handycareerweb/ui/navbars/dashboardnavbar.dart';
import 'package:handycareerweb/ui/navbars/sidebar.dart';
import 'package:handycareerweb/utils/httpservice.dart';
import 'package:handycareerweb/utils/projectcolors.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ViewJobScreen extends StatefulWidget {
  ViewJobScreen({Key key, this.job}) : super(key: key);

  Job job;

  @override
  _ViewJobScreenState createState() => _ViewJobScreenState();
}

class _ViewJobScreenState extends State<ViewJobScreen> {
  HttpService httpService = new HttpService();
  Job job;
  final Storage storage = window.localStorage;

  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() { 
    job = Job.fromJson(json.decode(storage['job']));
    super.initState();
    
  }

  Text jobTitle() => Text(
    job.title,
    style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold, fontSize: 18),
  );

  Widget headerBtnsRow(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(job.location,
      style: TextStyle(fontSize: 14, color: secondaryColor),),

      IconButton(
        hoverColor: mainColor,
        splashColor: mainColor,
        color: Colors.red,
        onPressed: (){}, 
        icon: Icon(Icons.edit, color: secondaryColor), 
      ), 

      IconButton(
        hoverColor: mainColor,
        splashColor: mainColor,
        color: Colors.red,
        onPressed: (){}, 
        icon: Icon(Icons.delete, color: badColor), 
      ),
    ],
  );

  Widget titleRow(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        jobTitle(),
        headerBtnsRow(context)
      ],
    ),
  );

  Widget myDivider() => Divider(
                       thickness: 3,
                       color: mainColor,
                       height: 5,
                     );

  Widget jobDescrp() => Padding(
    padding: EdgeInsets.all(8),
    child: RichText(
      text: TextSpan(
        text: "Job Description\n\n",
        style: TextStyle(color: secondaryColor, fontSize: 16, fontWeight: FontWeight.w600),
        children: [
          TextSpan(
            text: job.descr,
            style: TextStyle(color: secondaryColor, fontSize: 14),
          )
        ]
      ),
      ),
  ); 


  Widget companyProfile() => Padding(
    padding: EdgeInsets.all(8),
    child: RichText(
      text: TextSpan(
        text: "Company Profile\n\n",
        style: TextStyle(color: secondaryColor, fontSize: 16, fontWeight: FontWeight.w600),
        children: [
          TextSpan(
            text: job.companyprofile,
            style: TextStyle(color: secondaryColor, fontSize: 14),
          )
        ]
      ),
      ),
  ); 

  Widget jobIndustryFunction() => Padding(
    padding: EdgeInsets.all(8),
    child: RichText(
      text: TextSpan(
        text: "Job Industry & Function\n\n",
        style: TextStyle(color: secondaryColor, fontSize: 16, fontWeight: FontWeight.w600),
        children: [
          TextSpan(
            text: job.industry + "\n",
            style: TextStyle(color: secondaryColor, fontSize: 14),
          ),

          TextSpan(
            text: job.jobfunction,
            style: TextStyle(color: secondaryColor, fontSize: 14),
          )
        ]
      ),
      ),
  ); 

  Widget jobRequirements() => Padding(
    padding: EdgeInsets.all(8),
    child: RichText(
      text: TextSpan(
        text: "Job Requirements\n\n",
        style: TextStyle(color: secondaryColor, fontSize: 16, fontWeight: FontWeight.w600),
        children: [
          TextSpan(
            text: "Education and Qualifications\n",
            style: TextStyle(color: secondaryColor, fontWeight: FontWeight.w600, fontSize: 14),
            children: job.edu_req.map((req) => TextSpan(
              text: "- " + req + "\n",
              style: TextStyle(color: secondaryColor, fontSize: 14)
            )
            ).toList(),
          ),

          TextSpan(
            text: "\n\nExperience\n",
            style: TextStyle(color: secondaryColor, fontWeight: FontWeight.w600, fontSize: 14),
            children: job.exp_req.map((req) => TextSpan(
              text: "- " +  req.toString() + "\n",
              style: TextStyle(color: secondaryColor, fontSize: 14)
            )
            ).toList(),
          ),

          TextSpan(
            text: "\n\nGeneral\n",
            style: TextStyle(color: secondaryColor, fontWeight: FontWeight.w600, fontSize: 14),
            children: job.general_req.map((req) => TextSpan(
              text: "- " +  req.toString() + "\n",
              style: TextStyle(color: secondaryColor, fontSize: 14)
            )
            ).toList(),
          )


        ]
      ),
      ),
  );                  

   Widget deadline() => Padding(
    padding: EdgeInsets.all(8),
    child: RichText(
      text: TextSpan(
        text: "Deadline: ",
        style: TextStyle(color: secondaryColor, fontSize: 14, fontWeight: FontWeight.w600),
        children: [
          TextSpan(
            text: job.deadline,
            style: TextStyle(color: secondaryColor, fontSize: 14),
          )
        ]
      ),
      ),
  );

   Widget added() => Padding(
    padding: EdgeInsets.all(8),
    child: RichText(
      text: TextSpan(
        text: "Date Added: ",
        style: TextStyle(color: secondaryColor, fontSize: 14, fontWeight: FontWeight.w600),
        children: [
          TextSpan(
            text: job.addeddate,
            style: TextStyle(color: secondaryColor, fontSize: 14),
          )
        ]
      ),
      ),
  ); 

   Widget creator() => Padding(
    padding: EdgeInsets.all(8),
    child: RichText(
      text: TextSpan(
        text: "Added By: ",
        style: TextStyle(color: secondaryColor, fontSize: 14, fontWeight: FontWeight.w600),
        children: [
          TextSpan(
            text: job.creator,
            style: TextStyle(color: secondaryColor, fontSize: 14),
          )
        ]
      ),
      ),
  );

  Widget detailRow() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        added(),
        deadline(),
        creator()
      ],
    ),
  );
  
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
                 child: SingleChildScrollView(
                   child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisSize: MainAxisSize.max,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //verticalDirection: VerticalDirection.down,
                   children: [
                     DashboardNavbar(),
                     titleRow(context),
                     myDivider(),
                     detailRow(),
                     myDivider(),
                     jobDescrp(),
                     myDivider(),
                     companyProfile(),
                     myDivider(),
                     jobRequirements(),
                     myDivider(),
                     jobIndustryFunction(),
                     myDivider(),
                     
                     
                   ],
                 ),
                 )
               ),
              ],
            ),
          )  
    )
  );
}