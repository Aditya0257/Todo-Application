import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/main.dart';
import '../edit_tasks/edit_taskscreen.dart';
import '../notification/notification_screen.dart';
import '../view_tasks/viewtaskscreen.dart';



//urgent tasks list with their index value and structure
List<urgent_tasks_class> urgent_tasks = [];
int urgent_task_index = 0;

class urgent_tasks_class {
  String title = '';
  String description = '';
  String date = '';
  String time = '';
  String urgent = '';
  String complete = '';
  urgent_tasks_class(String Title, String Description, String Date, String Time,
      String Urgent, String Complete) {
    title = Title;
    description = Description;
    date = Date;
    time = Time;
    urgent = Urgent;
    complete = Complete;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        loggedUser = user.email.toString();
      }
    } catch (e) {}
  }

  int incomplete = 0;
  int complete = 0;
  String date = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(21.0),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('TODO',
                            style:
                            TextStyle(fontSize: 24, color: Colors.white60)),
                        TextButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NotificationScreen()));
                          },
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white60,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.045,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 5),
                      child: Text(
                        loggedUser.substring(0, loggedUser.indexOf('@')),
                        style: const TextStyle(
                            color: Colors.white60, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width,
                    child: const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        'Be Productive Today',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.085,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Card(
                        color: Colors.white24,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            onChanged: (value) {
                              var searched_data = value;
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                contentPadding: EdgeInsets.all(6),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white60,
                                ),
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: "Search"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          )),
                      color: Colors.white24,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 20, bottom: 12, left: 12),
                                child: Text(
                                  'Task Progress',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "${complete}/${complete + incomplete} task done",
                                  style: TextStyle(
                                      color: Colors.white60, fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.33,
                                child:  Card(
                                  margin: EdgeInsets.all(12.0),
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      date,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.09,
                                child: CircularPercentIndicator(
                                  radius: 33.0,
                                  animation: true,
                                  animationDuration: 1200,
                                  lineWidth: 8.0,
                                  percent: complete/(complete + incomplete),
                                  center: Text(
                                    ((complete/(complete + incomplete))*100).toStringAsFixed(2),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        fontFamily: 'Quicksand'),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.butt,
                                  backgroundColor: Colors.white,
                                  progressColor: Colors.blue,
                                ),
                              ),
                              Center(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {

                                          });
                                        },
                                        child: const Icon(
                                          Icons.refresh,
                                          color: Colors.white60,
                                          size: 33,
                                        )),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.36,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width * 0.4,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/images/task_checking_image.png',
                                          scale: 3,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.25,
                                          child: Card(
                                            color: Colors.blue,
                                            margin: EdgeInsets.symmetric(
                                              //horizontal: MediaQuery.of(context).size.width*0.1,
                                              vertical: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.014,
                                            ),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/alltasks');
                                              },
                                              child: const Text(
                                                "All Tasks",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontFamily: 'Quicksand',
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(6, 8, 4, 8),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.16,
                                        width:
                                        MediaQuery.of(context).size.width *
                                            0.4,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            color: Colors.white),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                              'assets/images/completed_task_img.webp',
                                              scale: 6.5,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.25,
                                              child: Card(
                                                color: Colors.blue,
                                                margin: EdgeInsets.symmetric(
                                                  vertical:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.020,
                                                ),
                                                shape:
                                                const RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            15))),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        '/completedtasks');
                                                  },
                                                  child: const Text(
                                                    "Completed",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontFamily: 'Quicksand',
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.16,
                                        width:
                                        MediaQuery.of(context).size.width *
                                            0.4,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            color: Colors.white),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                              'assets/images/incomplete_task_img.png',
                                              scale: 7,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.25,
                                              child: Card(
                                                color: Colors.blue,
                                                margin: EdgeInsets.symmetric(
                                                  vertical:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.020,
                                                ),
                                                shape:
                                                const RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            15))),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        '/incompletetasks');
                                                  },
                                                  child: const Text(
                                                    "Incomplete",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontFamily: 'Quicksand',
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.082,
                            width: MediaQuery.of(context).size.width,
                            child: const Padding(
                              padding: EdgeInsets.only(top: 18),
                              child: Text(
                                'Urgent Tasks',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(1)),
                                border: Border.all(
                                    color: Colors.white10, width: 3)),
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

                                  incomplete=0;
                                  complete=0;
                                  urgent_tasks.clear();
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
                                        if (date == "" ) {

                                          if (tasks['complete'] ==
                                              'incomplete' && tasks['sender']==loggedUser) {
                                            date = tasks['date'];
                                          }
                                        }
                                        if (tasks['date']==date && tasks['sender']==loggedUser){
                                          if (tasks['complete'] == 'complete'){
                                            complete++;
                                          }
                                          else {
                                            incomplete++;
                                          }

                                        }
                                        else if(incomplete == 0){
                                          date = "";
                                        }
                                        //print(date + complete.toString() + incomplete.toString());
                                        if (tasks['urgent'] == "true" &&
                                            tasks['sender'] == loggedUser &&
                                            tasks['complete'] == 'incomplete') {
                                          indee++;
                                          String title = tasks['title'];
                                          String description =
                                          tasks['description'];
                                          String date = tasks['date'];
                                          String time = tasks['time'];
                                          String urgent = tasks['urgent'];
                                          String complete = tasks['complete'];
                                          urgent_tasks.add(urgent_tasks_class(
                                              title,
                                              description,
                                              date,
                                              time,
                                              urgent,
                                              complete));
                                        }
                                      }
                                    } else {
                                      return const Text("Something Went Wrong");
                                    }
                                  } else {
                                    return Text(
                                        snapshot.connectionState.toString());
                                  }

                                  return indee != 0
                                      ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: indee,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.3,
                                                child: Text(
                                                  '${urgent_tasks[index].date}\n${urgent_tasks[index].time}',
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 17,
                                                      fontFamily:
                                                      'Quicksand'),
                                                ),
                                              ),
                                              Container(
                                                decoration:
                                                const BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          20)),
                                                  color: Colors.white24,
                                                ),
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.52,
                                                height:
                                                MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.11,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        const Text(
                                                          'Title: ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white60,
                                                              fontFamily:
                                                              'Quicksand',
                                                              fontSize: 20),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            urgent_task_index =
                                                                index;
                                                            Navigator.of(context).push(MaterialPageRoute(
                                                                builder: (_) => ViewtaskScreen(
                                                                    indexchanger:
                                                                    urgent_task_index,
                                                                    view_task_list:
                                                                    urgent_tasks)));
                                                          },
                                                          child: Text(
                                                            '${urgent_tasks[index].title}',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white60,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontFamily:
                                                                'Quicksand',
                                                                fontSize:
                                                                20),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            urgent_task_index =
                                                                index;
                                                            Navigator.of(context).push(MaterialPageRoute(
                                                                builder: (_) => Edit_taskScreen(
                                                                    indexchanger:
                                                                    urgent_task_index,
                                                                    edit_task_list:
                                                                    urgent_tasks)));
                                                          },
                                                          child: const Icon(
                                                            Icons.edit,
                                                            color:
                                                            Colors.blue,
                                                            size: 25,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 35,
                                                        ),
                                                        TextButton(
                                                          onPressed:
                                                              () async {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                "tasks")
                                                                .doc(
                                                                "on ${(urgent_tasks[index].date)} at ${(urgent_tasks[index].time)} by ${(loggedUser)}")
                                                                .delete();
                                                          },
                                                          child: const Icon(
                                                            Icons.delete,
                                                            color:
                                                            Colors.red,
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
                                      })
                                      : Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/images/work_life_balance_img.png',
                                        scale: 3,
                                      ),
                                      const Text(
                                        "Nothing Urgent!",
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 25),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.775,
                left: MediaQuery.of(context).size.width * 0.47,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: Colors.blue,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/addnewtasks');
                        },
                        child: const Text(
                          'Add new tasks +',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
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
