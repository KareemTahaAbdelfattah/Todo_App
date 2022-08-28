import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../../shared/component/constants.dart';
import '../archived_tasks/archived_tasks.dart';
import '../done_tasks/done_tasks.dart';
import '../tasks/tasks.dart';

class TodoScreen extends StatefulWidget {


  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  int CurrentIndex = 0;

  List<Widget> Screens =
  [
    TodoTasks(),
    TodoDone(),
    TodoArchived(),
  ];

  List<String> titles =
  [
    'Current Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  IconData fabIcon = Icons.add;

  var titleController = TextEditingController();

  var timeController = TextEditingController();

  var dateController = TextEditingController();

  var statusController = TextEditingController();

  bool isBottomSheet = false;

  var ScaffoldKey = GlobalKey<ScaffoldState>();

  var FormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    CreateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    //AppCubit cubit = AppCubit.get(context);
    return Scaffold(
      key: ScaffoldKey,
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
          titles[CurrentIndex],
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        actions: [
          IconButton(onPressed: () {
            print('Notifications');
          }, icon: Icon(Icons.notification_important),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          if(isBottomSheet)
          {
            if(FormKey.currentState!.validate()) {
              if(titleController.text != "" && timeController.text != "" && dateController.text != "")
              {
                InsertDatabase(
                    title: titleController.text,
                    time: timeController.text,
                    date: dateController.text);
              }
              Navigator.pop(context);
              isBottomSheet = false;
              setState(() {
                fabIcon = Icons.add;
              });
            }
          }
          else
          {
            ScaffoldKey.currentState?.showBottomSheet((context) =>
                Container(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: FormKey,
                        child: Column
                          (
                          mainAxisSize: MainAxisSize.min,
                          children:
                          [
                            TextFormField(
                              controller: titleController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Title must not be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Task Title',
                                prefixIcon: Icon(
                                  Icons.title,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            TextFormField(
                              controller: timeController,
                              keyboardType: TextInputType.datetime,
                              onTap: () {
                                showTimePicker(context: context,
                                  initialTime: TimeOfDay.now(),).then((
                                    value) {
                                  timeController.text =
                                      value!.format(context).toString();
                                },);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Time must not be empty';
                                }
                                //return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Task Time',
                                prefixIcon: Icon(
                                  Icons.watch_later_outlined,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            TextFormField(
                              controller: dateController,
                              keyboardType: TextInputType.datetime,
                              onTap: () {
                                showDatePicker(context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2024-12-30'),
                                ).then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                  print("Make data successfully");
                                },).catchError((error) {
                                  print("error at ${error.toString()}");
                                },);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Data must not be empty';
                                }
                                //return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Task Date',
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),).closed.then((value) {
                  /*if(titleController.text != "" && timeController.text != "" && dateController.text != "")
                  {
                    InsertDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                  }*/
              //Navigator.pop(context);
              isBottomSheet = false;
              setState(() {
                fabIcon = Icons.add;
              });
            });
            isBottomSheet = true;
            setState(() {
              fabIcon = Icons.remove;
            });
          }
        },
        child: Icon(
          fabIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index)
        {
          setState(() {
            CurrentIndex = index;
          });
        },
        //key: ,
        currentIndex: CurrentIndex,
        items:
        [
          BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_outlined),
              label: 'Done'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined),
              label: 'Archived'),
        ],
      ),
      body: Screens[CurrentIndex],
    );
  }

  Database? database;
  void CreateDatabase() async
  {
    await openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, version) {
        print("database created");
        database.execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)')
            .then((value) {
          print("table creating");
        },).catchError((error) {
          print("error in table creating ${error.toString()}");
        },);
      },
      onOpen: (database) {
        GetDataFromDataBase(database).then((value) {
          tasks = value;
          print(value);
          //emit(AppGetDataBase());
        },);
        print("database opened");
      },
    ).then((value)
    {
      database = value;
      //emit(AppCreateDataBase());
    });
  }

  Future InsertDatabase({
    @required String? title,
    @required String? time,
    @required String? date,
  }) async
  {
    return await database?.transaction((txn) =>
        txn.rawInsert(
            'INSERT INTO tasks(title, time, date, status) VALUES("$title", "$time", "$date", "new")')
            .then((value) {
          print("$value successfully inserted");
        },).catchError((error) {
          print("error at inserted ${error.toString()}");
        },),);
  }

  Future<List<Map>> GetDataFromDataBase(database) async
  {
    return await database?.rawQuery('SELECT * FROM tasks');
  }


}