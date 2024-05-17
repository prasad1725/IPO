import 'package:flutter/material.dart';
import 'AdminDrawer.dart';

class AdminProjectIntern extends StatefulWidget {
  const AdminProjectIntern({super.key});

  @override
  State<AdminProjectIntern> createState() => _AdminProjectInternState();
}

class _AdminProjectInternState extends State<AdminProjectIntern> {
  String dropdownValue = 'MCA';
  String dropvalue = 'Sem-I';
  String drop = 'Project';

  final List listOfColumns = [
    {
      "ID": "1",
      "Title": "AAAAAA",
      "PRN": "20220804029",
      "Email": "20220804029@dypiu.ac.in",
      "Track": "AI-DS",
      "Sponsored": "Yes",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project/Internship',
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
      bottomNavigationBar: adminNavbar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                          value: 'Project',
                          child: Text(
                            'Project',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Internship',
                          child: Text('Internship',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Text(
              'Projects/Internship',
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
                          DataColumn(label: Text('Sponsored')),
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
                                    DataCell(Text(element["Sponsored"])),
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
        ],
      ),
    );
  }
}
