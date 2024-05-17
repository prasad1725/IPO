import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({super.key});

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  var fnameController = new TextEditingController();
  var lnameController = new TextEditingController();
  var addressController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text('Insert Data'),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: fnameController,
                decoration: InputDecoration(labelText: 'First Name '),
              ),
              TextField(
                controller: lnameController,
                decoration: InputDecoration(labelText: 'Last Name '),
              ),
              TextField(
                controller: addressController,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(labelText: 'Address '),
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      _fakeData();
                    },
                    child: Text('Generate Date'),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Insert Data'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _clearAll() {
    fnameController.text = "";
    lnameController.text = "";
    addressController.text = "";
  }

  void _fakeData() {
    setState(() {
      fnameController.text = faker.person.firstName();
      lnameController.text = faker.person.lastName();
      addressController.text =
          faker.address.streetAddress() + "\n" + faker.address.streetAddress();
    });
  }
}
