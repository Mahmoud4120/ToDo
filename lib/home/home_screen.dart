import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/archived_tasks.dart';
import 'package:todo_application/done-tasks.dart';

import '../new_tasks.dart';

class HomeScreen extends StatefulWidget {
  static const String routename = 'Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> Screens = [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];
  List<String> title = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  late Database database;
  @override
  void initState() {
    super.initState();
    createDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title[currentIndex]),
      ),
      body: Screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          insertToDataBase();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline), label: 'Done'),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archived'),
        ],
      ),
    );
  }
  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('Database Created');
        database
            .execute(
                ' CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)')
            .then((value) {
          print(' Table Created');
        }).catchError((error) {
          print('error ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('Database Opened');
      },
    );
  }

  void insertToDataBase() {
    database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title , date , time , status) VALUES ("first task" ,"0100", "01212" ,"new" ,"")')
          .then((value) {
        print('$value inserted successfully');
      }).catchError((error) {
        print('error when inserting record ${error.toString()}');
      });
      return Future(() => null);
    });
  }
}
