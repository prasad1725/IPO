import 'dart:convert';

import 'package:dypiu_ipo/Admin/mobile/AdminAddMentor.dart';
import 'package:dypiu_ipo/Admin/mobile/AdminDrawer.dart';
import 'package:dypiu_ipo/Admin/mobile/AdminEditMentor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminManageMentor extends StatefulWidget {
  const AdminManageMentor({super.key});

  @override
  State<AdminManageMentor> createState() => _AdminManageMentorState();
}

class _AdminManageMentorState extends State<AdminManageMentor> {
  List<dynamic> mentor = [];
  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/getMentor'));
    if (response.statusCode == 200) {
      setState(() {
        mentor = json.decode(response.body)['mentor'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void initState() {
    super.initState();
    fetchData();
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
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => MyLogin()));
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
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Manage Mentor',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  // width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      DataTable(
                        columns: [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Department')),
                          DataColumn(label: Text('Edit')),
                        ],
                        // rows: listOfColumns
                        //     .map((element) => DataRow(
                        //           cells: [
                        //             DataCell(Text(element["Name"])),
                        //             DataCell(Text(element["PRN"])),
                        //             DataCell(Text(element["Email"])),
                        //             DataCell(Text(element["Track"])),
                        //             DataCell(Text(element["Track"])),
                        //             DataCell(Text(element["Track"])),
                        //           ],
                        //         ))
                        //     .toList(),
                        rows: mentor.map((mentor) {
                          return DataRow(
                            cells: [
                              DataCell(Text(mentor['name'] ?? '')),
                              DataCell(Text(mentor['email']?.toString() ?? '')),
                              DataCell(Text(mentor['department'] ?? '')),
                              DataCell(Icon(Icons.edit), onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminEditMentor(
                                            mentorId: mentor['id'].toString(),
                                            mentorName: mentor['name'],
                                            mentorEmail:
                                                mentor['email'].toString(),
                                            department: mentor['department'])));
                              }),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminAddMentor()));
                },
                child: Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: const Text(
                    'Add Mentor',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
