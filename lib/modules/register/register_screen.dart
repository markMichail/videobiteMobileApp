import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/layout/app_layout/app_layout.dart';
import 'package:videobite/shared/components/components.dart';
import 'package:videobite/shared/components/constants.dart';
import 'package:videobite/shared/network/local/cache_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                navigateToAndReplace(context, AppLayout());
              });
            } else {
              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          } else if (state is RegisterErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "REGISTER",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          "Register now to summarize your videos",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          validate: (String val) {
                            if (val.isEmpty) return "Please enter your name";
                          },
                          label: "Name",
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String val) {
                            if (val.isEmpty) return "Please enter your email";
                          },
                          label: "Email Address",
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String val) {
                            if (val.isEmpty) return "Password is too short";
                          },
                          label: "Password",
                          prefix: Icons.lock,
                          isPassword:
                              RegisterCubit.get(context).isPasswordHidden,
                          suffix: RegisterCubit.get(context).passwordSuffix,
                          suffixPressed: () {
                            if (state is! RegisterLoadingState)
                              RegisterCubit.get(context)
                                  .changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: confirmPasswordController,
                            type: TextInputType.visiblePassword,
                            validate: (String val) {
                              if (val.isEmpty) return "Password is too short";
                              if (val != passwordController.text)
                                return "Password dosen\'t match";
                            },
                            label: "Confirm Password",
                            prefix: Icons.lock,
                            isPassword: RegisterCubit.get(context)
                                .isConfirmPasswordHidden,
                            suffix: RegisterCubit.get(context)
                                .confirmPasswordSuffix,
                            suffixPressed: () {
                              if (state is! RegisterLoadingState)
                                RegisterCubit.get(context)
                                    .changeConfirmPasswordVisibility();
                            },
                            onSubmit: (val) {
                              if (formKey.currentState.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: "Register",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
