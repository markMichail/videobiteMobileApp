abstract class RequestEditSummaryStates {}

class RequestEditSummaryInitialState extends RequestEditSummaryStates {}

class RequestEditSummaryLoadingState extends RequestEditSummaryStates {}

class RequestEditSummarySuccessState extends RequestEditSummaryStates {}

class RequestEditSummaryErrorState extends RequestEditSummaryStates {
  final error;
  RequestEditSummaryErrorState(this.error);
}

class RequestEditSummarySubmitLoadingState extends RequestEditSummaryStates {}

class RequestEditSummarySubmitSuccessState extends RequestEditSummaryStates {}

class RequestEditSummarySubmitErrorState extends RequestEditSummaryStates {
  final error;
  RequestEditSummarySubmitErrorState(this.error);
}
