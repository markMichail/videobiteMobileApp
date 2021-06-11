abstract class ViewEditRequestsStates {}

class ViewEditRequestsInitialState extends ViewEditRequestsStates {}

class ViewEditRequestsLoadingState extends ViewEditRequestsStates {}

class ViewEditRequestsSuccessState extends ViewEditRequestsStates {}

class ViewEditRequestsErrorState extends ViewEditRequestsStates {
  final error;
  ViewEditRequestsErrorState(this.error);
}
