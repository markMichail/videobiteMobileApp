import 'package:better_player/better_player.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/models/video_model.dart';
import 'package:videobite/modules/video/cubit/cubit.dart';
import 'package:videobite/modules/video/cubit/states.dart';
import 'package:videobite/shared/components/components.dart';

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
    print("http://192.168.1.9:8000" + model.link);
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer.network(
            "http://192.168.1.9:8000" + model.link,
//                      "http://192.168.1.9:8000/storage/userVideos/1/60c0b6d4bbf32.mp4",
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
                        function: () {}, text: "View Edit Requests"),
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
                  horizontal: 30,
                ),
                child: Column(
                  children: [
                    Text(
                      "Summary",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(model.summary.summary),
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
                    Column(
                      children: List.generate(
                        model.keywords.length,
                        (index) => Text(model.keywords[index].keyword),
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
                        (index) => Column(
                          children: [
                            Row(
                              children: [
                                Text(model.timestamps[index].startTime),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(model.timestamps[index].endTime),
                              ],
                            ),
                            Text(model.timestamps[index].description),
                          ],
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
