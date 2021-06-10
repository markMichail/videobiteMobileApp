abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class AppLoadingHomeDataState extends AppStates {}

class AppSuccessHomeDataState extends AppStates {}

class AppErrorHomeDataState extends AppStates {
  final error;
  AppErrorHomeDataState(this.error);
}

class AppChooseVideoState extends AppStates {}

class AppLoadingUploadVideoState extends AppStates {}

class AppSuccessUploadVideoState extends AppStates {
  final message;

  AppSuccessUploadVideoState(this.message);
}

class AppErrorUploadVideoState extends AppStates {}

class AppLoadingGetHistoryState extends AppStates {}

class AppSuccessGetHistoryState extends AppStates {}

class AppErrorGetHistoryState extends AppStates {}

class AppLoadingDeleteHistoryState extends AppStates {}

class AppSuccessDeleteHistoryState extends AppStates {}

class AppErrorDeleteHistoryState extends AppStates {}
