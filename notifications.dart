import 'package:dypiu_ipo/User/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../methods/api.dart';
import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;
import '../login.dart';
import 'docupload.dart';
import 'editsubmission.dart';
import 'titlesubmission.dart';
import 'userMeeting.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({Key? key}) : super(key: key);

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class Notify {
  Future<List> getAllNotification(String department, String semester) async {
    try {
      var response =
          await API().getRequest(route: '/notification/$department/$semester');
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

class Submission {
  Future<Map<String, dynamic>> checkSubmission(int userId, String id) async {
    try {
      var response =
          await API().getRequest(route: '/check-submission/$userId/$id');
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

class _MyNotificationsState extends State<MyNotifications> {
  late int userId = 0;
  late String department = '';
  late String semester = '';
  late DateTime submissionCreatedAt = DateTime.now();

  Notify notificationService = Notify();

  void initState() {
    super.initState();
    getUserDataFromSession().then((value) {
      setState(() {
        userId = value['userId'];
        department = value['department'];
        semester = value['semester'];
      });
    });
  }

  String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    return timeago.format(now.subtract(difference));
  }

  Future<Map<String, dynamic>> getUserDataFromSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId =
        prefs.getInt('userId') ?? 0; // Default value if user_id doesn't exist
    String department = prefs.getString('department') ?? '';
    String semester = prefs.getString('semester') ?? '';
    return {'userId': userId, 'department': department, 'semester': semester};
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
          'Notifications',
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
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder<List>(
              future:
                  notificationService.getAllNotification(department, semester),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, i) {
                      return FutureBuilder<Map<String, dynamic>>(
                        future: Submission().checkSubmission(
                          userId,
                          snapshot.data![i]['id'].toString(),
                        ),
                        builder: (context, submissionSnapshot) {
                          Color? tileColor;
                          // Determine color based on submission status and dates
                          if (submissionSnapshot.hasData) {
                            bool hasSubmitted =
                                submissionSnapshot.data!['hasSubmitted'];
                            DateTime toDate =
                                DateTime.parse(snapshot.data![i]['to_date']);
                            if (hasSubmitted) {
                              if (submissionCreatedAt.isBefore(toDate)) {
                                tileColor =
                                    Colors.green; // Submitted and on time
                              } else {
                                tileColor = Colors
                                    .orange; // Submitted but after due date
                              }
                            } else if (DateTime.now().isAfter(DateTime.parse(
                                    snapshot.data![i]['from_date'])) &&
                                DateTime.now().isBefore(DateTime.parse(
                                    snapshot.data![i]['to_date']))) {
                              tileColor = Colors.grey; // Not submitted
                            } else {
                              tileColor = Colors.red; // Not submitted
                            }
                          }

                          return GestureDetector(
                            onTap: () async {
                              if (submissionSnapshot.hasData &&
                                  submissionSnapshot.data != null) {
                                bool hasSubmitted =
                                    submissionSnapshot.data!['hasSubmitted'];
                                String? createdAtString =
                                    submissionSnapshot.data!['created_at'];
                                if (hasSubmitted && createdAtString != null) {
                                  submissionCreatedAt =
                                      DateTime.parse(createdAtString);
                                }
                                if (hasSubmitted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => editSubmission(
                                        subject: snapshot.data![i]['subjects'],
                                        id: snapshot.data![i]['id'].toString(),
                                        desc: snapshot.data![i]['description'],
                                        from_date: snapshot.data![i]
                                            ['from_date'],
                                        to_date: snapshot.data![i]['to_date'],
                                        userId: userId,
                                      ),
                                    ),
                                  );
                                } else {
                                  final subtype = snapshot.data![i]['subtype'];
                                  if (subtype == 'File') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DocUpload(
                                          subject: snapshot.data![i]
                                              ['subjects'],
                                          id: snapshot.data![i]['id']
                                              .toString(),
                                          desc: snapshot.data![i]
                                              ['description'],
                                          from_date: snapshot.data![i]
                                              ['from_date'],
                                          to_date: snapshot.data![i]['to_date'],
                                          type: snapshot.data![i]['type'],
                                        ),
                                      ),
                                    );
                                  } else if (subtype == 'Data') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyTitleSubmission(
                                          subject: snapshot.data![i]
                                              ['subjects'],
                                          id: snapshot.data![i]['id']
                                              .toString(),
                                          desc: snapshot.data![i]
                                              ['description'],
                                          from_date: snapshot.data![i]
                                              ['from_date'],
                                          to_date: snapshot.data![i]['to_date'],
                                          type: snapshot.data![i]['type'],
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => userMeeting(
                                          subject: snapshot.data![i]
                                              ['subjects'],
                                          id: snapshot.data![i]['id']
                                              .toString(),
                                          desc: snapshot.data![i]
                                              ['description'],
                                          userId: userId,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                            child: Card(
                              child: Stack(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: tileColor ?? Colors.grey,
                                      radius: 10,
                                    ),
                                    tileColor: Colors.grey.shade200,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                              text: snapshot.data![i]
                                                  ['subjects'],
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '   (${snapshot.data![i]['type']})',
                                                  style:
                                                      TextStyle(fontSize: 13.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        formatTimeAgo(DateTime.parse(
                                            snapshot.data![i]['updated_at'])),
                                        style: TextStyle(
                                            fontSize: 12.0, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
