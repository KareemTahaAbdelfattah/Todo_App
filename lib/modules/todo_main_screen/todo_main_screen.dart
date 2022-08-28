import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/shared/bloc/cubit.dart';
import 'package:untitled/shared/bloc/states.dart';
import '../../shared/component/constants.dart';
import '../archived_tasks/archived_tasks.dart';
import '../done_tasks/done_tasks.dart';
import '../tasks/tasks.dart';

class TodoScreen extends StatelessWidget
{

  bool Flag = false;

  var titleController = TextEditingController();

  var timeController = TextEditingController();

  var dateController = TextEditingController();

  var statusController = TextEditingController();

  var ScaffoldKey = GlobalKey<ScaffoldState>();

  var FormKey = GlobalKey<FormState>();

  /*@override
  void initState() {
    super.initState();
    CreateDatabase();
  }*/

  @override
  Widget build(BuildContext context) {
    //AppCubit cubit = AppCubit.get(context);
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..CreateDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (BuildContext context, state) => Scaffold(
          key: ScaffoldKey,
          appBar: AppBar(
            leading: Icon(
              Icons.menu,
            ),
            title: Text(
              AppCubit.get(context).titles[AppCubit.get(context).CurrentIndex],
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
              if(AppCubit.get(context).isBottomSheet)
              {
                if(FormKey.currentState!.validate()) {
                  Flag = false;
                  if(titleController.text != "" && timeController.text != "" && dateController.text != "")
                  {
                    AppCubit.get(context).InsertDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                        Flag = true;
                  }
                  Navigator.pop(context);
                  AppCubit.get(context).ChangeFabIcon(fab : Icons.add, isShown: false);
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
                  if(titleController.text != "" && timeController.text != "" && dateController.text != "" && Flag == false)
                    {
                      AppCubit.get(context).InsertDatabase(
                          title: titleController.text,
                          time: timeController.text,
                          date: dateController.text);
                    }
                  //Navigator.pop(context);
                  AppCubit.get(context).ChangeFabIcon(fab : Icons.add, isShown: false);
                });
                AppCubit.get(context).ChangeFabIcon(fab : Icons.remove, isShown: true);
              }
            },
            child: Icon(
              AppCubit.get(context).fabIcon,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index)
            {
              AppCubit.get(context).ChangeBottomNavBar(index);
            },
            currentIndex: AppCubit.get(context).CurrentIndex,
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
          body: AppCubit.get(context).Screens[AppCubit.get(context).CurrentIndex],
        ),
        listener: (BuildContext context, Object? state)
        {

        },
      ),
    );
  }

}
