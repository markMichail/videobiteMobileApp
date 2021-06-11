import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/layout/cubit/cubit.dart';
import 'package:videobite/layout/cubit/states.dart';
import 'package:videobite/shared/components/components.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.historyModel != null,
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => cubit.historyModel.data.length == 0
              ? emptyPage(text: "Upload video now!", c: context)
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      for (int i = 0; i < cubit.historyModel.data.length; i++)
                        Card(
                          child: ListTile(
                            title: Text(cubit.historyModel.data[i].title),
                            trailing: IconButton(
                              onPressed: () {
                                cubit.deleteVideo(cubit.historyModel.data[i]);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
//            child: SingleChildScrollView(
//              physics: BouncingScrollPhysics(),
//              child: Table(
//                defaultVerticalAlignment: TableCellVerticalAlignment.top,
//                columnWidths: {
//                  0: FractionColumnWidth(.1),
//                  1: FractionColumnWidth(.7),
//                  2: FractionColumnWidth(.2)
//                },
//                border: TableBorder.all(width: 1),
//                children: [
//                  TableRow(
//                    children: [
//                      Center(child: Text("#")),
//                      Center(child: Text("Video Name")),
//                      //                    Text(cubit.historyModel.data[index].createdAt),
//                      Center(child: Text("Action")),
//                    ],
//                  ),
//                  for (int i = 0; i < cubit.historyModel.data.length; i++)
//                    TableRow(
//                      children: [
//                        Padding(
//                          padding:
//                              const EdgeInsetsDirectional.only(start: 12.0),
//                          child: Text(i.toString()),
//                        ),
//                        Padding(
//                          padding: const EdgeInsetsDirectional.only(start: 8.0),
//                          child: Text(cubit.historyModel.data[i].title),
//                        ),
////                    Text(cubit.historyModel.data[index].createdAt),
//                        IconButton(
//                          onPressed: () {
//                            cubit.deleteVideo(cubit.historyModel.data[i].id);
//                          },
//                          icon: Icon(
//                            Icons.delete,
//                            color: Colors.red,
//                          ),
//                        ),
//                      ],
//                    ),
//                ],
//              ),
//            ),
                ),
        );
      },
    );
  }
}
