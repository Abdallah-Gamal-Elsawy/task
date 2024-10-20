import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manger/shared/cubit/cubit.dart';
import 'package:task_manger/shared/cubit/states.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var priorityController = TextEditingController();
  var dateController = TextEditingController();

  HomeLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              backgroundColor: Colors.cyan,
              title: Text(cubit.title[cubit.currentindex]),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                    size: 30,
                  ),
                  onPressed: () {
                    cubit.changeAppMode();
                  },
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheet) {
                  if (formkey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        priority: priorityController.text,
                        date: dateController.text);
                  }
                } else {
                  scaffoldkey.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                          color: Colors.cyan[50],
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  onTap: () {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Title must not be empty';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: const Text('Task Title'),
                                      prefixIcon: const Icon(Icons.title),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: dateController,
                                  keyboardType: TextInputType.datetime,
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate:
                                                DateTime.parse('2030-12-30'))
                                        .then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    }).catchError((error) {});
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Date must not be empty';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: const Text('Deadline'),
                                      prefixIcon:
                                          const Icon(Icons.date_range_outlined),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: priorityController,
                                  keyboardType: TextInputType.text,
                                  onTap: () {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Priority must not be empty';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      label: const Text('Assign Priority'),
                                      prefixIcon:
                                          const Icon(Icons.priority_high),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        icon: Icons.edit, isShow: false);
                  });
                  cubit.changeBottomSheetState(icon: Icons.add, isShow: true);
                }
              },
              backgroundColor: Colors.cyan,
              elevation: 10,
              child: Icon(
                cubit.fabIcon,
                size: 30,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.cyan,
              currentIndex: AppCubit.get(context).currentindex,
              onTap: (index) {
                AppCubit.get(context).changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  label: 'All Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.task,
                    color: Colors.black,
                  ),
                  label: 'In Progress',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.done_outline_rounded,
                      color: Colors.black,
                    ),
                    label: 'Completed'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list_alt_rounded,

                      color: Colors.black,
                    ),
                    label: 'Overdue'),
              ],
            ),
            body: cubit.screens[cubit.currentindex],
          );
        },
      ),
    );
  }
}
