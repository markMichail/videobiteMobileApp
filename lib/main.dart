import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videobite/shared/bloc_observer.dart';
import 'package:videobite/shared/components/constants.dart';
import 'package:videobite/shared/network/local/cache_helper.dart';
import 'package:videobite/shared/network/remote/dio_helper.dart';
import 'package:videobite/shared/styles/themes.dart';

import 'layout/app_layout/app_layout.dart';
import 'layout/cubit/cubit.dart';
import 'modules/login/login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token') ?? null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
  final bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? null;
  Widget getHome() {
//    return WebViewExample();
    if (onBoarding == null)
      return OnBoardingScreen();
    else if (token == null)
      return LoginScreen();
    else
      return AppLayout();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getHomeData()
        ..getHistory(),
      child: MaterialApp(
        title: 'Video Bite',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: getHome(),
      ),
    );
  }
}
