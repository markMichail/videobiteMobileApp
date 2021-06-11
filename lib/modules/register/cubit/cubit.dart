import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/models/login_model.dart';
import 'package:videobite/modules/register/cubit/states.dart';
import 'package:videobite/shared/network/end_points.dart';
import 'package:videobite/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
  }) {
    print(email);
    print(password);
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      if (value.data['errors'] != null) {
        emit(RegisterErrorState(
            value.data['errors'].values.toList()[0][0].toString()));
      } else {
        loginModel = LoginModel.fromJson(value.data);
        emit(RegisterSuccessState(loginModel));
      }
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData passwordSuffix = Icons.visibility_outlined;
  bool isPasswordHidden = true;

  void changePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    passwordSuffix = isPasswordHidden
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  IconData confirmPasswordSuffix = Icons.visibility_outlined;
  bool isConfirmPasswordHidden = true;

  void changeConfirmPasswordVisibility() {
    isConfirmPasswordHidden = !isConfirmPasswordHidden;
    confirmPasswordSuffix = isConfirmPasswordHidden
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}
