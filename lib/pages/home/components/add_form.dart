import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:report_generator/model/project.dart';

import "package:http/http.dart"as http;

import '../../../widgets/action_button.dart';
import '../../../widgets/shadow_container.dart';


class AddForm extends StatefulWidget {
   AddForm({ Key? key }) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  List<Map<String,dynamic>> values=[];
  DateFormat dateFormat = DateFormat("MM/dd/yyyy");
  DateFormat dateFormat1 = DateFormat("yyyy-MM-dd");
  String totalDuration="00:00";
  String duration="00:00";
  int totalminutes=0;
  bool validate=false;

  int count=1;
TimeOfDay selectedTime = TimeOfDay.now();
String currentDate="";
String currentYearDate="";
String dropdownvalue = 'In Progress';   
 List<TextEditingController> startTimecontrollers = [];
  List<TextEditingController> endTimecontrollers = [];
 
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
var tasks = new Map();
var projects = [];


  String projectName="";
  String issue_id="";

  // List<BuildRow1> list=[];
  
  // List of items in our dropdown menu
  var items = [    
    'In Progress',
    'Completed',

  ];
  String dropdownvalue1 = 'Morphfit';   
  
  // List of items in our dropdown menu
  var items1 = [    
    'Morphfit',
    'Qbace',

  ];
      
  // showPicker(BuildContext context) {
  //   Picker picker = Picker(
  //       adapter: PickerDataAdapter<String>(
  //           pickerdata: JsonDecoder().convert(PickerData)),
  //       changeToFirst: false,
  //       textAlign: TextAlign.left,
  //       textStyle: TextStyle(color: Colors.blue, ),
  //       selectedTextStyle: TextStyle(color: Colors.red),
  //       columnPadding: const EdgeInsets.all(8.0),
  //       onConfirm: (Picker picker, List value) {
  //         print(value.toString());
  //         print(picker.getSelectedValues());
  //       });
  //   // picker.show(scaffoldKey.currentState);
  // }

String selectedValue = "";

 getProjectData()async{

String url="https://hihdw5fsnk.execute-api.ap-southeast-1.amazonaws.com/dev/arg_project";

String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHBpcmVzSW4iOjEwODAwLCJzdWIiOiJzaGFqaXRoQGdtYWlsLmNvbSIsImlhdCI6MTY1MjM0OTU0NX0.HYSwhbdWT9UOMh6lScK2GGpuX9roRNa_EKcNK6ywEdI";

print(url);
var response=await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $token",
    });
    print(response.statusCode);
// // print(response.statusCode);
var obj;
 final jsonResponse = json.decode(response.body);
print(jsonResponse);
    if(response.statusCode==200){
      if(jsonResponse["success"]==true){
         obj=Project.fromMap(jsonResponse);
        print(obj.runtimeType);

         setState(() {
      projects = jsonResponse["data"]["records"];
      selectedValue = projects[0]["projectName"];
    });
        // setState(() {
        //   data=obj;
        // });
      // print("11111");
      // print(obj.data.records[0].projectName.toString());
      // print(obj.data.records[0].id.toString());

var length=obj.data.noRecords;
for(var data in obj.data.records){
// print(data.projectName.toString());
print(data.id.toString()+"   ----   "+data.projectName.toString());
}
// for
print(length);
 

      }
      else{
        print("NETWORK ERROR");
      }
    }
    else{
      print("ERROR");
    }
   

setState(() {
  // getValue=true;
});
 return obj;
 }
 
 
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProjectData();
    var controller1 = TextEditingController();
     var controller2 = TextEditingController();
  
    startTimecontrollers.add(controller1);
     endTimecontrollers.add(controller2);
    values=[];
    tasks={
            "duration": "00:00",
            "issueId": "AB001",
            "description": "Worked on Login UI",
            "taskName": "Login Screen UI",
            "startTimehour":00,
            "startTimemin":00,
            "endTimehour": 00,
            "endTimemin": 00,
            "projectName": "Morphfit",
            "projectId": "1002",
            "status": "In Progress"
    };
    // print(tasks);

