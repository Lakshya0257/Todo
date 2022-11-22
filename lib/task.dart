import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'alertdialog.dart';
import 'main.dart';

//to create new task
class Newtask extends StatefulWidget {
  const Newtask({Key? key}) : super(key: key);

  @override
  State<Newtask> createState() => _NewtaskState();
}

class _NewtaskState extends State<Newtask> {
  final _firestore=FirebaseFirestore.instance;
  bool? ischecked=false;
  DateTime now = DateTime(DateTime.now().hour,DateTime.now().minute);
  late String title;
  late String description;
  String date='${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  String time='${DateTime.now().hour}:${DateTime.now().minute}';

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
              const Text('Create New Task',
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
                      child: TextField(
                        onChanged: (value){
                          title=value;
                        },
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style:
                            const TextStyle(color: Colors.white, fontFamily: 'Mukta'),
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
                      child: TextField(
                        onChanged: (value){
                          description=value;
                        },
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style:
                            const TextStyle(color: Colors.white, fontFamily: 'Mukta'),
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
                    width: MediaQuery.of(context).size.width*.4,
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
                            style: const TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Mukta'),
                            type: DateTimePickerType.date,
                            dateMask: 'dd MMM, yyyy',
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            dateLabelText: 'Date',
                            timeLabelText: "Hour",
                            onChanged: (value){
                              date=value;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.event,color: Colors.grey,)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*.4,
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
                            style: const TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Mukta'),
                            type: DateTimePickerType.time,
                            timeLabelText: "Hour",
                            onChanged: (value){
                              time=value;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Time',
                                labelStyle: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Mukta'),
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.timer_outlined,color: Colors.grey,)
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
                      value: ischecked,
                      activeColor: Colors.blue,
                      fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.blue;
                        }
                        return Colors.grey;
                      }),
                      onChanged: (newBool){
                        setState((){
                          ischecked=newBool;
                        });

                  }),
                  const Text('Mark as Urgent',
                      style: TextStyle(
                          color: Colors.grey, fontSize: 20, fontFamily: 'Mukta')),
                ],
              ),
              TextButton(
                onPressed: () {
                  try{
                    _firestore.collection('tasks').doc(date+time+loggedUser).set({
                      'title':title,
                      'description':description,
                      'date':date,
                      'time':time,
                      'urgent':ischecked.toString(),
                      'complete':'incomplete',
                      'sender':loggedUser
                    });
                  Navigator.of(context).pop();}
                      catch(e){
                        alert_title="Missing Data!";
                        alert_content='Kindly enter all the details of task';
                        showAlertDialog(context);
                      }
                },
                child: Container(
                    width: 180,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                        child: Text(
                          'Create Task',
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






