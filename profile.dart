import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dypiu_ipo/login.dart'; // Import your login.dart file

class MyProfile extends StatefulWidget {
  final int userId;
  const MyProfile({Key? key, required this.userId}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late Future<Map<String, dynamic>> _studentData;

  @override
  void initState() {
    super.initState();
    _studentData = fetchStudentData(widget.userId);
  }

  Future<Map<String, dynamic>> fetchStudentData(int userId) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/student/$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load student data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image(
            image: AssetImage('assets/logo.png'),
          ),
        ),
        title: Text(
          'Profile',
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyProfile(userId: widget.userId)));
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
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: _studentData,
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final studentData = snapshot.data!;
              return buildProfileUI(studentData);
            }
          }
        },
      ),
    );
  }

  Widget buildProfileUI(Map<String, dynamic>? studentData) {
    if (studentData == null) {
      return Center(child: Text('No data available'));
    } else {
      print('Received student data: $studentData');
      final student = studentData['student'];
      return Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    color: Colors.grey,
                  ),
                  Container(
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 90, left: 30, right: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(4, 4),
                                blurRadius: 10,
                              ),
                            ], borderRadius: BorderRadius.circular(100)),
                            child: CircleAvatar(
                              radius: 55,
                              child: Image(
                                image: AssetImage('assets/logo.png'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20, top: 30),
                child: Row(
                  children: [
                    VerticalDivider(
                      width: 20,
                      thickness: 3,
                      color: Colors.orange,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${student['name']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Email: ${student['email']}',
                            ),
                            Text(
                              'PRN: ${student['prn']}',
                            ),
                            Text(
                              'Mobile Number: ${student['mobno']}',
                            ),
                            Text(
                              'Department: ${student['department']}',
                            ),
                            Text(
                              'Track: ${student['track']}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.orange, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(4, 4),
                          blurRadius: 10,
                        ),
                      ]),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Projects',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, right: 20, left: 20, bottom: 40),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.orange, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(4, 4),
                          blurRadius: 10,
                        ),
                      ]),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Internships',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
}


