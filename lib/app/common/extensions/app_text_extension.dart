import 'package:flutter/material.dart';

extension AppTextExtensions on String {
  Widget asLabelButton({Color? color}) => Text(
        this,
        style: TextStyle(
          fontSize: 14,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      );
  Widget asTitleBig({Color? color, FontWeight? fontWeight}) => Text(
        this,
        style: TextStyle(
          fontSize: 28,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
      );

  Widget asTitleSemiBig({Color? color, FontWeight? fontWeight}) => Text(
        this,
        style: TextStyle(
          fontSize: 24,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
      );

  Widget asTitleNormal({Color? color, FontWeight? fontWeight}) => Text(
        this,
        style: TextStyle(
          fontSize: 18,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w300,
        ),
      );

  Widget asTitleSmall({Color? color, FontWeight? fontWeight}) => Text(
        this,
        style: TextStyle(
          fontSize: 16,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w300,
          fontFamily: 'Raleway',
        ),
      );

  Widget asSubtitleBig({Color? color, FontWeight? fontWeight}) => Text(
        this,
        style: TextStyle(
          fontSize: 14,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w300,
          fontFamily: 'Raleway',
        ),
      );

  Widget asSubtitleNormal(
          {Color? color,
          FontWeight? fontWeight,
          TextOverflow? overflow,
          TextAlign? textAlign}) =>
      Text(
        this,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w300,
          overflow: overflow,
        ),
      );

  Widget asSubtitleSmall({Color? color, FontWeight? fontWeight}) => Text(
        this,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w300,
        ),
      );
}
