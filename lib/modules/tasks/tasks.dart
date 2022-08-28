import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/shared/bloc/cubit.dart';
import 'package:untitled/shared/bloc/states.dart';

import '../../shared/component/components.dart';
import '../../shared/component/constants.dart';

class TodoTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
            itemBuilder: (context, index) => DefaultTaskScreen(AppCubit.get(context).tasks[index]),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            itemCount: AppCubit.get(context).tasks.length),
      ),
      listener: (context, state)
      {

      },
    );
  }
}