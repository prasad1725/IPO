import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../login.dart';
import '../../methods/api.dart';
import 'AdminCreateNotifi.dart';

import 'AdminDrawer.dart';

class AdminNotifications extends StatefulWidget {
  const AdminNotifications({super.key});

  @override
  State<AdminNotifications> createState() => _AdminNotificationsState();
}

class Notify {
  Future<List> getAllNotification(String department, String dropvalue) async {
    try {
      var response = await API()
          .getRequest(route: '/mentornotification/$department/$dropvalue');
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

class _AdminNotificationsState extends State<AdminNotifications> {
  String dropdownValue = 'MCA';
  String dropvalue = 'Sem-I';
  DateTime dateTime = DateTime.now();

  Map<String, List<String>> dropdownOptions = {};
  Notify notificationService = Notify();
  late int userId = 0;
  Future<Map<String, dynamic>> getUserDataFromSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;
    return {'userId': userId};
  }

  String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    return timeago.format(now.subtract(difference));
  }

  @override
  void initState() {
    super.initState();
    getUserDataFromSession().then((value) {
      setState(() {
        userId = value['userId'];
        dropdownOptions = {
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
          ]
        };

        // Set dropdownValue based on department
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

      // bottomNavigationBar: CurvedNavigationBarWidget(
      //   currentPage: 'Mentornotifications',
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
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
                  Expanded(child: Container()),
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
                  Expanded(child: Container()),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminCreateNotifi()));
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: const Text(
                        'Create Notification',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder<List>(
                    future: notificationService.getAllNotification(
                        dropdownValue, dropvalue),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, i) {
                            // Parse the to_date from String to DateTime
                            DateTime toDate =
                                DateTime.parse(snapshot.data![i]['to_date']);
                            // Compare toDate with current date
                            bool isExpired = toDate.isBefore(DateTime.now());
                            // Set the color based on expiration status
                            Color circleColor = isExpired
                                ? Colors.redAccent
                                : Colors.greenAccent;

                            return InkWell(
                              onTap: () {},
                              child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: circleColor,
                                    radius: 10,
                                  ),
                                  tileColor: Colors.grey.shade200,
                                  title: RichText(
                                    text: TextSpan(
                                        text: snapshot.data![i]['subjects'],
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text:
                                                '   (${snapshot.data![i]['type']})',
                                            style: TextStyle(fontSize: 13.0),
                                          ),
                                        ]),
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            // Navigate to a different page based on the card tapped
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         MentorEditNotifications(
                                            //       // Pass any necessary data to the destination page
                                            //       subject: snapshot.data![i]
                                            //           ['subjects'],
                                            //       id: snapshot.data![i]['id']
                                            //           .toString(),
                                            //       desc: snapshot.data![i]
                                            //           ['description'],
                                            //       rem: snapshot.data![i]
                                            //               ['reminder']
                                            //           .toString(),
                                            //       from_date: snapshot.data![i]
                                            //           ['from_date'],
                                            //       to_date: snapshot.data![i]
                                            //           ['to_date'],
                                            //       subtype: snapshot.data![i]
                                            //           ['subtype'],
                                            //       department: snapshot.data![i]
                                            //           ['department'],
                                            //       semester: snapshot.data![i]
                                            //           ['semester'],
                                            //       type: snapshot.data![i]
                                            //           ['type'],
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            size: 20,
                                          )),
                                      Text(
                                        formatTimeAgo(DateTime.parse(
                                            snapshot.data![i]['updated_at'])),
                                        style: TextStyle(
                                            fontSize: 12.0, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('No data found'),
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
