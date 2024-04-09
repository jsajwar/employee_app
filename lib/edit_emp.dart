// ignore_for_file: prefer_const_constructors

import 'package:employee_app/db.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditEmployee extends StatefulWidget {
  int employeeid;
  EditEmployee({required this.employeeid}); //constructor for class

  @override
  State<StatefulWidget> createState() {
    return _EditEmployee();
  }
}

class _EditEmployee extends State<EditEmployee> {
  TextEditingController name = TextEditingController();
  TextEditingController employee = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController experience = TextEditingController();

  EmpData mydb = EmpData();

  @override
  void initState() {
    mydb.open();

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await mydb.getEmployee(widget.employeeid);
      if (data != null) {
        name.text = data["name"];
        employee.text = data["employee_id"].toString();
        address.text = data["address"];
        setState(() {
          data;
        });
      } else {
        print("No any data with roll no:$widget.employeeid.toString()");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Employee"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Employee Name",
                ),
              ),
              TextField(
                controller: employee,
                decoration: InputDecoration(
                  hintText: "Employee_id",
                ),
              ),
              TextField(
                controller: address,
                decoration: InputDecoration(
                  hintText: "Address:",
                ),
              ),
              TextField(
                controller: experience,
                decoration: InputDecoration(
                  hintText: "Experience",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "UPDATE students SET name = ?, employee_id = ?, address = ? , experience = ? WHERE roll_no = ?",
                        [
                          name.text,
                          employee.text,
                          address.text,
                          widget.employeeid
                        ]);
                    //update table with roll no.
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Employee Data Updated")));
                  },
                  child: Text("Update Employee Data")),
            ],
          ),
        ));
  }
}
