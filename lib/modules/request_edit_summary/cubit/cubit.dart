import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/models/request_edit_summary_model.dart';
import 'package:videobite/modules/request_edit_summary/cubit/states.dart';
import 'package:videobite/shared/components/constants.dart';
import 'package:videobite/shared/network/end_points.dart';
import 'package:videobite/shared/network/remote/dio_helper.dart';

class RequestEditSummaryCubit extends Cubit<RequestEditSummaryStates> {
  RequestEditSummaryCubit() : super(RequestEditSummaryInitialState());

  static RequestEditSummaryCubit get(context) => BlocProvider.of(context);

  RequestEditSummaryModel model;
  void getRequestEditSummaryData(int id) {
    print(token);
    emit(RequestEditSummaryLoadingState());
    DioHelper.getData(
      url: REQUEST_EDIT_SUMMARY + id.toString(),
      token: token,
    ).then(
      (value) {
        print(value.data);
        model = RequestEditSummaryModel.fromJson(value.data);
        emit(RequestEditSummarySuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(RequestEditSummaryErrorState(error));
      },
    );
  }

  void submitForm({videoId, summary}) {
    emit(RequestEditSummarySubmitLoadingState());
    DioHelper.postData(url: SUBMIT_REQUEST_EDIT_SUMMARY, token: token, data: {
      'summaryID': model.summary.id,
      'summary': summary,
      'video': videoId,
    }).then(
      (value) {
        print(value.data);
        emit(RequestEditSummarySubmitSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(RequestEditSummarySubmitErrorState(error));
      },
    );
  }
}
