abstract class ViewSummariesStates {}

class ViewSummariesInitialState extends ViewSummariesStates {}

class ViewSummariesLoadingState extends ViewSummariesStates {}

class ViewSummariesSuccessState extends ViewSummariesStates {}

class ViewSummariesErrorState extends ViewSummariesStates {
  final error;
  ViewSummariesErrorState(this.error);
}

class ViewSummariesUpdateLoadingState extends ViewSummariesStates {}

class ViewSummariesUpdateSuccessState extends ViewSummariesStates {}

class ViewSummariesUpdateErrorState extends ViewSummariesStates {
  final error;
  ViewSummariesUpdateErrorState(this.error);
}
