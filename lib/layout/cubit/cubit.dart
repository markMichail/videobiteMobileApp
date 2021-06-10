import 'package:better_player/better_player.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/layout/cubit/states.dart';
import 'package:videobite/models/history_model.dart';
import 'package:videobite/models/home_model.dart';
import 'package:videobite/modules/history/history_screen.dart';
import 'package:videobite/modules/home/home_screen.dart';
import 'package:videobite/modules/upload_video/upload_video_screen.dart';
import 'package:videobite/shared/components/constants.dart';
import 'package:videobite/shared/network/end_points.dart';
import 'package:videobite/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.upload_file),
      label: "Upload",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.history),
      label: "History",
    ),
  ];

  List<Widget> bottomScreens = [
    HomeScreen(),
    UploadVideoScreen(),
    HistoryScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  HomeModel homeModel;

  void getHomeData() {
    emit(AppLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      print(value.statusCode);
      print(value.data);
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel.status);
      emit(AppSuccessHomeDataState());
    }).catchError((error) {
      emit(AppErrorHomeDataState(error));
    });
  }

  BetterPlayerController betterPlayerController;
  TextEditingController videoTitle = new TextEditingController();
  var pickedFile;

  void chooseVideo() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.video);
    print(result);
    if (result != null) {
      pickedFile = result.files.first;
      betterPlayerController?.pause();

      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        pickedFile.path,
      );

      betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoDispose: true,
        ),
        betterPlayerDataSource: betterPlayerDataSource,
      );

      betterPlayerController.addEventsListener((BetterPlayerEvent event) {
        if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
          betterPlayerController.setOverriddenAspectRatio(
              betterPlayerController.videoPlayerController.value.aspectRatio);
        }
      });

      emit(AppChooseVideoState());
    }
  }

  void uploadVideo() async {
    print(pickedFile.path);
    emit(AppLoadingUploadVideoState());
    var data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        pickedFile.path,
        filename: pickedFile.name,
      ),
      'title': videoTitle.text,
    });
    DioHelper.postData(
      url: UPLOAD_VIDEO,
      token: token,
      data: data,
    ).then((value) {
      print(value.data);
      emit(AppSuccessUploadVideoState(value.data['message']));
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorUploadVideoState());
    });
    videoTitle.text = "";
  }

  HistoryModel historyModel;
  void getHistory() {
    DioHelper.getData(
      url: GET_HISTORY,
      token: token,
    ).then((value) {
      print(value.data);
      historyModel = HistoryModel.fromJson(value.data);
      emit(AppSuccessGetHistoryState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorGetHistoryState());
    });
  }

  void deleteVideo(HistoryData model) {
//    historyModel.data.remove(model);
//    emit(AppSuccessDeleteHistoryState());
    DioHelper.deleteData(
      url: DELETE_VIDEO + model.id.toString(),
      token: token,
    ).then(
      (value) {
        historyModel.data.remove(model);
        emit(AppSuccessDeleteHistoryState());
      },
    ).catchError(
      (error) {
        emit(AppErrorDeleteHistoryState());
      },
    );
  }
}
