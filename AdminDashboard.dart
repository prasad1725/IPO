import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

import 'AdminDrawer.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String dropdownValue = 'MCA';
  String dropvalue = 'Sem-I';

  final data = [
    {
      'title': 'Uploaded',
      'student': 50,
    },
    {
      'title': 'Notuploaded',
      'student': 20,
    },
    {
      'title': 'Defaulters',
      'student': 30,
    },
  ];

  final List listOfColumns = [
    {"Name": "AAAAAA", "Number": "1", "State": "Yes"},
    {"Name": "BBBBBB", "Number": "2", "State": "no"},
    {"Name": "CCCCCC", "Number": "3", "State": "Yes"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppbar(),
      drawer: AdminDrawer(context),
      bottomNavigationBar: adminNavbar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                decoration: BoxDecoration(
                    color: Color(0xff303c6c),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 5,
                        // color: Colors.brown,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 55,
                            ),
                            Text(
                              'Welcome\n to DYPIU',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 120,
                            ),
                            Row(
                              children: [
                                DropdownButton<String>(
                                  icon: Icon(
                                    Icons.expand_more,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  dropdownColor: Color(0xff303c6c),
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
                                      child: Text('MCA'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'BCA',
                                      child: Text('BCA'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Btech',
                                      child: Text('Btech'),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 12,
                                ),
                                DropdownButton<String>(
                                  icon: Icon(
                                    Icons.expand_more,
                                    color: Colors.white,
                                  ),
                                  dropdownColor: Color(0xff5d77df),
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
                                      child: Text('Sem-I'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Sem-II',
                                      child: Text('Sem-II'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Sem=III',
                                      child: Text('Sem-III'),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Image(
                          image: AssetImage('assets/welcome.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              AspectRatio(
                aspectRatio: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: GridView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade400),
                        child: Center(
                            child: Text(
                          'All Students',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade400),
                        child: Center(
                            child: Text(
                          'Uploaded Students',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade400),
                        child: Center(
                            child: Text(
                          'Defaulters',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade400),
                        child: Center(
                            child: Text(
                          'Completed',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              //Pie Chart
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      'Student Response',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Stack(
                        children: [
                          DChartPie(
                            data: data.map((e) {
                              return {
                                'domain': e['title'].toString(),
                                'measure': e['student']
                              };
                            }).toList(),
                            fillColor: (pieData, index) {
                              switch (pieData['domain']) {
                                case 'Uploaded':
                                  return Colors.green;
                                case 'Notuploaded':
                                  return Colors.yellow;
                                case 'Defaulters':
                                  return Colors.red;
                              }
                            },
                            donutWidth: 30,
                            labelColor: Colors.black,
                            labelPosition: PieLabelPosition.outside,
                            labelLineColor: Colors.grey,
                            labelLinelength: 14,
                            labelPadding: 5,
                            pieLabel:
                                (Map<dynamic, dynamic> pieData, int? index) {
                              return pieData['domain'] +
                                  ':\n' +
                                  pieData['measure'].toString() +
                                  ' students';
                            },
                          ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: '100',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w400),
                                children: [
                                  TextSpan(
                                    text: '\n Students',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //Pie chart end
              SizedBox(
                height: 15,
              ),
              // Table start
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      'Submissions',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    DataTable(
                      columns: [
                        DataColumn(label: Text('Title')),
                        DataColumn(label: Text('Total Students')),
                        DataColumn(label: Text('Submitted')),
                      ],
                      rows: listOfColumns
                          .map((element) => DataRow(
                                cells: [
                                  DataCell(Text(element[
                                      "Name"])), //Extracting from Map element the value
                                  DataCell(Text(element["Number"])),
                                  DataCell(Text(element["State"])),
                                ],
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
