import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? suffixPressed,
  Function()? onTap,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefixIcon,
  required BuildContext context,
  bool isPassword = false,
  IconData? suffixIcon,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      style: Theme.of(context).textTheme.displayLarge,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.titleSmall,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon))
            : null,
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.orangeAccent,
  bool isUpperCase = true,
  double radius = 5.0,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 15.0,
    );

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }

  return color;
}
