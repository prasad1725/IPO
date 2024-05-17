import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dypiu_ipo/Admin/mobile/AdminGrading.dart';
import 'package:dypiu_ipo/Admin/mobile/AdminManageMentors.dart';
import 'package:dypiu_ipo/Admin/mobile/AdminManageStud.dart';
import 'package:dypiu_ipo/Admin/mobile/AdminOpenElective.dart';
import 'package:dypiu_ipo/Admin/mobile/AdminProjectIntern.dart';
import 'package:dypiu_ipo/login.dart';
import 'package:flutter/material.dart';

import 'AdminNotifications.dart';

var context;

AppBar AdminAppbar() {
  return AppBar(
    title: Text(
      'Dashboard',
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
  );
}

Drawer AdminDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.white,
    child: Column(
      children: [
        DrawerHeader(
          child: Row(
            children: [
              CircleAvatar(
                radius: 55,
                child: Image(
                  image: AssetImage('assets/logo.png'),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ABC XYZ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('MCA Department'),
                  ],
                ),
              )
            ],
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
              child: ListTile(
                tileColor: Colors.orange.shade300,
                title: Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.home),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminManageMentor()));
                },
                tileColor: Colors.grey.shade200,
                title: Text(
                  'Manage Mentors',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.notifications),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminNotifications()));
                },
                tileColor: Colors.grey.shade200,
                title: Text(
                  'Notifications',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.notifications),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminManageStud()));
                },
                tileColor: Colors.grey.shade200,
                title: Text(
                  'Manage Students',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.groups),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminProjectIntern()));
                },
                tileColor: Colors.grey.shade200,
                title: Text(
                  'Project/Internship',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.computer),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminOpenElective()));
                },
                tileColor: Colors.grey.shade200,
                title: Text(
                  'Open Electives',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.assignment),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminGrading()));
                },
                tileColor: Colors.grey.shade200,
                title: Text(
                  'Grading',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.bar_chart),
              ),
            ),
          ],
        ),
        Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 16),
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyLogin()));
            },
            tileColor: Colors.grey.shade200,
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
            trailing: Icon(Icons.logout),
          ),
        ),
      ],
    ),
  );
}

// var mentorDrawer = Drawer(
//   backgroundColor: Colors.white,
//   child: Column(
//     children: [
//       DrawerHeader(
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 55,
//               child: Image(
//                 image: AssetImage('assets/logo.png'),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'ABC XYZ',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   Text('MCA Department'),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//       Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
//             child: ListTile(
//               tileColor: Colors.orange.shade300,
//               title: Text(
//                 'Dashboard',
//                 style: TextStyle(fontSize: 18),
//               ),
//               trailing: Icon(Icons.home),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
//             child: ListTile(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => AdminNotifications()));
//               },
//               tileColor: Colors.grey.shade200,
//               title: Text(
//                 'Notifications',
//                 style: TextStyle(fontSize: 18),
//               ),
//               trailing: Icon(Icons.notifications),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
//             child: ListTile(
//               tileColor: Colors.grey.shade200,
//               title: Text(
//                 'Manage Students',
//                 style: TextStyle(fontSize: 18),
//               ),
//               trailing: Icon(Icons.groups),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
//             child: ListTile(
//               tileColor: Colors.grey.shade200,
//               title: Text(
//                 'Project/Internship',
//                 style: TextStyle(fontSize: 18),
//               ),
//               trailing: Icon(Icons.computer),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
//             child: ListTile(
//               tileColor: Colors.grey.shade200,
//               title: Text(
//                 'Open Electives',
//                 style: TextStyle(fontSize: 18),
//               ),
//               trailing: Icon(Icons.assignment),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
//             child: ListTile(
//               tileColor: Colors.grey.shade200,
//               title: Text(
//                 'Grading',
//                 style: TextStyle(fontSize: 18),
//               ),
//               trailing: Icon(Icons.bar_chart),
//             ),
//           ),
//         ],
//       ),
//       Expanded(child: SizedBox()),
//       Padding(
//         padding: const EdgeInsets.only(left: 10, right: 10, bottom: 16),
//         child: ListTile(
//           onTap: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => MyLogin()));
//           },
//           tileColor: Colors.grey.shade200,
//           title: Text(
//             'Logout',
//             style: TextStyle(fontSize: 18),
//           ),
//           trailing: Icon(Icons.logout),
//         ),
//       ),
//     ],
//   ),
// );

var adminNavbar = CurvedNavigationBar(
    backgroundColor: Colors.transparent,
    buttonBackgroundColor: Colors.orange.shade300,
    height: 60,
    color: Colors.grey,
    items: const <Widget>[
      Icon(
        Icons.home,
        size: 20,
      ),
      Icon(
        Icons.notifications,
        size: 20,
      ),
      Icon(
        Icons.computer,
        size: 20,
      ),
      Icon(
        Icons.groups,
        size: 20,
      ),
      Icon(
        Icons.bar_chart,
        size: 20,
      ),
    ]);
