import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/modules/request_edit_summary/cubit/cubit.dart';
import 'package:videobite/modules/request_edit_summary/cubit/states.dart';
import 'package:videobite/shared/components/components.dart';

class RequestEditSummaryScreen extends StatelessWidget {
  final int id;
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RequestEditSummaryScreen({this.id});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RequestEditSummaryCubit()..getRequestEditSummaryData(id),
      child: BlocConsumer<RequestEditSummaryCubit, RequestEditSummaryStates>(
        listener: (context, state) {
          if (state is RequestEditSummarySubmitSuccessState) {
            showToast(
                text: "Submitted Successfully", state: ToastStates.SUCCESS);
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          var cubit = RequestEditSummaryCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: cubit.model != null,
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context) {
                if (cubit.model.message == "pending")
                  return imageAndTextPage(
                    image: 'assets/images/access_denied.png',
                    text: "You cann\'t make 2 requests at the same time",
                    c: context,
                  );
                if (cubit.model.message == "allowed")
                  controller.text = cubit.model.summary.summary;
                if (cubit.model.message == "allowed")
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: formKey,
                      child: ListView(
                        children: [
                          defaultFormField(
                            maxLines: null,
                            controller: controller,
                            type: TextInputType.multiline,
                            validate: (String val) {
                              if (val.isEmpty)
                                return "Please enter your summary";
                            },
                            label: "Summary",
                            prefix: Icons.description,
                          ),
                          if (state is! RequestEditSummarySubmitLoadingState)
                            defaultTextButton(
                              function: () {
                                if (formKey.currentState.validate())
                                  cubit.submitForm(
                                    videoId: this.id,
                                    summary: controller.text,
                                  );
                              },
                              text: "Submit",
                            ),
                          if (state is RequestEditSummarySubmitLoadingState)
                            Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  );

                return imageAndTextPage(
                  text: cubit.model.message,
                  c: context,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
