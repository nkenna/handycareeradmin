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
import 'package:handycareerweb/utils/providers/authprovider.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class AddJobScreen extends StatefulWidget {
  AddJobScreen({Key key}) : super(key: key);

  @override
  _AddJobScreenState createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final Storage storage = window.localStorage;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  HttpService httpService = new HttpService();
  TextEditingController titleController = new TextEditingController();
  TextEditingController descrController = new TextEditingController();
  TextEditingController cpController = new TextEditingController();
  TextEditingController deadlineController = new TextEditingController();
  TextEditingController eduReqController = new TextEditingController();
  TextEditingController expReqController = new TextEditingController();
  TextEditingController genReqController = new TextEditingController();
  TextEditingController emailLinkController = new TextEditingController();
  TextEditingController instructionsController = new TextEditingController();

  TextEditingController applyLinkController = new TextEditingController();
  bool _isLoading = false;

   String joblocation = "Abia";
  String jobIndustry = "Food Services";
  String jobFunction = "Accounting, Auditing & Finance";
  var ageRanges = RangeValues(18, 65);

  List<String> educationReqs = <String>[];
  List<String> exprienceReqs = <String>[];
  List<String> generalReqs = <String>[];
  List<String> howToApply = <String>[];
  String apply = "link";

  @override
  void initState() { 
    howToApply = <String>["link", "email", "instructions"];
    super.initState();
    
  }

   Widget titleField(BuildContext context){
    return TextFormField(
                  controller: titleController,
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
                      hintText: "Job Title",
                      border:
                      OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2fcc76)),
                          borderRadius: BorderRadius.circular(10.0))),
                );
              
    
  }

  Widget descrField(BuildContext context){
    return TextFormField(
                  controller: descrController,
                  obscureText: false,
                  maxLines: 10,
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

                      //prefixIcon: Icon(Icons.email, color: Color(0xFF2fcc76)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Job Description",
                      border:
                      OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2fcc76)),
                          borderRadius: BorderRadius.circular(10.0))),
                );
              
    
  }

  Widget allStates(BuildContext context){
    return DropdownButton<String>(
      hint: Text("Select Job Location/State", style: TextStyle(color: mainColor),),
      value: joblocation,
      icon: Icon(Icons.arrow_drop_down, color: mainColor,),
      elevation: 10,
      style: TextStyle(color: mainColor),
      underline: Container(
        height: 2,
        color: mainColor,
      ),
      onChanged: (String value){
        setState(() {
          print(value);
          joblocation =  value;
          print(joblocation);
        });

      },
      isExpanded: true,
      items: locations.map((value) {
        
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: mainColor),),
        );
      }).toList(),
    );
  }

  Widget ageRange(BuildContext context) => SliderTheme(
    data: SliderThemeData(
      showValueIndicator: ShowValueIndicator.always
    ),
      child: RangeSlider(
      activeColor: mainColor,
      min: 0,
      max: 100,
      divisions: 100,
      labels: RangeLabels('${ageRanges.start.round()}', '${ageRanges.end.round()}'),
      values: ageRanges, 
      onChanged: (RangeValues value) { 
        setState(() { 
          ageRanges = value; 
          }); 
      },
      onChangeStart: (RangeValues v){
        print(v);
      },
      ),
  );

   Widget allIndustries(BuildContext context){
    return DropdownButton<String>(
      hint: Text("Select Job Industry", style: TextStyle(color: mainColor),),
      value: jobIndustry,
      icon: Icon(Icons.arrow_drop_down, color: mainColor,),
      elevation: 10,
      style: TextStyle(color: mainColor),
      underline: Container(
        height: 2,
        color: mainColor,
      ),
      onChanged: (String value){
        setState(() {
          print(value);
          jobIndustry =  value;
          print(jobIndustry);
        });

      },
      isExpanded: true,
      items: industries.map((value) {
        
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: mainColor),),
        );
      }).toList(),
    );
  }
  

  Widget allJobFunctions(BuildContext context){
    return DropdownButton<String>(
      hint: Text("Select Job Function", style: TextStyle(color: mainColor),),
      value: jobFunction,
      icon: Icon(Icons.arrow_drop_down, color: mainColor,),
      elevation: 10,
      style: TextStyle(color: mainColor),
      underline: Container(
        height: 2,
        color: mainColor,
      ),
      onChanged: (String value){
        setState(() {
          print(value);
          jobFunction =  value;
          print(jobFunction);
        });

      },
      isExpanded: true,
      items: jobFunctions.map((value) {
        
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: mainColor),),
        );
      }).toList(),
    );
  } 

  Widget cpField(BuildContext context){
    return TextFormField(
                  controller: cpController,
                  obscureText: false,
                  maxLines: 10,
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

                      //prefixIcon: Icon(Icons.email, color: Color(0xFF2fcc76)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Company/Firm Profile",
                      border:
                      OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2fcc76)),
                          borderRadius: BorderRadius.circular(10.0))),
                
                
                );
              
    
  }

  Widget deadlineField(BuildContext context){
    final format = DateFormat("yyyy-MM-dd");
    return DateTimeField(
      format: format,
      controller: deadlineController,
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

                      //prefixIcon: Icon(Icons.email, color: Color(0xFF2fcc76)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Job Deadline",
                      border:
                      OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2fcc76)),
                          borderRadius: BorderRadius.circular(10.0))),
                
      
      onShowPicker: (context, currentValue){
        return showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(3000)
        );

      },
    );
  }
  
  Widget eduReqsField(BuildContext context){
    return TextFormField(
                  controller: eduReqController,
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

                      //prefixIcon: Icon(Icons.email, color: Color(0xFF2fcc76)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Enter Education Requirements",
                      border:
                      OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2fcc76)),
                          borderRadius: BorderRadius.circular(10.0))),
                );
              
  }
 
  Widget eduFieldRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 2, right: 2),
          child: SizedBox(
            width: 400,
            child: eduReqsField(context),
          )
        ),
        

        Padding(
          padding: EdgeInsets.only(left: 2, right: 2),
          child: IconButton(
            //label: Text("save"),
            icon: Icon(Icons.save_alt, color: mainColor,),
            onPressed: (){
              if(eduReqController.text.trim().isNotEmpty){
                setState(() {
                  educationReqs.add(eduReqController.text);
                eduReqController.text = "";
                });
              }
            }),
        ),
      ],
    );
  }

  Widget eduReqListData(BuildContext context){
    return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: educationReqs.length,
            itemBuilder: (context, index){
              final item = educationReqs[index];
            return Dismissible(
              key: Key(item),
              background: Container(color: Colors.red),
              secondaryBackground: Container(color: mainColor),
              child: Text(
                educationReqs[index],
                style: TextStyle(color: mainColor),
              ),
              onDismissed: (direction){
                setState(() {
                  educationReqs.removeAt(index);
                });
              },
              );
            }
            );
    
     
  }

   Widget expReqsField(BuildContext context){
    return TextFormField(
                  controller:  expReqController,
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

                      //prefixIcon: Icon(Icons.email, color: Color(0xFF2fcc76)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Enter Experience Requirements",
                      border:
                      OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2fcc76)),
                          borderRadius: BorderRadius.circular(10.0))),
                );
              
  }
  
   Widget expFieldRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 2, right: 2),
          child: SizedBox(
            width: 400,
            child: expReqsField(context),
          )
        ),
        

        Padding(
          padding: EdgeInsets.only(left: 2, right: 2),
          child: IconButton(
            //label: Text("save"),
            icon: Icon(Icons.save_alt, color: mainColor,),
            onPressed: (){
              if(expReqController.text.trim().isNotEmpty){
                setState(() {
                  exprienceReqs.add(expReqController.text);
                  expReqController.text = "";
                });
              }
            }),
        ),
      ],
    );
  }

  Widget expReqListData(BuildContext context){
    return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: exprienceReqs.length,
            itemBuilder: (context, index){
              final item = exprienceReqs[index];
            return Dismissible(
              key: Key(item),
              background: Container(color: Colors.red),
              secondaryBackground: Container(color: mainColor),
              child: Text(
                exprienceReqs[index],
                style: TextStyle(color: mainColor),
              ),
              onDismissed: (direction){
                setState(() {
                  exprienceReqs.removeAt(index);
                });
              },
              );
            }
            );
    
     
  }

  Widget genReqsField(BuildContext context){
    return TextFormField(
                  controller: genReqController,
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

                      //prefixIcon: Icon(Icons.email, color: Color(0xFF2fcc76)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Enter General Requirements",
                      border:
                      OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2fcc76)),
                          borderRadius: BorderRadius.circular(10.0))),
                );
              
  }
  

  Widget genFieldRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 2, right: 2),
          child: SizedBox(
            width: 400,
            child: genReqsField(context),
          )
        ),
        

        Padding(
          padding: EdgeInsets.only(left: 2, right: 2),
          child: IconButton(
            //label: Text("save"),
            icon: Icon(Icons.save_alt, color: mainColor,),
            onPressed: (){
              if(genReqController.text.trim().isNotEmpty){
                setState(() {
                  generalReqs.add(genReqController.text);
                  genReqController.text = "";
                });
              }
            }),
        ),
      ],
    );
  }

  Widget genReqListData(BuildContext context){
    return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: generalReqs.length,
            itemBuilder: (context, index){
              final item = generalReqs[index];
            return Dismissible(
              dismissThresholds: {
               DismissDirection.startToEnd: 10.0,
            },
              direction: DismissDirection.startToEnd, 
              key: Key(item),
              background: Container(color: Colors.red),
              secondaryBackground: Container(color: mainColor),
              child: Container(
                height: 30,
                child: Text(
                generalReqs[index],
                textAlign: TextAlign.justify,
                style: TextStyle(color: mainColor),
              ),
                
              ),
              onDismissed: (direction){
                setState(() {
                  generalReqs.removeAt(index);
                });
              },
              );
            }
            );
    
     
  }


  Widget addBtn(BuildContext context){
    return Consumer<AuthProvider>(
      builder: (context, ad, child) {
          return Material(

          elevation: 5.0,
          borderRadius: BorderRadius.circular(16.0),
          color: Color(0xFF2fcc76),
          child: MaterialButton(

            minWidth: 0.5 * MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              
              if(              
                
                titleController.text.trim().length == 0 && 
                descrController.text.trim().length == 0){

                _scaffoldKey.currentState.showSnackBar(
                    new SnackBar(
                        backgroundColor: Color(0xFF2fcc76),
                        content: Text(
                          "Job Title or description field cannot be empty. Please enter valid data.",
                            style: GoogleFonts.dosis(
                              textStyle: TextStyle(color:  Colors.white, fontSize: 16, letterSpacing: .5),
                            )

                        )
                    )
                );
              
              }else{
                String applyData = "";
                debugPrint("admin data: " + ad.admin.email);
                debugPrint("admin data2: " + storage["email"]);
                if(apply == "email"){
                  applyData = emailLinkController.text;
                }else if(apply == "link"){
                  applyData = applyLinkController.text;
                }else{
                  applyData = instructionsController.text;
                }

              Job job = new Job(
                title:  titleController.text,
                descr: descrController.text,
                companyprofile: cpController.text,
                deadline: deadlineController.text,
                creator: storage["email"],
                edu_req: educationReqs,
                exp_req: exprienceReqs,
                general_req: generalReqs,
                age: [ageRanges.start, ageRanges.end],
                industry: jobIndustry,
                jobfunction: jobFunction,
                location: joblocation,
                howtoapply: apply,
                apply: applyData,
                
              );

               saveJob(job);
              }
            },
            child: Text("Add Job",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,  fontSize: 18)
            ),
          )

      );
  }
    );
  }

  Widget allJobApplies(BuildContext context){
    return DropdownButton<String>(
      hint: Text("Select how to apply", style: TextStyle(color: mainColor),),
      value: apply,
      icon: Icon(Icons.arrow_drop_down, color: mainColor,),
      elevation: 10,
      style: TextStyle(color: mainColor),
      underline: Container(
        height: 2,
        color: mainColor,
      ),
      onChanged: (String value){
        setState(() {
          print(value);
          apply =  value;
          print(howToApply);
        });

      },
      isExpanded: true,
      items: howToApply.map((value) {
        
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: mainColor),),
        );
      }).toList(),
    );
  }

  Widget chooseApplyMtd(BuildContext context){
    if(apply == "link"){
      return addLink(context);
    }else if(apply == "email"){
      return emailLink(context);
    }else {
      return instrLink(context);
    }
  }

  Widget formContainer(BuildContext context) => ListView (
    scrollDirection: Axis.vertical,
    children: [
      Expanded(
        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                                        
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, left: 20, right: 20),
                      child: titleField(context)
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: 20, right: 20),
                      child: descrField(context)
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: allStates(context)
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: ageRange(context)
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: allJobFunctions(context)
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: allIndustries(context)
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: cpField(context)
                    ), 
                    
                    
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: deadlineField(context)
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: eduFieldRow(context)
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: SizedBox(
                       height: MediaQuery.of(context).size.height * 0.3,
                        child: eduReqListData(context),
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: expFieldRow(context)
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: SizedBox(
                       height: MediaQuery.of(context).size.height * 0.3,
                        child: expReqListData(context),
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: genFieldRow(context)
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: SizedBox(
                       height: MediaQuery.of(context).size.height * 0.3,
                        child: genReqListData(context),
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: allJobApplies(context)
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: chooseApplyMtd(context)
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 30.0, top: MediaQuery.of(context).size.height * 0.02, left: 20, right: 20),
                      child: addBtn(context)
                    ),

                    
                  ],
                
                ),
           
      )
    ],
    
  );

  
  Widget addLink(BuildContext context){
    return TextFormField(
                  controller: applyLinkController,
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
                      hintText: "Enter apply link",
                      border:
                      OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2fcc76)),
                          borderRadius: BorderRadius.circular(10.0))),
                );
              
  }
  
  Widget emailLink(BuildContext context){
    return TextFormField(
                  controller: emailLinkController,
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
                      hintText: "Enter Job Contact Email",
                      border:
                      OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2fcc76)),
                          borderRadius: BorderRadius.circular(10.0))),
                );
              
  }
  
  Widget instrLink(BuildContext context){
    return TextFormField(
                  controller: instructionsController,
                  obscureText: false,
                  maxLines: 10,
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

                      //prefixIcon: Icon(Icons.email, color: Color(0xFF2fcc76)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Enter Job Instructions",
                      border:
                      OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2fcc76)),
                          borderRadius: BorderRadius.circular(10.0))),
                );
              
  }

  saveJob(Job job) async{
    const success_msg = "success";

    setState(() {
        _isLoading = true;
    });


    await httpService.addJob(job)
    .then((data) {
      if(data == null){
        setState(() {
        _isLoading = false;
      });
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
        return;
      }

      final int statusCode = data.statusCode;
      
      print(data.body);
      print("after data.body\n\n");
      var resp = json.decode(data.body);
      print(resp["result"]);

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
      
      if(resp["result"] == success_msg && resp["error"] == null){
        _scaffoldKey.currentState.showSnackBar(
                  new SnackBar(
                      backgroundColor: Color(0xFF2fcc76),
                      content: Text(
                        "Job added successfully",
                          style: GoogleFonts.dosis(
                            textStyle: TextStyle(color:  Colors.white, fontSize: 16, letterSpacing: .5),
                          )

                      )
                  )
              );
              
      setState(() {
        _isLoading = false;
      });

      
      }else{
        _scaffoldKey.currentState.showSnackBar(
                  new SnackBar(
                      backgroundColor: Color(0xFF2fcc76),
                      content: Text(
                        "This Job could not be added successfully. Status code: ${statusCode}",
                          style: GoogleFonts.dosis(
                            textStyle: TextStyle(color:  Colors.white, fontSize: 16, letterSpacing: .5),
                          )

                      )
                  )
              );
              setState(() {
                _isLoading = false;
              });
      }
    });
  }
    

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
                     
                     Expanded(
                       child: Padding(
                         padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2, right: MediaQuery.of(context).size.width * 0.2),
                         child: formContainer(context)
                         )
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
}