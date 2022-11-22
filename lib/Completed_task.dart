import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'detailed_task.dart';
import 'edit_task.dart';
import 'main.dart';

List<completed_tasks_class> completed_tasks_list = [];

class completed_tasks_class {
  late String title;
  late String date;
  late String time;
  late String urgent;
  late String description;
  late String complete;
  completed_tasks_class(String Title, String Date, String Time, String Urgent,
      String Description, String Complete) {
    title = Title;
    date = Date;
    time = Time;
    urgent = Urgent;
    description = Description;
    complete = Complete;
  }
}

int completed_tasks_index = 0;

class completed_tasks extends StatelessWidget {
  const completed_tasks({Key? key}) : super(key: key);

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
                  child: Text('Completed Tasks',
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
                      completed_tasks_list.clear();
                      int indee = 0;
                      if (snapshot.hasData) {
                        final task = snapshot.data!.docs;
                        for (var tasks in task) {
                          final complete = tasks['complete'];
                          if (complete == 'complete' &&
                              tasks['sender'] == loggedUser) {
                            indee++;
                            final title = tasks['title'];
                            final description = tasks['description'];
                            final date = tasks['date'];
                            final time = tasks['time'];
                            final urgent = tasks['urgent'];
                            completed_tasks_list.add(completed_tasks_class(
                                title,
                                date,
                                time,
                                urgent,
                                description,
                                complete));
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
                                              '${completed_tasks_list[index].date}\n${completed_tasks_list[index].time}',
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
                                                      completed_tasks_index =
                                                          index;
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) => task_edit(
                                                              title:
                                                                  completed_tasks_list[completed_tasks_index]
                                                                      .title,
                                                              date: completed_tasks_list[
                                                                      completed_tasks_index]
                                                                  .date,
                                                              description:
                                                                  completed_tasks_list[completed_tasks_index]
                                                                      .description,
                                                              time: completed_tasks_list[
                                                                      completed_tasks_index]
                                                                  .time,
                                                              documentname:
                                                                  completed_tasks_list[completed_tasks_index]
                                                                          .date +
                                                                      completed_tasks_list[completed_tasks_index]
                                                                          .time)));
                                                    },
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      completed_tasks_index =
                                                          index;
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("tasks")
                                                          .doc(completed_tasks_list[
                                                                      completed_tasks_index]
                                                                  .date +
                                                              completed_tasks_list[
                                                                      completed_tasks_index]
                                                                  .time +
                                                              loggedUser)
                                                          .delete();
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red),
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
                                            completed_tasks_index = index;
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => detailed_task(
                                                    title: completed_tasks_list[
                                                            completed_tasks_index]
                                                        .title,
                                                    date: completed_tasks_list[completed_tasks_index]
                                                        .date,
                                                    description:
                                                        completed_tasks_list[completed_tasks_index]
                                                            .description,
                                                    time: completed_tasks_list[completed_tasks_index]
                                                        .time,
                                                    checker: completed_tasks_list[
                                                            completed_tasks_index]
                                                        .urgent,
                                                    document_name:
                                                        completed_tasks_list[completed_tasks_index].date +
                                                            completed_tasks_list[completed_tasks_index]
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
                                                              completed_tasks_list[
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
                                                              color:
                                                                  Colors.green),
                                                          child: const Center(
                                                            child: Text(
                                                                'Complete',
                                                                style: TextStyle(
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
