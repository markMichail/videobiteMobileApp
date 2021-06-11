import 'package:videobite/modules/login/login_screen.dart';
import 'package:videobite/shared/components/components.dart';
import 'package:videobite/shared/network/end_points.dart';
import 'package:videobite/shared/network/local/cache_helper.dart';
import 'package:videobite/shared/network/remote/dio_helper.dart';

void signOut(context) {
  DioHelper.postData(
    url: LOGOUT,
    token: token,
  ).then((value) {
    token = '';
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) navigateToAndReplace(context, LoginScreen());
    });
  }).catchError((error) {
    print(error.toString());
  });
}

String token = '';
const String URL = "http://192.168.1.9:8001";
