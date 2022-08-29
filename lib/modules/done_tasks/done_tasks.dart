import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/bloc/cubit.dart';
import '../../shared/bloc/states.dart';
import '../../shared/component/components.dart';

class TodoDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
            itemBuilder: (context, index) => DefaultTaskScreen(AppCubit.get(context).DoneTasks[index], context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            itemCount: AppCubit.get(context).DoneTasks.length),
      ),
      listener: (context, state)
      {

      },
    );
  }

}

