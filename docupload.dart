import 'dart:convert';
import 'dart:io';

import 'package:dypiu_ipo/User/editsubmission.dart';
import 'package:dypiu_ipo/User/notifications.dart';
import 'package:dypiu_ipo/User/profile.dart';
import 'package:dypiu_ipo/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocUpload extends StatefulWidget {
  final String subject;
  final String id;
  final String desc;
  final String from_date;
  final String to_date;
  final String type;

  const DocUpload({
    Key? key,
    required this.subject,
    required this.id,
    required this.desc,
    required this.from_date,
    required this.to_date,
    required this.type,
  }) : super(key: key);

  @override
  State<DocUpload> createState() => _DocUploadState();
}

class ApiService {
  static Future uploadFile(String filePath, int userId, String id, String type) async {
    try {
      var uri = Uri.parse('http://10.0.2.2:8000/api/submission');
      var request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      request.fields['userId'] = userId.toString();
      request.fields['id'] = id;
      request.fields['type'] = type;
      var response = await request.send();

      if (response.statusCode == 200) {
        return jsonDecode(await response.stream.bytesToString());
      } else {
        throw Exception('Failed to upload file: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }
}

class _DocUploadState extends State<DocUpload> {
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedfile;
  bool isLoading = false;
  File? fileToDisplay;
  late int userId = 0; // Declare userId here
  int userStatus = 0; // Initialize user status

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: false);

      if (result != null) {
        _fileName = result!.files.first.name;
        pickedfile = result!.files.first;
        fileToDisplay = File(pickedfile!.path.toString());
      }

      setState(() {
        isLoading = false;
      });
      //uploadFileToServer();
    } catch (e) {
      print(e);
    }
  }

  void deleteFile() {
    setState(() {
      _fileName = null;
      pickedfile = null;
      fileToDisplay = null;
    });
  }

  void uploadFileToServer(String id) async {
    if (pickedfile == null) {
      return;
    }

    try {
      var response = await ApiService.uploadFile(pickedfile!.path!, userId, id, widget.type);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
        ),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyNotifications()));
    } catch (e) {
      print(e);
    }
  }

  TextEditingController subjects = TextEditingController();
  TextEditingController description = TextEditingController();

  void initState() {
    super.initState();
    subjects = TextEditingController(text: widget.subject);
    description = TextEditingController(text: widget.desc);
    getUserIdAndStatusFromSession().then((value) {
      setState(() {
        userId = value['userId'];
        userStatus = value['status'];
      });
    });
  }

  Future<Map<String, dynamic>> getUserIdAndStatusFromSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;
    // Convert string URL to Uri object
    Uri apiUrl = Uri.parse('http://10.0.2.2:8000/api/student/$userId');
    // Call API to fetch user status
    var response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      int status = data['status'];
      return {'userId': userId, 'status': status};
    } else {
      throw Exception('Failed to load user status');
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
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: Container(
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
                      // Text('Opened: Monday, 4 December 2023,12:00 AM',
                      //     style: TextStyle(fontWeight: FontWeight.bold)),
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
            ),
            // SizedBox(
            //   height: 50,
            // ),
            if (userStatus == 1)
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, right: 20, left: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          //diplay the file
                          fileToDisplay != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Selected File',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(),
                                    ListTile(
                                      leading: Icon(Icons.description),
                                      title: Text(_fileName ?? 'File'),
                                      subtitle: Text(
                                          '${fileToDisplay!.lengthSync()} bytes'),
                                      trailing: IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          deleteFile();
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : InkWell(
                                  onTap: () {
                                    pickFile();
                                  },
                                  child: Center(
                                      child: isLoading
                                          ? CircularProgressIndicator()
                                          : Image(
                                              image: AssetImage(
                                                  'assets/upload.png'))),
                                ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      uploadFileToServer(widget.id);
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
                        'Upload',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              )
            else
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
    );
  }
}
