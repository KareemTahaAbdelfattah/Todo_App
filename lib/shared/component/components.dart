import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/shared/bloc/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  @required String? text,
  @required function,
}) => Container(
  color: color,
  width: width,
  child: MaterialButton(
    onPressed: function,
    child: Center(
      child: Text(
        text!.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    ),
  ),
);

Widget DefaultTaskScreen(Map models, context) => Row(
  children: [
    CircleAvatar(
      radius: 30.0,
      backgroundColor: Colors.blueAccent[500],
      child: Center(
        child: Text(
          '${models['time']}',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    SizedBox(
      width: 15.0,
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${(models['title']).toString().toUpperCase()}',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Text(
            '${models['date']}',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    ),
    SizedBox(
      width: 15.0,
    ),
    IconButton(
        onPressed: ()
        {
          AppCubit.get(context).UpdateDataBase(status: 'Done', id: models['id']);
        },
        icon: Icon(
          Icons.check_circle,
          color: Colors.green[200],
        ),
    ),
    IconButton(
      onPressed: ()
      {
        AppCubit.get(context).UpdateDataBase(status: 'Archived', id: models['id']);
      },
      icon: Icon(
        Icons.archive_rounded,
        color: Colors.redAccent[200],
      ),
    ),
  ],
);

