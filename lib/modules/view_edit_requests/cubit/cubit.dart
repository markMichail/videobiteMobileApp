import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/models/view_edit_requests_model.dart';
import 'package:videobite/modules/view_edit_requests/cubit/states.dart';
import 'package:videobite/shared/components/constants.dart';
import 'package:videobite/shared/network/end_points.dart';
import 'package:videobite/shared/network/remote/dio_helper.dart';

class ViewEditRequestsCubit extends Cubit<ViewEditRequestsStates> {
  ViewEditRequestsCubit() : super(ViewEditRequestsInitialState());

  static ViewEditRequestsCubit get(context) => BlocProvider.of(context);

  ViewEditRequestsModel model;
  void getViewEditRequestsData(int id) {
    print(token);
//    return;
    emit(ViewEditRequestsLoadingState());
    DioHelper.getData(
      url: VIEW_EDIT_REQUEST + id.toString(),
      token: token,
    ).then(
      (value) {
        print(value.data);
        model = ViewEditRequestsModel.fromJson(value.data);
        print(model.status);
        emit(ViewEditRequestsSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(ViewEditRequestsErrorState(error));
      },
    );
  }
}
