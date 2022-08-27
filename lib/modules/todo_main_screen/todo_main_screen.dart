import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Widget build(BuildContext context) {
    //AppCubit cubit = AppCubit.get(context);
    return Scaffold(
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

        },
        child: Icon(
          Icons.add,
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
}