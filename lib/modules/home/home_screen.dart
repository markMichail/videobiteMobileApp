import 'package:better_player/better_player.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/layout/cubit/cubit.dart';
import 'package:videobite/layout/cubit/states.dart';
import 'package:videobite/models/home_model.dart';
import 'package:videobite/modules/video/video_screen.dart';
import 'package:videobite/shared/components/components.dart';
import 'package:videobite/shared/components/constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null,
          builder: (context) => cubit.homeModel.data.videos.length == 0
              ? imageAndTextPage(text: "Upload video now!", c: context)
              : videosBuilder(cubit.homeModel, cubit, context),
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
          elevation: 4,
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
                        URL + model.link,
                        betterPlayerConfiguration: BetterPlayerConfiguration(
                          aspectRatio: 16 / 9,
                          autoDispose: false,
                          autoPlay: false,
                          placeholderOnTop: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 3.0),
                      child: Text(
                        model.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                        ),
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
