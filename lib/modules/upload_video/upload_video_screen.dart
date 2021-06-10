import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/layout/cubit/cubit.dart';
import 'package:videobite/layout/cubit/states.dart';
import 'package:videobite/shared/components/components.dart';

class UploadVideoScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSuccessUploadVideoState) {
          showToast(text: state.message, state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              if (state is AppChooseVideoState ||
                  state is AppLoadingUploadVideoState)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                    controller: cubit.videoTitle,
                    type: TextInputType.text,
                    validate: (val) {
                      if (val.isEmpty) return "Required";
                    },
                    label: "Video Title",
                    prefix: Icons.title,
                  ),
                ),
              if (state is! AppChooseVideoState &&
                  state is! AppLoadingUploadVideoState)
                Expanded(
                  child: Image(
                    image: AssetImage('assets/images/upload_video_image.png'),
                  ),
                ),
              Visibility(
                visible: state is! AppSuccessUploadVideoState &&
                    state is! AppErrorUploadVideoState &&
                    cubit.betterPlayerController != null,
                child: Expanded(
                  child: BetterPlayer(
                    controller: cubit.betterPlayerController,
                  ),
                ),
              ),
              state is! AppLoadingUploadVideoState
                  ? Row(
                      children: [
                        Expanded(
                          child: defaultTextButton(
                            text: "Choose Video",
                            function: () {
                              cubit.chooseVideo();
                            },
                          ),
                        ),
                        Visibility(
                          visible: state is AppChooseVideoState &&
                              cubit.betterPlayerController != null,
                          child: Expanded(
                            child: defaultTextButton(
                              text: "Upload",
                              function: () {
                                if (formKey.currentState.validate())
                                  cubit.uploadVideo();
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 50,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
