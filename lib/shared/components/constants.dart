import 'package:videobite/modules/login/login_screen.dart';
import 'package:videobite/shared/components/components.dart';
import 'package:videobite/shared/network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) navigateToAndReplace(context, LoginScreen());
  });
}

String token = '';
