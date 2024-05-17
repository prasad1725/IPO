import 'package:dypiu_ipo/User/notifications.dart';
import 'package:dypiu_ipo/User/profile.dart';
import 'package:dypiu_ipo/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyTitleSubmission extends StatefulWidget {
  final String subject;
  final String id;
  final String desc;
  final String from_date;
  final String to_date;
  final String type;

  const MyTitleSubmission({
    Key? key,
    required this.subject,
    required this.id,
    required this.desc,
    required this.from_date,
    required this.to_date,
    required this.type,
  }) : super(key: key);

  @override
  State<MyTitleSubmission> createState() => _MyTitleSubmissionState();
}

class _MyTitleSubmissionState extends State<MyTitleSubmission> {
  late int userId = 0;
  int userStatus = 0;
  bool check = false;

  TextEditingController name = TextEditingController();
  TextEditingController prn = TextEditingController();
  TextEditingController course = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController sem = TextEditingController();
  TextEditingController track = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController area = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserIdFromSession().then((value) {
      setState(() {
        userId = value;
        // Fetch user data once userId is obtained
        fetchUserData();
      });
    });
  }

  Future<int> getUserIdFromSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;
    return userId;
  }

  Future<void> fetchUserData() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8000/api/student/$userId'));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        Map<String, dynamic> userData = responseData['student'];
        setState(() {
          name.text = userData['name'];
          prn.text = userData['prn'].toString();
          course.text = userData['department'];
          year.text = '2022';
          sem.text = course.text = userData['semester'];
          track.text = userData['track'];
          mobile.text = userData['mobno'].toString();
          userStatus = userData['status'];
        });
      } else {
        print('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void submitData(BuildContext context) async {
    final data = {
      'userId': userId,
      'id': widget.id,
      'subject': widget.type.toString(),
      'title': title.text.toString(),
      'areaOfWork': area.text.toString(),
      'isSponsored': check ? 1 : 0,
    };

    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/submission'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successfully submitted
        final responseData = jsonDecode(response.body);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['message']),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyNotifications()),
        );
      } else {
        // Failed to submit data
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['message']),
          ),
        );
      }
    } catch (e) {
      print('Error submitting data: $e');
      // Handle error, optionally show an error message to the user
    }
  }

  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDateTime =
        DateFormat('EEEE, d MMMM y, hh:mm a').format(dateTime);
    return formattedDateTime;
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
          widget.subject,
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
                                builder: (context) =>
                                    MyProfile(userId: userId)));
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'Opened: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                  text: _formatDateTime(widget.from_date),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Due: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                  text: _formatDateTime(widget.to_date),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ]),
                        ),
                        Divider(),
                        Text(
                          widget.desc,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (userStatus == 1) ...[
                  TextField(
                    controller: name,
                    readOnly: true,
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
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: prn,
                          readOnly: true,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            labelText: 'PRN',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: TextField(
                          controller: course,
                          readOnly: true,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            labelText: 'Course',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: TextField(
                          controller: year,
                          readOnly: true,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            labelText: 'Year',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: TextField(
                          controller: sem,
                          readOnly: true,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            labelText: 'Sem',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: track,
                          readOnly: true,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            labelText: 'Track',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 2,
                        child: TextField(
                          controller: mobile,
                          readOnly: true,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            labelText: 'Mobile Number',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: title,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      labelText: 'Title of Project/Company Name',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: area,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      labelText: 'Area of Work',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CheckboxListTile(
                    title: const Text(
                      'Is it sponsored ?',
                      style: TextStyle(fontSize: 16),
                    ),
                    value: this.check,
                    onChanged: (bool? value) {
                      setState(() {
                        this.check = value ?? false;
                      });
                    },
                    visualDensity:
                        VisualDensity(horizontal: -4.0, vertical: -4.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: TextButton(
                      onPressed: () {
                        submitData(context);
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
                ] else
                  SizedBox(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You don\'t have access\nPlease contact your Guide',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
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
