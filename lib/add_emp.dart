// ignore_for_file: prefer_const_constructors

import "package:employee_app/db.dart";
import "package:flutter/material.dart";

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddEmployee();
  }
}

class _AddEmployee extends State<AddEmployee> {
  TextEditingController name = TextEditingController();
  TextEditingController employee = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController experience = TextEditingController();

  EmpData mydb = EmpData();

  @override
  void initState() {
    mydb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Employee"),
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
                  hintText: "Employee_ID",
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
                        "INSERT INTO Employees (name, employee_id, address, experience) VALUES (?, ?, ? , ?);",
                        [
                          name.text,
                          employee.text,
                          address.text,
                          experience,
                        ]);

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("New Employee Added")));
                    print("data is added");

                    name.text = "";
                    employee.text = "";
                    address.text = "";
                    experience.text = "";
                  },
                  child: Text("Save Employee Data")),
            ],
          ),
        ));
  }
}