currentDate = dateFormat.format(DateTime.now());
// print(currentDate);
currentYearDate=dateFormat1.format(DateTime.now());


  }


  _selectTime(BuildContext context,TextEditingController controller,int index,{bool cal=false, String startTime="00:00"}) async {          
      final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
         builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 24-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
              child: childWidget!);
},
        initialEntryMode: TimePickerEntryMode.dial,
        
      );
  var value;
      if(timeOfDay != null && timeOfDay != selectedTime)
        {
          setState(() {
            selectedTime = timeOfDay;
            print(timeOfDay.hour);
            print(timeOfDay.minute);
            value=formatTime(timeOfDay.hour.toString())+":"+formatTime(timeOfDay.minute.toString());
            // if(cal==false){
            //   startTimecontrollers[index-1]=formatTime(timeOfDay.hour.toString())+":"+formatTime(timeOfDay.minute.toString());
            // }
            // else{
            //   endTimecontrollers[index-1]=formatTime(timeOfDay.hour.toString())+":"+formatTime(timeOfDay.minute.toString());

            // }
          });
        
        if(cal==true){
          print(currentYearDate);
          // print(startTime.text.toString());
          // print(controller.text.toString());
          tasks["endTimehour"]=formatTime(timeOfDay.hour.toString());
          tasks["endTimemin"]=formatTime(timeOfDay.minute.toString());
          print(tasks.toString());
     
print("________");
     print(endTimecontrollers[index].text.toString());
print("________");
          durationCalculate(currentYearDate.toString(), startTime, value);
        }
        else{
          tasks["startTimehour"]=formatTime(timeOfDay.hour.toString());
          tasks["startTimemin"]=formatTime(timeOfDay.minute.toString());
        //  tasks["startTime"]["hours"]=timeOfDay.hour.toString();
          print(tasks.toString());

        }
        }
        return value;
  }
