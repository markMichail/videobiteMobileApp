import 'package:better_player/better_player.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/layout/cubit/cubit.dart';
import 'package:videobite/layout/cubit/states.dart';
import 'package:videobite/models/home_model.dart';
import 'package:videobite/modules/video/video_screen.dart';
import 'package:videobite/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null,
          builder: (context) => videosBuilder(cubit.homeModel, cubit, context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget videosBuilder(HomeModel model, AppCubit cubit, context) => ListView(
        physics: BouncingScrollPhysics(),
        children: List.generate(
          model.data.videos.length,
          (index) => buildGridProduct(model.data.videos[index], context),
        ),
      );

  Widget buildGridProduct(HomeVideoDataModel model, context) {
    print(model.link);
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          navigateTo(
            context,
            VideoScreen(
              id: model.id,
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      model.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}