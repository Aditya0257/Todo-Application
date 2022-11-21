import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../main.dart';
import '../home/homescreen.dart';




class ViewtaskScreen extends StatelessWidget {

  ViewtaskScreen({required this.indexchanger,
    required this.view_task_list});

  int indexchanger;

  List<urgent_tasks_class> view_task_list = [];


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
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: double.infinity,
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Create New Task',
                    style: TextStyle(
                        color: Colors.white, fontSize: 25, letterSpacing: 1.2),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                width: double.infinity,
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 3.5, right: 3.5, bottom: 3.5),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: Colors.white24,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Text(
                        "${view_task_list[indexchanger].title}",
                        style: const TextStyle(
                            color: Colors.white60,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
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
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: Colors.white24,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "${view_task_list[indexchanger].description}",
                          style: const TextStyle(
                              color: Colors.white60,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold),
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
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                        color: Colors.white24,
                        child: Center(
                          child: Text(
                            "${view_task_list[indexchanger].date}",
                            style: const TextStyle(
                                color: Colors.white60,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold),
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
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                        color: Colors.white24,
                        child: Center(
                          child: Text(
                            "${view_task_list[indexchanger].time}",
                            style: const TextStyle(
                                color: Colors.white60,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold),
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
                    value: true,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.blueAccent;
                          }
                          return Colors.grey;
                        }),
                    onChanged: (newBool) {},
                    checkColor: Colors.white,
                  ),
                  const Text(
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
                    vertical: MediaQuery.of(context).size.width * 0.014,
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextButton(
                    onPressed: () async {

                      try {
                        FirebaseFirestore.instance
                            .collection('tasks')
                            .doc(
                            "on ${(view_task_list[indexchanger].date)} at ${(view_task_list[indexchanger].time)} by ${(loggedUser)}")
                            .set({
                          'title': view_task_list[indexchanger].title,
                          'description': view_task_list[indexchanger].description,
                          'date': view_task_list[indexchanger].date,
                          'time': view_task_list[indexchanger].time,
                          'urgent': 'true',
                          'sender': loggedUser,
                          'complete': 'complete',
                        });
                      } catch (e) {
                        print(e);
                      }
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Mark As Completed',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
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
