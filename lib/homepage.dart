import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo/detailed_task.dart';
import 'package:todo/edit_task.dart';
import 'Getx/GetX_task_progress.dart';

import 'main.dart';

//urgent tasks list with their index value and structure
List<urgent_tasks_class> urgent_tasks = [];
int urgent_task_index = 0;

class urgent_tasks_class {
  late String title;
  late String date;
  late String time;
  late String urgent;
  late String description;
  urgent_tasks_class(
    String Title,
    String Date,
    String Time,
    String Urgent,
    String Description,
  ) {
    title = Title;
    date = Date;
    time = Time;
    urgent = Urgent;
    description = Description;
  }
}

//homepage
class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final _firestore = FirebaseFirestore.instance;
  bool loader = false;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      if (user != null) {
        loggedUser = user.email.toString();
      }
    } catch (e) {}
  }

  TaskProgress controller=Get.put(TaskProgress());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'TODO',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 25,
                                fontFamily: 'Mukta'),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.notifications,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                      Text(
                        loggedUser.substring(0, loggedUser.indexOf('@')),
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontFamily: 'Mukta'),
                      ),
                      const Text(
                        'Be productive today',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Mukta'),
                      ),
                      const SizedBox(
                        width: double.maxFinite,
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          color: Colors.white12,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Mukta'),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                labelText: 'Search',
                                labelStyle: TextStyle(
                                    color: Colors.grey, fontFamily: 'Mukta'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          color: Colors.white12,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                            child: GetBuilder<TaskProgress>(
                              builder: (_){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          'Task Progress',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Mukta',
                                              fontSize: 20),
                                        ),
                                        Text(
                                          '${controller.completed}/${controller.completed + controller.incomplete}  task done',
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Mukta',
                                              fontSize: 15),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 90,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                              child: Text(
                                            controller.incomplete+controller.completed==0
                                                ? "Nothing Left"
                                                : controller.date,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Mukta',
                                                fontSize: 15),
                                          )),
                                        )
                                      ],
                                    ),
                                  Center(
                                      child: CircularPercentIndicator(
                                        radius: 40,
                                        percent: controller.incomplete+controller.completed==0
                                            ? 1
                                            : controller.task_ratio,
                                        progressColor: Colors.blue,
                                        lineWidth: 8,
                                        center: Text(
                                          controller.incomplete+controller.completed==0
                                              ? "100%"
                                              : '${controller.percentage_task}%',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ))
                                ],
                              );
  }
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(children: [
                SingleChildScrollView(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                        'images/3136cd447c99783f59cd1a4c7d9ca9c1.png'),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('all_tasks');
                                      },
                                      child: Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Center(
                                              child: Text(
                                            'All Tasks',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontFamily: 'Mukta'),
                                          ))),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'images/task-plan-5365258-4500126.png',
                                          scale: 7,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed('completed_task');
                                          },
                                          child: Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: const Center(
                                                  child: Text(
                                                'Completed',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    fontFamily: 'Mukta'),
                                              ))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'images/study-material-3327976-2793945.png',
                                          scale: 7,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed('incomplete_task');
                                          },
                                          child: Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: const Center(
                                                  child: Text(
                                                'Incomplete',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    fontFamily: 'Mukta'),
                                              ))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Urgent Tasks',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: 'Mukta'),
                            ),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: 400,
                            child: StreamBuilder<QuerySnapshot>(
                                stream:
                                    _firestore.collection('tasks').snapshots(),
                                builder: (context, snapshot) {
                                  urgent_tasks.clear();
                                  int complete = 0;
                                  String date = '';
                                  int incomplete = 0;
                                  int indee = 0;
                                  if (snapshot.hasData) {
                                    final task = snapshot.data!.docs;
                                    final task1 = snapshot.data!.docs;
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }
                                    for (var tasks in task) {
                                      if (date == '' &&
                                          tasks['complete'] == 'incomplete' &&
                                          tasks['sender'] == loggedUser) {
                                        date = tasks['date'];
                                      }
                                      if(tasks['date']==date && tasks['sender']==loggedUser && tasks['complete']=='incomplete'){
                                        incomplete++;
                                      }
                                      else if(incomplete==0){
                                        date='';
                                      }

                                      if (tasks['urgent'] == 'true' &&
                                          tasks['complete'] == 'incomplete' &&
                                          tasks['sender'] == loggedUser) {
                                        indee++;
                                        final title = tasks['title'];
                                        final description =
                                            tasks['description'];
                                        final date = tasks['date'];
                                        final time = tasks['time'];
                                        final urgent = tasks['urgent'];
                                        urgent_tasks.add(urgent_tasks_class(
                                            title,
                                            date,
                                            time,
                                            urgent,
                                            description));
                                      }
                                    }
                                    for(var taskss in task1){
                                      print(date+incomplete.toString());
                                      if (taskss['date'] == date &&
                                          taskss['sender'] == loggedUser) {
                                        if (taskss['complete'] == 'complete') {
                                          complete++;
                                        }
                                      }
                                    }
                                    Future.delayed(Duration.zero,(){
                                      controller.values(complete, incomplete, date);
                                    });
                                  }
                                  return  indee == 0
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'images/completed-tasks-illustration-512x462-mhurwnzu.png',
                                              scale: 3,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              'Nothing Urgent!',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 25,
                                                  fontFamily: 'Mukta'),
                                            )
                                          ],
                                        )
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: indee,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .3,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '${urgent_tasks[index].date}\n${urgent_tasks[index].time}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 17,
                                                                  fontFamily:
                                                                      'Mukta'),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Expanded(
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  urgent_task_index =
                                                                      index;
                                                                  Navigator.of(context).push(MaterialPageRoute(
                                                                      builder: (context) => task_edit(
                                                                          title: urgent_tasks[urgent_task_index]
                                                                              .title,
                                                                          date: urgent_tasks[urgent_task_index]
                                                                              .date,
                                                                          description: urgent_tasks[urgent_task_index]
                                                                              .description,
                                                                          time: urgent_tasks[urgent_task_index]
                                                                              .time,
                                                                          documentname:
                                                                              urgent_tasks[urgent_task_index].date + urgent_tasks[urgent_task_index].time)));
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.edit,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  urgent_task_index =
                                                                      index;
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "tasks")
                                                                      .doc(urgent_tasks[urgent_task_index]
                                                                              .date +
                                                                          urgent_tasks[urgent_task_index]
                                                                              .time +
                                                                          loggedUser)
                                                                      .delete();
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 20,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: TextButton(
                                                      onPressed: () {
                                                        urgent_task_index =
                                                            index;
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) => detailed_task(
                                                                title:
                                                                    urgent_tasks[urgent_task_index]
                                                                        .title,
                                                                date:
                                                                    urgent_tasks[urgent_task_index]
                                                                        .date,
                                                                description:
                                                                    urgent_tasks[urgent_task_index]
                                                                        .description,
                                                                time: urgent_tasks[
                                                                        urgent_task_index]
                                                                    .time,
                                                                checker:
                                                                    urgent_tasks[urgent_task_index]
                                                                        .urgent,
                                                                document_name: urgent_tasks[urgent_task_index]
                                                                        .date +
                                                                    urgent_tasks[urgent_task_index]
                                                                        .time)));
                                                      },
                                                      child: Container(
                                                        height: 100,
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                            color:
                                                                Colors.white24),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                  'Title:   ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          17,
                                                                      fontFamily:
                                                                          'Mukta')),
                                                              Expanded(
                                                                child: Column(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child: Text(
                                                                          urgent_tasks[index]
                                                                              .title,
                                                                          maxLines:
                                                                              3,
                                                                          overflow: TextOverflow
                                                                              .fade,
                                                                          softWrap:
                                                                              true,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 15,
                                                                              fontFamily: 'Mukta')),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                }),
                          )
                        ],
                      )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('newtask');
                    },
                    child: Container(
                        width: 180,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                            child: Text(
                          'Add new task + ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'Mukta'),
                        ))),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
