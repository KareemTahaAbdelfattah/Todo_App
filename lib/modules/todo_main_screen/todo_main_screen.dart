import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../archived_tasks/archived_tasks.dart';
import '../done_tasks/done_tasks.dart';
import '../tasks/tasks.dart';

class TodoScreen extends StatelessWidget {


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
          'Tasks',
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
      body: Screens[CurrentIndex],
    );
  }
}