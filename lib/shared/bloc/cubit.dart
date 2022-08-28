import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/shared/bloc/states.dart';

import '../../modules/archived_tasks/archived_tasks.dart';
import '../../modules/done_tasks/done_tasks.dart';
import '../../modules/tasks/tasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

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

  void ChangeBottomNavBar(value) {
    CurrentIndex = value;
    emit(AppBottomNavBarStates());
  }

  List<Map> tasks = [];

  Database? database;

  void CreateDatabase() {
    openDatabase(
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
          emit(AppGetDataBase());
        },);
        print("database opened");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBase());
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
          emit(AppInsertDataBase());
          GetDataFromDataBase(database).then((value) {
            tasks = value;
            print(value);
            emit(AppGetDataBase());
          },);
        },).catchError((error) {
          print("error at inserted ${error.toString()}");
        },),);
  }

  Future<List<Map>> GetDataFromDataBase(database) async
  {
    return await database?.rawQuery('SELECT * FROM tasks');
  }

  IconData fabIcon = Icons.add;
  bool isBottomSheet = false;

  void ChangeFabIcon({
    @required IconData? fab,
    @required bool? isShown,
  }) {
    fabIcon = fab!;
    isBottomSheet = isShown!;
    emit(FabIconChange());
  }
}