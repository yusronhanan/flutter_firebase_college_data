import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String studentName, studentID, studyProgramID;
  double studentGPA;

  getStudentName(name) {
    this.studentName = name;
    return this.studentName;
  }

  getStudentID(id) {
    this.studentID = id;
    return this.studentID;
  }

  getStudyProgramID(programID) {
    this.studyProgramID = programID;
    return this.studyProgramID;
  }

  getStudentGPA(gpa) {
    this.studentGPA = double.parse(gpa);
    return this.studentGPA;
  }

  createData() {
    // created: insert document to firestore collection
    CollectionReference myStudents =
        FirebaseFirestore.instance.collection('MyStudents');

    myStudents
        .add({
          "studentName": studentName,
          "studentID": studentID,
          "studyProgramID": studyProgramID,
          "studentGPA": studentGPA
        })
        .then((value) => print("$value Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  readData() {
    // read: read document from firestore collection based on name
    CollectionReference myStudents =
        FirebaseFirestore.instance.collection('MyStudents');
    myStudents
        .where('studentName', isEqualTo: studentName)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                print(doc.reference.id); // get document id
                print(doc["studentName"]);
                print(doc["studentID"]);
                print(doc["studyProgramID"]);
                print(doc["studentGPA"]);
              })
            });
  }

  updateData() {
    // update: update document from firestore collection based on sid
    CollectionReference myStudents =
        FirebaseFirestore.instance.collection('MyStudents');
    myStudents
        .where('studentID', isEqualTo: studentID)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                print(doc);
                myStudents
                    .doc(doc.reference.id)
                    .update({
                      "studentName": studentName,
                      // "studentID": studentID,
                      "studyProgramID": studyProgramID,
                      "studentGPA": studentGPA
                    })
                    .then((value) => print("User Updated"))
                    .catchError(
                        (error) => print("Failed to update user: $error"));
              })
            });
  }

  deleteData() {
    // update: delete document from firestore collection based on name
    CollectionReference myStudents =
        FirebaseFirestore.instance.collection('MyStudents');
    myStudents
        .where('studentName', isEqualTo: studentName)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                print(doc);
                myStudents
                    .doc(doc.reference.id)
                    .delete()
                    .then((value) => print("User Deleted"))
                    .catchError(
                        (error) => print("Failed to delete user: $error"));
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My College Data"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Name",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String name) {
                    getStudentName(name);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Student ID",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String id) {
                    getStudentID(id);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Study Program",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String programID) {
                    getStudyProgramID(programID);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "GPA",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String gpa) {
                    getStudentGPA(gpa);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Create"),
                    textColor: Colors.white,
                    onPressed: () {
                      createData();
                    },
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Read"),
                    textColor: Colors.white,
                    onPressed: () {
                      readData();
                    },
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Update"),
                    textColor: Colors.white,
                    onPressed: () {
                      updateData();
                    },
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Delete"),
                    textColor: Colors.white,
                    onPressed: () {
                      deleteData();
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }
}
