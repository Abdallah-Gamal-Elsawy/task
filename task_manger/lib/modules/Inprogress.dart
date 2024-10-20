
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger/shared/components.dart';
import 'package:task_manger/shared/cubit/cubit.dart';
import 'package:task_manger/shared/cubit/states.dart';

class Inprogress extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, State) {},
      builder: (context, State) {
        var tasks = AppCubit.get(context).newtasks;
        return taskBuilder(tasks: tasks);
      },
    );
  }
}
