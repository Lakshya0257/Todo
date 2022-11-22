import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/detailed_task.dart';

import 'edit_task.dart';
import 'main.dart';

//list of all tasks with their index and structure
List<all_tasks_class> all_tasks_list = [];

class all_tasks_class {
  late String title;
  late String date;
  late String time;
  late String urgent;
  late String description;
  late String complete;
  all_tasks_class(String Title, String Date, String Time, String Urgent,
      String Description, String Complete) {
    title = Title;
    date = Date;
    time = Time;
    urgent = Urgent;
    description = Description;
    complete = Complete;
  }
}

int all_tasks_index = 0;

//all tasks
class all_tasks extends StatefulWidget {
  const all_tasks({Key? key}) : super(key: key);

  @override
  State<all_tasks> createState() => _all_tasksState();
}

class _all_tasksState extends State<all_tasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * .07,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.keyboard_backspace_rounded,
                        color: Colors.white,
                      )),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Center(
                  child: Text('All Tasks',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Mukta')),
                ),
              ),
              Expanded(
                flex: 10,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('tasks')
                        .snapshots(),
                    builder: (context, snapshot) {
                      all_tasks_list.clear();
                      int indee = 0;
                      if (snapshot.hasData) {
                        final task = snapshot.data!.docs;
                        for (var tasks in task) {
                          if (tasks['sender'] == loggedUser) {
                            indee++;
                            final title = tasks['title'];
                            final description = tasks['description'];
                            final date = tasks['date'];
                            final time = tasks['time'];
                            final urgent = tasks['urgent'];
                            final complete = tasks['complete'];
                            all_tasks_list.add(all_tasks_class(title, date,
                                time, urgent, description, complete));
                          }
                        }
                      }
                      return indee == 0
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/file-not-found-4064359-3363920.png',
                                    scale: 2,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    'No Record Found!',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 25,
                                        fontFamily: 'Mukta'),
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: indee,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        child: Column(
                                          children: [
                                            Text(
                                              '${all_tasks_list[index].date}\n${all_tasks_list[index].time}',
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 17,
                                                  fontFamily: 'Mukta'),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      all_tasks_index = index;
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) => task_edit(
                                                              title:
                                                                  all_tasks_list[all_tasks_index]
                                                                      .title,
                                                              date: all_tasks_list[
                                                                      all_tasks_index]
                                                                  .date,
                                                              description:
                                                                  all_tasks_list[all_tasks_index]
                                                                      .description,
                                                              time: all_tasks_list[
                                                                      all_tasks_index]
                                                                  .time,
                                                              documentname:
                                                                  all_tasks_list[all_tasks_index]
                                                                          .date +
                                                                      all_tasks_list[all_tasks_index]
                                                                          .time)));
                                                    },
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      size: 20,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      all_tasks_index = index;
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("tasks")
                                                          .doc(all_tasks_list[
                                                                      all_tasks_index]
                                                                  .date +
                                                              all_tasks_list[
                                                                      all_tasks_index]
                                                                  .time +
                                                              loggedUser)
                                                          .delete();
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: TextButton(
                                          onPressed: () {
                                            all_tasks_index = index;
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => detailed_task(
                                                    title:
                                                        all_tasks_list[all_tasks_index]
                                                            .title,
                                                    date:
                                                        all_tasks_list[all_tasks_index]
                                                            .date,
                                                    description:
                                                        all_tasks_list[all_tasks_index]
                                                            .description,
                                                    time:
                                                        all_tasks_list[all_tasks_index]
                                                            .time,
                                                    checker:
                                                        all_tasks_list[all_tasks_index]
                                                            .urgent,
                                                    document_name: all_tasks_list[
                                                                all_tasks_index]
                                                            .date +
                                                        all_tasks_list[all_tasks_index]
                                                            .time)));
                                          },
                                          child: Container(
                                            height: 100,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Colors.white24),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  const Text('Title:   ',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 17,
                                                          fontFamily: 'Mukta')),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                              all_tasks_list[
                                                                      index]
                                                                  .title,
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              softWrap: true,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      'Mukta')),
                                                        ),
                                                        Expanded(
                                                            child: Container(
                                                          width: 90,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: all_tasks_list[
                                                                              index]
                                                                          .complete ==
                                                                      'complete'
                                                                  ? Colors.green
                                                                  : Colors.red),
                                                          child: Center(
                                                            child: Text(
                                                                all_tasks_list[index]
                                                                            .complete ==
                                                                        'complete'
                                                                    ? 'Complete'
                                                                    : 'Incomplete',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Mukta')),
                                                          ),
                                                        ))
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
          ),
        ),
      ),
    );
  }
}
