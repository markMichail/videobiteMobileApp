import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/models/login_model.dart';
import 'package:videobite/modules/login/cubit/states.dart';
import 'package:videobite/shared/network/end_points.dart';
import 'package:videobite/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  }) {
    print(email);
    print(password);
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      if (value.data['errors'] != null) {
        emit(LoginErrorState(
            value.data['errors'].values.toList()[0][0].toString()));
      } else {
        loginModel = LoginModel.fromJson(value.data);
        emit(LoginSuccessState(loginModel));
      }
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData passwordSuffix = Icons.visibility_outlined;
  bool isPasswordHidden = true;

  void changePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    passwordSuffix = isPasswordHidden
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }
}
