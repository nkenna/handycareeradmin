import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:handycareerweb/models/jobs.dart';
import 'package:handycareerweb/utils/httpservice.dart';


class JobProvider with ChangeNotifier {
  final HttpService httpService = new HttpService();
  List<Job> _jobs;
  List<Job> _selectedJobs;

  //getters
  List<Job> get jobs => _jobs;
  List<Job> get selectedJobs => _selectedJobs;

  retrieveJobs() async{    
    httpService.getAllJobs()
    .then((data) {
      if(data == null){      
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
          _jobs.add(jo);
          
        });

        

      }

      
      
    });
  }
 


}