import 'dart:convert';
import 'dart:html';

import 'package:handycareerweb/models/jobs.dart';
import 'package:handycareerweb/utils/providers/authprovider.dart';
import 'package:http/http.dart' as http;
//import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'links.dart';


class HttpService {
  //final LocalStorage storage = new LocalStorage('inventory_app');
  final Storage storage = window.localStorage;

  Future<dynamic> loginAdminReq(String email, String password) async{
    var url = ApiLinks.baseUrl + ApiLinks.adminLoginUrl;
    print(url);
    var reqBody = jsonEncode(
      <String, String> {
        'email': email,
        'password': password
      }); 

    var reqHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try{
      return await http.post(url, body: reqBody, headers: reqHeaders)
                  .timeout(Duration(minutes: 1), onTimeout: () => null);
    }catch(e){
      print(e.toString());
      return null;
    }              
  }

  Future<dynamic> getAllJobs() async{
    //var tokenDetails = Provider.of<AuthProvider>(context);
    var url = ApiLinks.baseUrl + ApiLinks.allJobsUrl;
    print(url);
    print(storage['token']);
    var reqHeaders = <String, String>{
        'Authorization': 'Bearer ' + storage['token'],
    };
    
    try{
      return await http.get(url, headers: reqHeaders)
      .timeout(Duration(minutes: 1), onTimeout: () => null);
    }catch(e){
      return null;
    }
  }

  Future<dynamic> addJob(Job job) async{
     var url = ApiLinks.baseUrl + ApiLinks.addJobUrl;
    print(url);
    
    var reqBody = jsonEncode(
      <String, dynamic>{
      'title': job.title,
      'location': job.location,
      'descr': job.descr,
      'age': job.age,
      'industry': job.industry,
      'jobfunction': job.jobfunction,
      'companyprofile': job.companyprofile,
      'deadline': job.deadline,
      'edu_req': job.edu_req,
      'exp_req': job.exp_req,
      'general_req': job.general_req,
      'creator': job.creator
      });

      var reqHeaders = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + storage['token']
      };

      try{
        return await http.post(url, body: reqBody, headers: reqHeaders)
                .timeout(Duration(minutes: 1), onTimeout: () => null);
      }catch(e){
      print(e.toString());
      return null;
    }

  }


}