import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/models/view_summaries_model.dart';
import 'package:videobite/modules/view_summaries/cubit/states.dart';
import 'package:videobite/shared/components/constants.dart';
import 'package:videobite/shared/network/end_points.dart';
import 'package:videobite/shared/network/remote/dio_helper.dart';

class ViewSummariesCubit extends Cubit<ViewSummariesStates> {
  ViewSummariesCubit() : super(ViewSummariesInitialState());

  static ViewSummariesCubit get(context) => BlocProvider.of(context);

  ViewSummariesModel model;
  void getViewSummariesData(int id) {
    print(token);
    emit(ViewSummariesLoadingState());
    DioHelper.getData(
      url: VIEW_SUMMARIES + id.toString(),
      token: token,
    ).then(
      (value) {
        print(value.data);
        model = ViewSummariesModel.fromJson(value.data);
        emit(ViewSummariesSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(ViewSummariesErrorState(error));
      },
    );
  }

  void updateSummary(id) {
    print(token);
    emit(ViewSummariesUpdateLoadingState());
    DioHelper.getData(
      url: UPDATE_SUMMARY + id.toString(),
      token: token,
    ).then(
      (value) {
        print(value.data);
        model.activeSummaryId = id;
        emit(ViewSummariesUpdateSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(ViewSummariesUpdateErrorState(error));
      },
    );
  }
}
