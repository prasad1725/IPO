import 'dart:convert';

import 'package:flutter/material.dart';

import '../../login.dart';
import '../../methods/api.dart';
import 'AdminDrawer.dart';
import 'AdminManageMentors.dart';

class AdminEditMentor extends StatefulWidget {
  final String mentorId;
  final String mentorName;
  final String mentorEmail;
  final String department;
  const AdminEditMentor({
    Key? key,
    required this.mentorId,
    required this.mentorName,
    required this.mentorEmail,
    required this.department,
  }) : super(key: key);

  @override
  State<AdminEditMentor> createState() => _AdminEditMentorState();
}

class _AdminEditMentorState extends State<AdminEditMentor> {
  String dropdownValue = 'MCA';
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  void addMentor(BuildContext context) async {
    // Prepare the data to be sent
    final data = {
      'id': widget.mentorId,
      'name': name.text,
      'email': email.text,
      'role': '2', // Assuming role should be a string
      'department': dropdownValue,
    };

    // Show loading dialog
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    final result = await API().postRequest(route: '/editmentor', data: data);
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
          builder: (context) => AdminManageMentor(),
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

  void initState() {
    super.initState();
    name = TextEditingController(text: widget.mentorName);
    email = TextEditingController(text: widget.mentorEmail);
    dropdownValue = widget.department;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Mentor',
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
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             MentorProfile(userId: userId)));
                      },
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Edit Mentor',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    labelText: 'Name',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    labelText: 'Email',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['MCA', 'BCA', 'BTech']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: TextButton(
                      onPressed: () {
                        addMentor(context);
                      },
                      child: Container(
                        height: 35,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xfff2722b)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: const Text(
                          'Submit',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
