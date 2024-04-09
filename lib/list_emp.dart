// ignore_for_file: prefer_const_constructors

import 'package:employee_app/db.dart';
import 'package:employee_app/edit_emp.dart';
import 'package:flutter/material.dart';

class ListEmployee extends StatefulWidget {
  const ListEmployee({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListEmployee();
  }
}

class _ListEmployee extends State<ListEmployee> {
  List<Map> emplist = [];
  EmpData mydb = EmpData();

  @override
  void initState() {
    mydb.open();
    getdata();
    super.initState();
  }

  getdata() {
    Future.delayed(Duration(seconds: 0), () async {
      emplist = await mydb.db.rawQuery('SELECT * FROM employees');

      setState(() {
        emplist;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Employees"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: emplist.length == 0
              ? Text("No any Employee to show.")
              : Column(
                  children: emplist.map((employe) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.people),
                        title: Text(employe["name"]),
                        subtitle: Text("Employee_Id:" +
                            employe["Employee_Id"].toString() +
                            ", Add: " +
                            employe["address"]),
                        trailing: Wrap(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return EditEmployee(
                                        employeeid: employe["Employee_Id"]);
                                  })); //navigate to edit page, pass student roll no to edit
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  await mydb.db.rawDelete(
                                      "DELETE FROM employees WHERE employee_id = ?",
                                      [employe["Employee_Id"]]);

                                  print("Data Deleted");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Employee Data Deleted")));
                                  getdata();
                                },
                                icon: Icon(Icons.delete, color: Colors.red))
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
