import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reticle_trainer_app/colors.dart';

Widget commonText(
  String text, {
  double size = 12.0,
  Color color = Colors.black,
  bool isBold = false,
  bool islogoText = false,
  bool softwarp = true,
  maxLine,
  bool haveUnderline = false,
  fontWeight,
  TextAlign textAlign = TextAlign.left,
}) {
  return Text(
    text,
    softWrap: softwarp,
    textAlign: textAlign,
    maxLines: maxLine,
    style:
        (islogoText)
            ? GoogleFonts.almendra(
              fontSize: size,

              color: color,

              fontWeight:
                  isBold
                      ? FontWeight.bold
                      : (fontWeight != null)
                      ? fontWeight
                      : FontWeight.normal,
            )
            : GoogleFonts.poppins(
              fontSize: size,
              color: color,
              fontWeight:
                  isBold
                      ? FontWeight.bold
                      : (fontWeight != null)
                      ? fontWeight
                      : FontWeight.normal,
            ),
  );
}

Widget commonButton(
  String title, {
  Color color = AppColors.black,
  Color textColor = Colors.white,
  double textSize = 18,
  double width = double.infinity,
  double height = 50,
  double borderRadious = 50,
  VoidCallback? onTap,
  TextAlign textalign = TextAlign.left,
  bool isLoading = false,
  bool haveNextIcon = false,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadious)),
        color: color,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:
              isLoading
                  ? const CircularProgressIndicator()
                  : FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        commonText(
                          textAlign: textalign,
                          title,
                          size: textSize,
                          color: textColor,
                          isBold: true,
                        ),
                        if (haveNextIcon)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Image.asset("assets/arrow.png"),
                          ),
                      ],
                    ),
                  ),
        ),
      ),
    ),
  );
}
