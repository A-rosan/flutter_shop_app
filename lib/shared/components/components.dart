import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/colors.dart';

Widget defualtButton({
  double width = double.infinity,
  double? height,
  Color color = Colors.blue,
  Color fontColor = Colors.white,
  double fontSize = 20,
  bool isUpperCase = true,
  required String text,
  required VoidCallback onPressed,
  double raduis = 0.0,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(raduis),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: GoogleFonts.abel(
            color: fontColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          )
        ),
      ),
    );

//TextFormField
Widget defualtTxtForm({
  //carefull
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required String? Function(String?)? validator,
  void Function(String)? onSubmitted,
  void Function()? onTap,
  void Function(String)? onChanged,

  //icons
  required IconData prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixFunction,
  bool isClicAble = true,
  bool isRead = false,
  bool isPassword = false,
  Color iconColor = Colors.grey,
  Color textFormColor = Colors.white,

  //style
  double radius = 0,
  double labelFontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      enabled: isClicAble,
      validator: validator,
      obscureText: isPassword,
      readOnly: isRead,
      decoration: InputDecoration(
          fillColor: textFormColor,
          label: Text(
            label,
            style: GoogleFonts.abel(
              color: defualtColor2,
              fontSize: labelFontSize,
              fontWeight: fontWeight,
            )
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
          prefixIcon: Icon(
            prefixIcon,
            color: iconColor,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixFunction,
                  icon: Icon(
                    suffixIcon,
                    color: iconColor,
                  ),
                )
              : null),
    );

//divider
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

//navigator.push
void moveTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
void moveToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);
void showToast({
  required String msg,
  required ChoseState toastState,
})=> Fluttertoast.showToast(
                  msg: msg,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: chooseColor(toastState),
                  textColor: Colors.white,
                  fontSize: 16.0
                  );
enum ChoseState { SUCCESS, ERROR, WARNING }

//Color Toast method
Color chooseColor(ChoseState state) {
  Color color;
  switch (state) {
    case ChoseState.SUCCESS:
      color = Colors.green;
      break;
    case ChoseState.ERROR:
      color = Colors.red;
      break;
    case ChoseState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}                 