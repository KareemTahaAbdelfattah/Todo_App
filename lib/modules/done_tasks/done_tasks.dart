import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../shared/bloc/cubit.dart';
import '../../shared/bloc/states.dart';
import '../../shared/component/components.dart';

class TodoDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) => Conditional.single(
        fallbackBuilder: (context) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              "There is no Done Tasks Now",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        conditionBuilder:(context) => AppCubit.get(context).DoneTasks.length > 0,
        widgetBuilder: (context) => Padding(
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
        context: context,
      ),
      listener: (context, state)
      {

      },
    );
  }

}

