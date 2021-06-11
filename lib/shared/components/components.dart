import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:videobite/shared/styles/colors.dart';

Widget emptyPage({String text, BuildContext c}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('assets/images/empty.png'),
        ),
      ),
      if (text != null)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(c).textTheme.bodyText1,
          ),
        ),
      SizedBox(
        height: 50,
      ),
    ],
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Center(
        child: Text(
          text.toUpperCase(),
        ),
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateToAndReplace(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

void showToast({@required String text, @required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: _chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

Color _chooseToastColor(ToastStates state) {
  Color _color;
  switch (state) {
    case ToastStates.SUCCESS:
      _color = Colors.green;
      break;
    case ToastStates.ERROR:
      _color = Colors.red;
      break;
    case ToastStates.WARNING:
      _color = Colors.yellow;
      break;
  }

  return _color;
}

//Widget buildListProductItem(model, cubit) => Padding(
//      padding: const EdgeInsets.all(20.0),
//      child: Container(
//        height: 120.0,
//        child: Row(
//          children: [
//            Stack(
//              alignment: AlignmentDirectional.bottomStart,
//              children: [
//                Image(
//                  image: NetworkImage(model.image),
//                  height: 120.0,
//                  width: 120.0,
//                ),
//                if (cubit is! SearchCubit && model.discount != 0)
//                  Container(
//                    color: Colors.red,
//                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                    child: Text(
//                      'DISCOUNT',
//                      style: TextStyle(fontSize: 8.0, color: Colors.white),
//                    ),
//                  ),
//              ],
//            ),
//            SizedBox(
//              width: 20.0,
//            ),
//            Expanded(
//              child: Column(
//                children: [
//                  Text(
//                    model.name,
//                    maxLines: 4,
//                    overflow: TextOverflow.ellipsis,
//                    style: TextStyle(
//                      fontSize: 14.0,
//                      height: 1.3,
//                    ),
//                  ),
//                  Spacer(),
//                  Row(
//                    children: [
//                      Text(
//                        '${model.price.round()}',
//                        style: TextStyle(
//                          color: defaultColor,
//                          fontSize: 12.0,
//                        ),
//                      ),
//                      SizedBox(
//                        width: 5.0,
//                      ),
//                      if (cubit is! SearchCubit && model.discount != 0)
//                        Text(
//                          '${model.oldPrice.round()}',
//                          style: TextStyle(
//                              color: Colors.grey,
//                              fontSize: 10.0,
//                              decoration: TextDecoration.lineThrough),
//                        ),
//                      Spacer(),
//                      if (cubit is AppCubit)
//                        IconButton(
//                          onPressed: () {
//                            print(model.id);
//                            cubit.changeFavourites(model.id);
//                          },
//                          icon: CircleAvatar(
//                            radius: 15.0,
//                            backgroundColor: defaultColor,
//                            child: Icon(
//                              Icons.favorite_border,
//                              size: 14.0,
//                              color: Colors.white,
//                            ),
//                          ),
//                        ),
//                    ],
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
