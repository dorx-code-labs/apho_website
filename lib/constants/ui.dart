import 'package:flutter/material.dart';
import 'package:apho/theming/theme_controller.dart';

import '../theming/theme_controller.dart';
import 'basic.dart';

const double borderDouble = 8;
BorderRadius standardBorderRadius = BorderRadius.circular(borderDouble);
double standardElevation = 4;
Color kTextLightColor = Colors.grey;
double kDefaultPadding = 10;

final BoxDecoration kRoundedFadedBorder = BoxDecoration(
  border: Border.all(color: Colors.white, width: .5),
  borderRadius: BorderRadius.circular(
    15.0,
  ),
);



getTabColor(
  BuildContext context,
  bool selected,
) {
  Color selectedColor =
      ThemeBuilder.of(context).getCurrentTheme() == Brightness.dark
          ? Colors.white
          : Colors.black;
  Color notSelectedColor = selectedColor.withOpacity(0.5);

  return selected ? selectedColor : notSelectedColor;
}

String sharedPrefBrightness = "${appName}_brightness";

String sharedPrefDoneWithOnBoarding = "${appName}_onboarding";

const primaryColor = Colors.blue;
Color altColor = Colors.blue[900];
const darkerBlue =  Color.fromARGB(255, 4, 52, 92);

const List<LinearGradient> listColors = [
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.indigoAccent,
      Colors.teal,
    ],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.purple,
      Colors.red,
    ],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.green,
      Colors.blue,
    ],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.orange,
      Colors.redAccent,
    ],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.purple,
      Colors.blue,
    ],
  ),
];
