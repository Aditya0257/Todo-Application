import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/main.dart';
import '../home/homescreen.dart';


class Edit_taskScreen extends StatelessWidget {

  Edit_taskScreen({required this.indexchanger,
    required this.edit_task_list});

  int indexchanger;

  List<urgent_tasks_class> edit_task_list = [];


  bool ischecked = false;

  String task_title = "";
  String task_date =
      "";
  String task_time = "";
  String task_description = "";

  @override

  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Edit Task',
                    style: TextStyle(
                        color: Colors.white, fontSize: 25, letterSpacing: 1.2),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3.5, right: 3.5 , bottom: 3.5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: Colors.white24,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: TextFormField(

                        initialValue: edit_task_list[indexchanger].title,
                        onChanged: (value) {
                          task_title = value;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isCollapsed: true,
                          labelText: 'Title',
                          labelStyle: TextStyle(
                              color: Colors.white60, fontFamily: 'Quicksand'),
                          prefixIcon: Icon(
                            Icons.title_outlined,
                            color: Colors.white60,
                          ),
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(3.5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: Colors.white24,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          initialValue: edit_task_list[indexchanger].description,
                          onChanged: (value) {
                            task_description = value;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isCollapsed: true,
                            labelText: 'Description',
                            labelStyle: TextStyle(
                                color: Colors.white60, fontFamily: 'Quicksand'),
                            prefixIcon: Icon(
                              Icons.description_outlined,
                              color: Colors.white60,
                            ),
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Padding(
                      padding: const EdgeInsets.all(3.5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                        color: Colors.white24,
                        child: Center(
                          child: DateTimePicker(
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Quicksand',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            type: DateTimePickerType.date,
                            dateMask: 'dd MMM, yyyy',
                            initialValue: edit_task_list[indexchanger].date,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            onChanged: (value) {
                              task_date = value;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.event,
                                color: Colors.white60,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Padding(
                      padding: const EdgeInsets.all(3.5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                        color: Colors.white24,
                        child: Center(
                          child: DateTimePicker(
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Quicksand',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            type: DateTimePickerType.time,
                            initialValue: edit_task_list[indexchanger].time,
                            onChanged: (value) {
                              task_time = value;
                              print(task_time);
                            },


                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.timer_outlined,
                                color: Colors.white60,
                              ),
                              labelText: 'Time',
                              labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: 'Quicksand'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    activeColor: Colors.blueAccent,
                    value: ischecked,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.blueAccent;
                          }
                          return Colors.grey;
                        }),
                    onChanged: (newBool) {
                      ischecked = newBool!;
                      (context as Element).markNeedsBuild();
                    },
                    checkColor: Colors.white,
                  ),
                  Text(
                    'Mark as Urgent',
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 20,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.075,
                width: MediaQuery.of(context).size.width * 0.35,
                child: Card(
                  color: Colors.blue,
                  margin: EdgeInsets.symmetric(
                    //horizontal: MediaQuery.of(context).size.width*0.1,
                    vertical: MediaQuery.of(context).size.width * 0.014,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextButton(
                    onPressed: () {


                      try {
                        if (task_title == ""){
                          task_title = edit_task_list[indexchanger].title;
                        }if (task_description == ""){
                          task_description = edit_task_list[indexchanger].description;
                        }if (task_time == "" ){
                          task_time = edit_task_list[indexchanger].time;
                        } if (task_date == ""){
                          task_date = edit_task_list[indexchanger].date;
                        }
                        FirebaseFirestore.instance
                            .collection('tasks')
                            .doc("on ${(edit_task_list[indexchanger].date)} at ${(edit_task_list[indexchanger].time)} by ${(loggedUser)}")
                            .update( {
                          'title': task_title,
                          'description': task_description,
                          'date': task_date,
                          'time': task_time,
                          'urgent': ischecked.toString(),
                          'sender': loggedUser,
                          'complete': 'incomplete',

                        });


                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Update Task',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
