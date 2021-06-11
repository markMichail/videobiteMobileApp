import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/modules/view_edit_requests/cubit/cubit.dart';
import 'package:videobite/modules/view_edit_requests/cubit/states.dart';
import 'package:videobite/shared/components/components.dart';

class ViewEditRequestsScreen extends StatelessWidget {
  final id;
  const ViewEditRequestsScreen({this.id});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewEditRequestsCubit()..getViewEditRequestsData(id),
      child: BlocConsumer<ViewEditRequestsCubit, ViewEditRequestsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ViewEditRequestsCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: cubit.model != null,
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context) {
                if (cubit.model.requests.length == 0)
                  return emptyPage(
                      text: "You didn\'t make any edit request for this video",
                      c: context);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: List.generate(
                      cubit.model.requests.length,
                      (index) => Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            subtitle: Text(cubit.model.requests[index].summary),
                            title: Text(
                              cubit.model.requests[index].status.toUpperCase(),
                            ),
                          ),
                        ),
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
  }
}
