
import 'package:flutter/material.dart';

import '../constants/ui.dart';

class NimbusButton extends StatelessWidget {
  NimbusButton({
    Key key,
    @required this.buttonTitle,
    this.width = 150,
    this.height = 60,
    this.titleStyle,
    this.titleColor = Colors.white,
    this.buttonColor = Colors.black45,
    this.onPressed,
    this.padding = const EdgeInsets.all(8),
    this.borderRadius = const BorderRadius.all(
      Radius.circular(borderDouble),
    ),
    this.opensUrl = false,
    this.url = "",
  }) : super(key: key);

  final VoidCallback onPressed;
  final double width;
  final double height;
  final String buttonTitle;
  final TextStyle titleStyle;
  final Color titleColor;
  final Color buttonColor;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final String url;
  final bool opensUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: MaterialButton(
        minWidth: width,
        height: height,
        onPressed: opensUrl ? () {} : onPressed,
        color: buttonColor,
        child: Padding(
          padding: padding,
          child: buildChild(context),
        ),
      ),
    );
  }

  Widget buildChild(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Text(
      buttonTitle,
      textAlign: TextAlign.center,
      style: titleStyle ??
          textTheme.button?.copyWith(
            color: titleColor,
            fontSize: 16,
            letterSpacing: 1.1,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
