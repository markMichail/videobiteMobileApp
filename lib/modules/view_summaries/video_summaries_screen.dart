import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/modules/view_summaries/cubit/cubit.dart';
import 'package:videobite/modules/view_summaries/cubit/states.dart';
import 'package:videobite/shared/components/components.dart';

class ViewSummariesScreen extends StatelessWidget {
  final int id;
  const ViewSummariesScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewSummariesCubit()..getViewSummariesData(id),
      child: BlocConsumer<ViewSummariesCubit, ViewSummariesStates>(
        listener: (context, state) {
          if (state is ViewSummariesUpdateSuccessState)
            showToast(text: "Summary Updated", state: ToastStates.SUCCESS);
        },
        builder: (context, state) {
          var cubit = ViewSummariesCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: cubit.model != null,
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context) {
                return Column(
                  children: List.generate(
                    cubit.model.data.length,
                    (index) {
                      print(cubit.model.data[index].id);
                      print(cubit.model.activeSummaryId);
                      return Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text(cubit.model.data[index].summary),
                          trailing: IconButton(
                            onPressed: () {
                              cubit.updateSummary(cubit.model.data[index].id);
                            },
                            icon: Icon(
                              Icons.check_box,
                              color: cubit.model.data[index].id ==
                                      cubit.model.activeSummaryId
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
