// هنا نستخدم الويجت المكرر الي راح نستدعيها في كا مكان

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:section9_social_chat/shared/styles/icon_broken.dart';

Widget defaultAppBar ({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: Icon(IconBroken.Arrow___Left_3),
  ),
  title: Text(title!),
  actions: actions,
);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.green,
  required String text,
  required Function function,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: background,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required String? Function(String?)? validator,
  required String label,
  bool ispassword = false,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPassed,
}) =>
    TextFormField(
      cursorColor: Colors.green,
      controller: controller,
      keyboardType: type,
      obscureText: ispassword,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      validator: validator,
      onChanged: (s) {
        print('$s');

      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        focusColor: Colors.green,
        suffixIcon: suffix != null
            ? IconButton(
            onPressed: () {
              suffixPassed!();
            },
            icon: Icon(suffix))
            : null,
        border: OutlineInputBorder(),
      ),
    );



Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


void showToast({
  required String text,
  required ToastState state,
})=>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: changeColorState(state),
        textColor: Colors.white,
        fontSize: 16.0
    );

enum ToastState{SUCCES,ERROR,WARNING}

Color? changeColorState(ToastState state){
  Color color;
  switch(state){
    case ToastState.SUCCES:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
}

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);