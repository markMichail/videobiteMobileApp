import 'package:better_player/better_player.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/models/video_model.dart';
import 'package:videobite/modules/video/cubit/cubit.dart';
import 'package:videobite/modules/video/cubit/states.dart';
import 'package:videobite/modules/view_edit_requests/view_edit_requests_screen.dart';
import 'package:videobite/shared/components/components.dart';
import 'package:videobite/shared/components/constants.dart';

class VideoScreen extends StatelessWidget {
  final int id;
  VideoScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoCubit()..getVideoData(id),
      child: BlocConsumer<VideoCubit, VideoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = VideoCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.model != null,
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(cubit.model.data.title),
              ),
              body: videoItem(cubit.model.data, context),
            ),
            fallback: (context) => Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget videoItem(VideoData model, context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer.network(
            URL + model.link,
            betterPlayerConfiguration: BetterPlayerConfiguration(
              aspectRatio: 16 / 9,
              autoDispose: false,
              autoPlay: false,
              placeholderOnTop: true,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
//                  Expanded(child: Container(color: defaultColor,))
                  Expanded(
                    child: defaultTextButton(
                        function: () {}, text: "Request Edit Summary"),
                  ),
                  Container(
                    width: 1,
                    height: 50,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: defaultTextButton(
                        function: () {
                          navigateTo(
                            context,
                            ViewEditRequestsScreen(
                              id: model.id,
                            ),
                          );
                        },
                        text: "View Edit Requests"),
                  ),
                  Container(
                    width: 1,
                    height: 50,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: defaultTextButton(
                        function: () {}, text: "Video Summaries"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Text(
                      "Summary",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SelectableText(model.summary.summary),
                  ],
                ),
              ),
              if (model.keywords.length > 0) Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Column(
                  children: [
                    if (model.keywords.length > 0)
                      Text(
                        "Keywords",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    Wrap(
                      children: List.generate(
                        model.keywords.length,
                        (index) => Card(
                            child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SelectableText(model.keywords[index].keyword),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              if (model.timestamps.length > 0) Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (model.timestamps.length > 0)
                      Text(
                        'Timestamps',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    Column(
                      children: List.generate(
                        model.timestamps.length,
                        (index) => Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Wrap(
                                  children: [
                                    Text(
                                      "From: " +
                                          model.timestamps[index].startTime,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "To: " + model.timestamps[index].endTime,
                                    ),
                                  ],
                                ),
                                SelectableText(
                                    model.timestamps[index].description),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
