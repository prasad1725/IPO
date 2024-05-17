import 'package:flutter/material.dart';
import '../../login.dart';
import 'AdminAddOE.dart';
import 'AdminDrawer.dart';

class AdminOpenElective extends StatefulWidget {
  const AdminOpenElective({super.key});

  @override
  State<AdminOpenElective> createState() => _AdminOpenElectiveState();
}

class _AdminOpenElectiveState extends State<AdminOpenElective> {
  String dropdownValue = 'MCA';
  String dropvalue = 'Sem-I';
  String drop = 'OE-1';

  final List listOfColumns = [
    {
      "ID": "1",
      "Title": "AAAAAA",
      "PRN": "20220804029",
      "Email": "20220804029@dypiu.ac.in",
      "Track": "AI-DS",
      "Company": "Yes",
    },
    {
      "ID": "1",
      "Title": "AAAAAA",
      "PRN": "20220804029",
      "Email": "20220804029@dypiu.ac.in",
      "Track": "AI-DS",
      "Company": "Yes",
    },
    {
      "ID": "1",
      "Title": "AAAAAA",
      "PRN": "20220804029",
      "Email": "20220804029@dypiu.ac.in",
      "Track": "AI-DS",
      "Company": "Yes",
    },
    {
      "ID": "1",
      "Title": "AAAAAA",
      "PRN": "20220804029",
      "Email": "20220804029@dypiu.ac.in",
      "Track": "AI-DS",
      "Company": "Yes",
    },
    {
      "ID": "1",
      "Title": "AAAAAA",
      "PRN": "20220804029",
      "Email": "20220804029@dypiu.ac.in",
      "Track": "AI-DS",
      "Company": "Yes",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Open Electives',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, left: 30, right: 30),
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
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'MCA',
                          child: Text('MCA',
                              style: TextStyle(color: Colors.black)),
                        ),
                        DropdownMenuItem(
                          value: 'BCA',
                          child: Text('BCA',
                              style: TextStyle(color: Colors.black)),
                        ),
                        DropdownMenuItem(
                          value: 'Btech',
                          child: Text('Btech',
                              style: TextStyle(color: Colors.black)),
                        )
                      ],
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
                      items: [
                        DropdownMenuItem(
                          value: 'Sem-I',
                          child: Text(
                            'Sem-I',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Sem-II',
                          child: Text('Sem-II',
                              style: TextStyle(color: Colors.black)),
                        ),
                        DropdownMenuItem(
                          value: 'Sem=III',
                          child: Text('Sem-III',
                              style: TextStyle(color: Colors.black)),
                        )
                      ],
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
                      value: drop,
                      onChanged: (String? newValue) {
                        setState(() {
                          drop = newValue!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'OE-1',
                          child: Text(
                            'OE-1',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'OE-2',
                          child: Text('OE-2',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6,
              decoration: BoxDecoration(
                  color: Color(0xff303c6c),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              hintText: 'Subject-1',
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(25)),
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 14),
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
                            enabled: false,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              hintText: 'Subject-2',
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(25)),
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 14),
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
                            enabled: false,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              hintText: 'Subject-3',
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(25)),
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 14),
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
                            enabled: false,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              hintText: 'Subject-4',
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(25)),
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 14),
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
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Open Electives',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  // width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      DataTable(
                        columns: [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Title')),
                          DataColumn(label: Text('PRN')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Track')),
                          DataColumn(label: Text('Company')),
                        ],
                        rows: listOfColumns
                            .map((element) => DataRow(
                                  cells: [
                                    DataCell(Text(element[
                                        "ID"])), //Extracting from Map element the value
                                    DataCell(Text(element["Title"])),
                                    DataCell(Text(element["PRN"])),
                                    DataCell(Text(element["Email"])),
                                    DataCell(Text(element["Track"])),
                                    DataCell(Text(element["Company"])),
                                  ],
                                ))
                            .toList(),
                      ),
                    ],
                  ),
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
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: const Text(
                  'Add Subjects',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
