import 'package:flutter/material.dart';

import '../../Mentor/mobile/MentorAddOE.dart';
import '../../login.dart';

import 'AdminDrawer.dart';

class AdminAddOE extends StatefulWidget {
  const AdminAddOE({super.key});

  @override
  State<AdminAddOE> createState() => _AdminAddOEState();
}

class _AdminAddOEState extends State<AdminAddOE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Open Electives',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('Open Electives-1',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                hintText: 'Subject-1',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                hintText: 'Subject-2',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                hintText: 'Subject-3',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                hintText: 'Subject-4',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('Open Electives-2',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                hintText: 'Subject-1',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                hintText: 'Subject-2',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                hintText: 'Subject-3',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                hintText: 'Subject-4',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      //builder: (context) => MyNotifications(),
                      builder: (context) => AdminAddOE(),
                    ),
                  );
                },
                child: Container(
                  height: 38,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: const Text(
                    'Update',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
