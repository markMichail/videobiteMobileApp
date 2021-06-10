abstract class VideoStates {}

class VideoInitialState extends VideoStates {}

class VideoLoadingState extends VideoStates {}

class VideoSuccessState extends VideoStates {}

class VideoErrorState extends VideoStates {
  final error;
  VideoErrorState(this.error);
}
