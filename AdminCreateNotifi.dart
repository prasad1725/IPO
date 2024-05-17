import 'dart:convert';

import 'package:dypiu_ipo/login.dart';
import 'package:flutter/material.dart';

import '../../methods/api.dart';
import 'AdminDrawer.dart';

import 'AdminNotifications.dart';

class AdminCreateNotifi extends StatefulWidget {
  const AdminCreateNotifi({super.key});

  @override
  State<AdminCreateNotifi> createState() => _AdminCreateNotifiState();
}

class _AdminCreateNotifiState extends State<AdminCreateNotifi> {
  Map<String, List<String>> dropdownOptions = {
    'MCA': ['Sem-I', 'Sem-II', 'Sem-III', 'Sem-IV'],
    'BCA': ['Sem-I', 'Sem-II', 'Sem-III', 'Sem-IV', 'Sem-V', 'Sem-VI'],
    'Btech': [
      'Sem-I',
      'Sem-II',
      'Sem-III',
      'Sem-IV',
      'Sem-V',
      'Sem-VI',
      'Sem-VII',
      'Sem-VIII'
    ],
  };

  String dropdownValue = 'MCA';
  String dropvalue = 'Sem-I';
  DateTime dateTime = DateTime.now();

  TextEditingController subjects = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController reminder = TextEditingController();

  void creNoti(BuildContext context) async {
    final data = {
      'subjects': subjects.text.toString(),
      'description': description.text.toString(),
      'reminder': reminder.text.toString(),
    };
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    final result =
        await API().postRequest(route: '/createnotification', data: data);
    final response = jsonDecode(result.body);
    if (response['status'] == 200) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AdminNotifications(),
        ),
      );
    } else {
      if (response['status'] == 500) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message']),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Notifications',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: PopupMenuButton(
              position: PopupMenuPosition.under,
              icon: Icon(Icons.person, color: Colors.grey.shade800),
              itemBuilder: (BuildContext buildcontext) {
                return [
                  PopupMenuItem(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text('My Profile'),
                          )
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyLogin()));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text('Logout'),
                          )
                        ],
                      ),
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
        backgroundColor: Color(0xffF2722B),
      ),
      drawer: AdminDrawer(context),
      bottomNavigationBar: adminNavbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: DropdownButton<String>(
                        underline: Container(color: Colors.transparent),
                        icon: Icon(
                          Icons.expand_more,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Colors.grey.shade300,
                        style: TextStyle(),
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            // When the first dropdown changes, update the options for the second dropdown
                            dropvalue = dropdownOptions[newValue]![0];
                          });
                        },
                        items: dropdownOptions.keys.map((String key) {
                          return DropdownMenuItem<String>(
                            value: key,
                            child: Text(key,
                                style: TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: DropdownButton<String>(
                        underline: Container(color: Colors.transparent),
                        icon: Icon(
                          Icons.expand_more,
                          color: Colors.black,
                        ),
                        dropdownColor: Colors.grey.shade300,
                        style: TextStyle(),
                        value: dropvalue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropvalue = newValue!;
                          });
                        },
                        items:
                            dropdownOptions[dropdownValue]!.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subject',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    TextField(
                      controller: subjects,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: description,
                      maxLines: 5,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Description',
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final date = await pickDate();
                            },
                            child: Text(
                                '${dateTime.year}/${dateTime.month}/${dateTime.day}'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('To'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: reminder,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'No of Reminders',
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: TextButton(
                        onPressed: () {
                          creNoti(context);
                        },
                        child: Container(
                          height: 38,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: const Text(
                            'Add Notification',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
}
