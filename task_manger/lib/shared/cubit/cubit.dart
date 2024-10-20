import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger/modules/Inprogress.dart';
import 'package:task_manger/modules/all_task.dart';
import 'package:task_manger/modules/completed.dart';
import 'package:task_manger/modules/overdue.dart';
import 'package:task_manger/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<Widget> screens = [
     AllTask(),
     Inprogress(),
     Completed(),
     Overdue(),
  ];

  List<String> title = ['All Tasks', 'In Progress', 'Completed', 'Overdue'];

  void changeIndex(int index) {
    currentindex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> overduetasks = [];
  Database? database;
  void createDatabase() {
    openDatabase('task.db', version: 1, onCreate: (database, version) {
      // ignore: avoid_print
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, priority TEXT, date TEXT ,status TEXT )')
          .then((value) {
        // ignore: avoid_print
        print('Table Created');
      }).catchError((error) {
        // ignore: avoid_print
        print('Error when creating table ${error.toString()}');
      });
    }, onOpen: (database) {
      getdataFromDatabase(database);
      // ignore: avoid_print
      print('database opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    String? priority,
    required String date,
  }) async {
    await database?.transaction((txn) => txn
            .rawInsert(
                'INSERT INTO tasks(title, priority, date, status) VALUES("$title", "$priority", "$date","new")')
            .then((value) {
          // ignore: avoid_print
          print('$value Inserted successful');
          emit(AppInsertDatabaseState());
          getdataFromDatabase(database);
        }).catchError((error) {
          // ignore: avoid_print
          print('Error when inserting ${error.toString()}');
        }));
  }

  void getdataFromDatabase(database) {
    newtasks = [];
    donetasks = [];
    overduetasks = [];
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newtasks.add(element);
        } else if (element['status'] == 'done') {
          donetasks.add(element);
        } else if (element['status'] == 'overdue') {
          overduetasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  bool isBottomSheet = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheet = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      getdataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database!.rawDelete('DELETE FROM tasks  WHERE id = ?', [id]).then((value) {
      getdataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isDark = false;
  ThemeMode appMode = ThemeMode.dark;
  void changeAppMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }
}
