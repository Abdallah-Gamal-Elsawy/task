import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:task_manger/shared/cubit/cubit.dart';

Widget buildTaskItem(Map model, context) => Dismissible(
      background: Container(
        color: Colors.red
        ,child: const Center(
          child: Text(
            'Delete'
            ,style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20
              ),),
        ),),
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 90, 226, 212),
              radius: 30,
              child: Text('${model['id']}',style: Theme.of(context).textTheme.bodyLarge,),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${model['title']}',
                    style: Theme.of(context).textTheme.bodyMedium
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${model['date']}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            Text(
              '${model['priority']}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'done', id: model['id']);
                },
                icon: const Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'overdue', id: model['id']);
                },
                icon: const Icon(
                  Icons.local_hotel_sharp,
                  color: Colors.red,
                )),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      
      },
    );

Widget taskBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
          separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1,
                color: Colors.cyan,
              ),
          itemCount: tasks.length),
      fallback: (context) => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              color: Colors.grey,
              size: 100,
            ),
            Text(
              'NO Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            )
          ],
        ),
      ),
    );