formatTime(time){
  var t;
  // print("SSSS");
  print(time.runtimeType);
  if(int.parse(time)<10){
    t="0"+time;
  }
  else{
t=time;
  }
  return t;
}

  durationCalculate(date,startTime,endTime){
    

  DateTime dt1 = DateTime.parse("$date $startTime:00");



    
    DateTime dt2 = DateTime.parse("$date $endTime:00");
  

    Duration diff = dt2.difference(dt1);
  print(diff.toString());
    var minutes=diff.inMinutes;
    totalminutes=totalminutes+minutes;
    print("MIN_____________>"+totalminutes.toString());
    var hours=(minutes/60).toInt();
    var m=minutes%60;
    var tHours=(totalminutes/60).toInt();
    var tM=totalminutes%60;
    setState(() {
      
    duration=formatTime(hours.toString())+":"+formatTime(m.toString());
    totalDuration=formatTime(tHours.toString())+":"+formatTime(tM.toString());
    tasks["duration"]=duration;
    });
    // print()
    //  totalDuration(minutes);



var val= formatTime(hours.toString())+":"+formatTime(m.toString());

  return val;
}
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [


   ShadowContainer(
                        child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 18),
                                child: Text(
                                  currentDate,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromRGBO(0, 0, 0, 0.8),
                                          fontWeight: FontWeight.w500)),
                                )),
                            Container(
                                child: 
                                
                                
                               1==0? 
                               ActionButtonRow():cancelSaveButton()
                            
                            
                            )
                          ],
                        ),
                        Divider(),
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   ListView(
    shrinkWrap: true,
    children: [
      Form(
        key: formKey,
        autovalidateMode: validate?AutovalidateMode.always:AutovalidateMode.disabled,
        child: mainTable(),
      ),
   
    bottomTable()
    ],
  ),
)
                      ],
                    )),
                 

        ],




      ),
      
    );
  }

  Row ActionButtonRow() {
    return Row(
                            children: [
                              ActionButton(
                                child: Image.asset(
                                  "assets/images/copy.png",
                                  height: 20,
                                  width: 20,
                                ),
                                label: "Copy",
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              ActionButton(
                                child: Icon(
                                  Icons.edit,
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                ),
                                label: "Edit",
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              ActionButton(
                                child: Icon(Icons.delete,
                                    color: Color.fromRGBO(0, 0, 0, 0.5)),
                                label: "Delete",
                              ),
                              SizedBox(
                                width: 18,
                              ),
                            ],
                          );
  }

  Row cancelSaveButton() {
    return Row(
                            
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            
                            children: [

                            ElevatedButton(onPressed: (){}, child: Text("Cancel")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(onPressed: (){}, child: Text("Save")),
                            ),

                          ],);
  }

  Table mainTable() {
    return Table(
      
                            border: TableBorder.all(),
      
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      
                        columnWidths: {
      
                          0: FractionColumnWidth(0.1),
      
                          1: FractionColumnWidth(0.14),
      
                          2: FractionColumnWidth(0.15),
      
                          // 3: FractionColumnWidth(0.1),
      
                          // 4: FractionColumnWidth(0.1),
      
                          // 5: FractionColumnWidth(0.1),
      
                          // 6: FractionColumnWidth(0.1),
      
                          7: FractionColumnWidth(0.1),
      
                          8: FractionColumnWidth(0.25)
      
                        },
      
                          children:List.generate(count+1, (index) =>index==0?                           headerTable()
     : buildRow1(
       index
     ))
      
      );
  
  
  }

  Table bottomTable() {
    return Table(
            border: TableBorder.all(),
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              0: FractionColumnWidth(0.495),
              1: FractionColumnWidth(0.078),
              2: FractionColumnWidth(0.077),
              // 3: FractionColumnWidth(0.48),
            },
            children: [
              buildRow2(formKey),
            
            ],
          );
  }

  TableRow headerTable() {
    return buildRow([
      
                            "Date",
      
                            "Project",
      
                            "Task",
      
                            "Issue ID",
      
                            "Start time",
      
                            "End time",
      
                            "Duration",
      
                            "Status",
      
                            "Description"
      
                          ], isHeader: true);
  }
   TableRow buildRow2(formkey) => TableRow(
     
      children: [
        Center(child: Text(""),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text("Total Duration")),
        ),
        Center(child: Text(totalDuration.toString())),
        Align(alignment: Alignment.centerRight,child: Center(child: OutlinedButton.icon(onPressed: ()async{
          if(formKey.currentState!.validate()){
            setState(() {
              
            validate=false;
            });


           await updateValue(count.toString(), tasks.toString(), count.toString());
setState(() {
  
     print("SSD");
     print(startTimecontrollers.length);
     var controller1 = TextEditingController();
     var controller2 = TextEditingController();
  
     startTimecontrollers.add(controller1);
     endTimecontrollers.add(controller2);
     print("SSD");
     print(startTimecontrollers.length);
 
            count=count+1;
          });
       print(tasks.toString());
          }
          else{
            setState(() {
              
            validate=true;
            });
          }
           },label: Text("ADD ROW"),icon: Icon(Icons.add),))),
       	
       ]
   );

   TableRow buildRow1(int index) => TableRow(
     
      children: [
        Center(child: Text(currentDate),),
       	Padding(
       	  padding: const EdgeInsets.all(8.0),
       	  child:          DropdownButtonHideUnderline(
       	    child: DropdownButton(
       	      isExpanded: false,
       	      // value: projects[0]["projectName"],
       	      items: projects.map((project) {
       	        return DropdownMenuItem(
       	          child: Text(project[
       	              "projectName"]), //label of item
       	          value: project[
       	              "projectName"], //value of item
       	        );
       	      },).toList(),
       	      onChanged: (value) {
       	        setState(() {
       	          // selectedProject = true;
       	          // _currentSelectedValue =
       	              value.toString();
       	          selectedValue =
       	              value.toString();
       	          // print(
       	          //     _currentSelectedValue);
       	        },);
       	      },
       	      hint: Container(
       	        margin:
       	            EdgeInsets.only(left: 8),
       	        // width: 150, //and here
       	        child: Text(
       	          1==1
       	              ? selectedValue
       	              : "Select ",
       	          style: GoogleFonts.poppins(
       	              textStyle: TextStyle(
       	                  fontSize: 14,
       	                  color: Colors.black,
       	                  fontWeight:
       	                      FontWeight
       	                          .w400)),
       	        ),
       	      ),
       	      style: TextStyle(
       	          color: Colors.black,
       	          decorationColor:
       	              Colors.red),
       	    ),
       	  )
                                                 	),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 4),
          child: TextFormField(
              
            decoration: InputDecoration(
              hintText: tasks["taskName"],
              border: OutlineInputBorder(borderSide: BorderSide.none),
              disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green),
              
              
              ),
              
            ),
            onChanged: (value){
      tasks["taskName"]=value.toString();
                    
              // updateValue(index.toString(), value, "taskName");
            },
            validator: (value){
              if(value==""){
                return "Task Name Required";
              }
            },

          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 4),
          child: TextFormField(
              
            decoration: InputDecoration(
              hintText: index.toString(),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green),
              
              )
            ),
            onChanged: (value){
      tasks["issueId"]=value.toString();

              // issue_id=value;
              // updateValue(index.toString(), value.toString(),"issueId");
            },
            validator: (value){
              if(value==""){
                return "Issue ID Required";
              }
            },

          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            
            readOnly: true,
            controller: startTimecontrollers[index-1],
            onTap: ()async{
          print(index);
          print(startTimecontrollers.length);
          // startTimecontrollers[index-1].text="DELE";
           var val= await  _selectTime(context,startTimecontrollers[index-1],index-1);
           startTimecontrollers[index-1].text=val;
           print("cccccc");
           print(val.toString());
            //  tasks["startTime"]=startTime.text;
     
            // showPicker(context);
            },
            decoration: InputDecoration(
              
            border: OutlineInputBorder(borderSide: BorderSide.none),
            // hintText: index.toString()

          ),
   onChanged: (value){},
          validator: (value){
              if(value==""){
                return "Start Time Required";
              }
            },
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            
            readOnly: true,
            controller: endTimecontrollers[index-1],
            onTap: ()async{
          print(index);
          print(endTimecontrollers.length);
          // startTimecontrollers[index-1].text="DELE";
           var val= await  _selectTime(context,endTimecontrollers[index-1],index-1,startTime: startTimecontrollers[index-1].text.toString(),cal: true);
           endTimecontrollers[index-1].text=val;
           print("cccccc");
           print(val.toString());
            //  tasks["startTime"]=startTime.text;
     
            // showPicker(context);
            },
            decoration: InputDecoration(
              
            border: OutlineInputBorder(borderSide: BorderSide.none),
            // hintText: index.toString()

          ),
   onChanged: (value){},
          validator: (value){
              if(value==""){
                return "End Time Required";
              }
            },
          ),
        ),
        Center(child: Text(tasks["duration"])),
       	Padding(
       	  padding: const EdgeInsets.all(8.0),
       	  child: DropdownButton(
				elevation: 0,
        underline: Container(),
			// Initial Value
			value: dropdownvalue,
				
			// Down Arrow Icon
			icon: const Icon(Icons.keyboard_arrow_down),	
				
			// Array list of items
			items: items.map((String items) {
				return DropdownMenuItem(
				value: items,
				child: Text(items),
				);
			}).toList(),
			// After selecting the desired option,it will
			// change button value to selected value
			onChanged: (String? newValue) {
      tasks["status"]=newValue.toString();

      // updateValue(index.toString(), newValue.toString(), "status");
				setState(() {
				// dropdownvalue = newValue!;
				});
			},
			),
       	),
         Padding(
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 4),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                    
                  decoration: InputDecoration(
                  
                    hintText: "Description",
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green),
                    
                    )
                  ),
                  onChanged: (value){
      // updateValue(index.toString(), value.toString(), "description");
      tasks["description"]=value.toString();


                  },
                   validator: (value){
              if(value==""){
                return "Description Required";
              }
            },
              
                ),
              ),
           
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              
              count==2? GestureDetector(
                onTap: (){
                  setState(() {
                    count=count-1;
                  });
                },
                child: Container(
                  height: 24,
                  width: 24,
                   alignment: Alignment.center,
                  decoration: BoxDecoration(color: Color.fromRGBO(202, 9, 9, 0.2),shape: BoxShape.circle),
                  
                  child: Icon(Icons.close,size: 14,color: Color.fromRGBO(202, 9, 9, 1),)),
              ):
              Container()
            ),
            ],
          ),
        ),
      ]
   );

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
      children: cells
          .map((e) => Container(
                color: isHeader
                    ? Color.fromRGBO(41, 93, 192, 0.2)
                    : Colors.transparent,
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  e,
                  style: TextStyle(
                      color: e == "Completed"
                          ? Colors.green
                          : e == "In Progress"
                              ? Colors.red
                              : Colors.black),
                )),
              ))
          .toList());

updateValue(String key,String value,String keyName){
  String foundKey="error";
// for(var map in values){
//     if(map.containsKey(key)){
//       print(map[key]);
//       print(key);
//       if(map[key]==key){
//         foundKey=key;
//       }
//     }
//   }
//   if("error"!=foundKey){
//     values.removeWhere((element) {
//     return element[key]==foundKey;
//     } 
//     );
//   }
  for(var map in values){
    if(map.containsKey("id")){
      print(map["id"]);
      print(key);
      if(map["id"]==key){
        foundKey=key;
      }
    }
  }
  if("error"!=foundKey){
    values.removeWhere((element) {
    return element["id"]==foundKey;
    } 
    );
  }
  Map<String ,dynamic> json1={


    // "id":key,"task":[
    //   {
    //     keyName:value
    //   }
    // ]
  };
  // json1["tasks"]=key;
  json1[keyName]=value;
  // json1['String'+key.toString()+'Var']=value;
  values.add(json1);
  print("\n");
  print("\n");
  print("\n");
  print("\n");
  print("\n");
  print(values.toString());
}

}


