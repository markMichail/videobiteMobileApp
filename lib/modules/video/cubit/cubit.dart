import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/models/video_model.dart';
import 'package:videobite/modules/video/cubit/states.dart';
import 'package:videobite/shared/components/constants.dart';
import 'package:videobite/shared/network/end_points.dart';
import 'package:videobite/shared/network/remote/dio_helper.dart';

class VideoCubit extends Cubit<VideoStates> {
  VideoCubit() : super(VideoInitialState());

  static VideoCubit get(context) => BlocProvider.of(context);

  VideoModel model;
  void getVideoData(int id) {
    print(token);
//    return;
    emit(VideoLoadingState());
    DioHelper.getData(
//      url: GET_VIDEO + "63",
      url: GET_VIDEO + id.toString(),
      token: token,
    ).then(
      (value) {
        print(value.data);
        model = VideoModel.fromJson(value.data);
        print(model.data.timestamps[0].description);
        print(model.data.keywords[0].keyword);
        emit(VideoSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(VideoErrorState(error));
      },
    );
  }
}
