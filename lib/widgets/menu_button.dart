import 'package:apho/constants/images.dart';
import 'package:apho/theming/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuButton extends StatelessWidget {
  final Color color;
  final int size;
  MenuButton({Key key, @required this.color, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: SvgPicture.asset(
          menu,
          width: size ?? 25,
          color: color ?? ThemeBuilder.of(context).getCurrentTheme() == Brightness.dark
                  ? Colors.white
                  : Colors.black,
        ),
      ),
    );
  }
}
