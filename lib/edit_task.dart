import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class task_edit extends StatelessWidget {
  task_edit({
    Key? key,
    required this.title,
    required this.date,
    required this.description,
    required this.time,
    required this.documentname,
  }) : super(key: key);

  final _firestore = FirebaseFirestore.instance;
  bool? ischecked = false;
  DateTime now = DateTime(DateTime.now().hour, DateTime.now().minute);
  String title;
  String description;
  String date;
  String time;
  String documentname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(children: [
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
              const Text('Update Task',
                  style: TextStyle(
                      color: Colors.white, fontSize: 25, fontFamily: 'Mukta')),
              SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * .1,
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  color: Colors.white12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: TextFormField(
                        initialValue: title,
                        onChanged: (value) {
                          title = value;
                        },
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(
                            color: Colors.white, fontFamily: 'Mukta'),
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.title_rounded,
                            color: Colors.grey,
                          ),
                          labelText: 'Title',
                          labelStyle: TextStyle(
                              color: Colors.grey, fontFamily: 'Mukta'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * .5,
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  color: Colors.white12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: TextFormField(
                        initialValue: description,
                        onChanged: (value) {
                          description = value;
                        },
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(
                            color: Colors.white, fontFamily: 'Mukta'),
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.description_outlined,
                            color: Colors.grey,
                          ),
                          labelText: 'Description',
                          labelStyle: TextStyle(
                              color: Colors.grey, fontFamily: 'Mukta'),
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
                    width: MediaQuery.of(context).size.width * .4,
                    height: MediaQuery.of(context).size.height * .1,
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      color: Colors.white12,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: DateTimePicker(
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Mukta'),
                            type: DateTimePickerType.date,
                            dateMask: 'dd MMM, yyyy',
                            initialValue: date,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            dateLabelText: 'Date',
                            timeLabelText: "Hour",
                            onChanged: (value) {
                              date = value;
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.event,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    height: MediaQuery.of(context).size.height * .1,
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      color: Colors.white12,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: DateTimePicker(
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Mukta'),
                            type: DateTimePickerType.time,
                            timeLabelText: "Hour",
                            initialValue: time,
                            onChanged: (value) {
                              time = value;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Time',
                                labelStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontFamily: 'Mukta'),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.timer_outlined,
                                  color: Colors.grey,
                                )),
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
                      value: ischecked,
                      activeColor: Colors.blue,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.blue;
                        }
                        return Colors.grey;
                      }),
                      onChanged: (newBool) {
                        ischecked = newBool;
                        (context as Element).markNeedsBuild();
                      }),
                  const Text('Mark as Urgent',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontFamily: 'Mukta')),
                ],
              ),
              TextButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("tasks")
                      .doc(documentname + loggedUser)
                      .delete();
                  _firestore
                      .collection('tasks')
                      .doc(date + time + loggedUser)
                      .set({
                    'title': title,
                    'description': description,
                    'date': date,
                    'time': time,
                    'urgent': ischecked.toString(),
                    'complete': 'incomplete',
                    'sender': loggedUser
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                    width: 180,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                        child: Text(
                      'Update Task',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Mukta'),
                    ))),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
