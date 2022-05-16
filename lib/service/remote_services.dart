import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart'as http;

import '../model/project.dart';



class RemoteService{

 getProjectData()async{

String url="https://hihdw5fsnk.execute-api.ap-southeast-1.amazonaws.com/dev/arg_project";

String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHBpcmVzSW4iOjEwODAwLCJzdWIiOiJzaGFqaXRoQGdtYWlsLmNvbSIsImlhdCI6MTY1MjM0OTU0NX0.HYSwhbdWT9UOMh6lScK2GGpuX9roRNa_EKcNK6ywEdI";

var response=await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $token",
    });

var obj;
 final jsonResponse = json.decode(response.body);
    if(response.statusCode==200){
      if(jsonResponse["success"]==true){
         obj=Project.fromMap(jsonResponse);
    
var length=obj.data.noRecords;

log(length.toString());
 

      }
      else{
        log("NETWORK ERROR");
      }
    }
    else{
      log("ERROR");
    }
   

 return obj;
 }
 






}