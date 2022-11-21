import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/main.dart';
import '../edit_tasks/edit_taskscreen.dart';
import '../home/homescreen.dart';
import '../view_tasks/viewtaskscreen.dart';


List<urgent_tasks_class> all_tasks = [];
int all_task_index = 0;



class AlltasksScreen extends StatefulWidget {
  const AlltasksScreen({Key? key}) : super(key: key);

  static String routeName = '/alltasks';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const AlltasksScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  State<AlltasksScreen> createState() => _AlltasksScreenState();
}

class _AlltasksScreenState extends State<AlltasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Expanded(
                flex: 1,
                child: Text(
                  'All Tasks',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Quicksand',
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold),
                )),
            Expanded(
                flex: 10,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(1)),
                      border: Border.all(color: Colors.white10, width: 3)),
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('tasks')
                          .snapshots(),
                      builder: (context, snapshot) {
                        int indee = 0;
                        all_tasks.clear();
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.connectionState ==
                            ConnectionState.done ||
                            snapshot.connectionState ==
                                ConnectionState.active) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else if (snapshot.hasData) {
                            final task = snapshot.data!.docs;
                            for (var tasks in task) {
                              if (tasks['complete'] == 'complete' ||
                                  tasks['complete'] == 'incomplete') {
                                if (tasks['sender'] == loggedUser) {
                                  indee++;
                                  String title = tasks['title'];
                                  String description = tasks['description'];
                                  String date = tasks['date'];
                                  String time = tasks['time'];
                                  String urgent = tasks['urgent'];
                                  String complete = tasks['complete'];

                                  all_tasks.add(urgent_tasks_class(
                                      title,
                                      description,
                                      date,
                                      time,
                                      urgent,
                                      complete));
                                }
                              }
                            }
                          } else {
                            return const Text("Something Went Wrong");
                          }
                        } else {
                          return Text(snapshot.connectionState.toString());
                        }
                        return indee == 0
                            ? Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.3,
                            ),
                            Image.asset(
                              'assets/images/checking_tasks_img.png',
                              scale: 2,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('No Records Found!',
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 20,
                                    color: Colors.white60,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                            : ListView.builder(
                            itemCount: indee,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.3,
                                      child: Text(
                                        '${all_tasks[index].date}\n${all_tasks[index].time}',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,
                                            fontFamily: 'Quicksand'),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Colors.white24,
                                      ),
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.62,
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.12,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Title: ',
                                                style: TextStyle(
                                                    color: Colors.white60,
                                                    fontFamily: 'Quicksand',
                                                    fontSize: 20),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  all_task_index = index;
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (_) => ViewtaskScreen(
                                                              indexchanger:
                                                              all_task_index,
                                                              view_task_list:
                                                              all_tasks)));
                                                },
                                                child: Text(
                                                  '${all_tasks[index].title}',
                                                  style: const TextStyle(
                                                      color: Colors.white60,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      'Quicksand',
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              all_tasks[index].complete ==
                                                  'complete'
                                                  ? Container(
                                                height: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.039,
                                                width: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width *
                                                    0.26,
                                                decoration: const BoxDecoration(
                                                    color:
                                                    Colors.green,
                                                    borderRadius: BorderRadius
                                                        .all(Radius
                                                        .circular(
                                                        15))),
                                                child: const Center(
                                                  child: Text(
                                                    'Completed',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                        fontFamily:
                                                        'Quicksand',
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              )
                                                  : Container(
                                                height: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.039,
                                                width: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width *
                                                    0.26,
                                                decoration: const BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius
                                                        .all(Radius
                                                        .circular(
                                                        15))),
                                                child: const Center(
                                                  child: Text(
                                                    'Incomplete',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                        fontFamily:
                                                        'Quicksand',
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  all_task_index = index;
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          Edit_taskScreen(
                                                              indexchanger:
                                                              all_task_index,
                                                              edit_task_list:
                                                              all_tasks)));
                                                },
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: Colors.blue,
                                                  size: 25,
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: 35,
                                              // ),
                                              TextButton(
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("tasks")
                                                      .doc(
                                                      "on ${(all_tasks[index].date)} at ${(all_tasks[index].time)} by ${(loggedUser)}")
                                                      .delete();
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 25,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
