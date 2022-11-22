import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/main.dart';

class detailed_task extends StatelessWidget {
  detailed_task({
    Key? key,
    required this.title,
    required this.date,
    required this.description,
    required this.time,
    required this.checker,
    required this.document_name,
  }) : super(key: key);

  String checker;
  String title;
  String description;
  String date;
  String time;
  String document_name;
  late bool checkbox;
  @override
  Widget build(BuildContext context) {
    if (checker == 'true') {
      checkbox = true;
    } else {
      checkbox = false;
    }
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
              const Text('Task',
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
                    child: Row(
                      children: [
                        const Icon(
                          Icons.title,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: SizedBox(
                              child: SingleChildScrollView(
                            child: Text(title,
                                maxLines: null,
                                softWrap: true,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Mukta')),
                          )),
                        )
                      ],
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
                    child: Row(
                      children: [
                        const Icon(
                          Icons.description_outlined,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: SizedBox(
                              child: SingleChildScrollView(
                            child: Text(description,
                                maxLines: null,
                                softWrap: true,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Mukta')),
                          )),
                        )
                      ],
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
                          child: Text(date,
                              maxLines: null,
                              softWrap: true,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Mukta')),
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
                          child: Text(time,
                              maxLines: null,
                              softWrap: true,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Mukta')),
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
                      value: checkbox,
                      activeColor: Colors.blue,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.blue;
                        }
                        return Colors.grey;
                      }),
                      onChanged: (newBool) {}),
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
                      .collection('tasks')
                      .doc(document_name + loggedUser)
                      .update({'complete': 'complete'});
                  Navigator.of(context).pop();
                },
                child: Container(
                    width: 180,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                        child: Text(
                      'Mark As Completed',
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
