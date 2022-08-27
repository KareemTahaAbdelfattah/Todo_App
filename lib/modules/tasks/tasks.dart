import 'package:flutter/material.dart';

import '../../shared/component/components.dart';
import '../../shared/component/constants.dart';

class TodoTasks extends StatefulWidget {
  const TodoTasks({Key? key}) : super(key: key);

  @override
  State<TodoTasks> createState() => _TodoTasksState();
}

class _TodoTasksState extends State<TodoTasks> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(
          itemBuilder: (context, index) => DefaultTaskScreen(tasks[index]),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: tasks.length),
    );
  }
}