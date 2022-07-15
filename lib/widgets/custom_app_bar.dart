import 'package:apho/constants/basic.dart';
import 'package:apho/constants/ui.dart';
import 'package:apho/services/ui_services.dart';
import 'package:apho/views/home_screen.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final List<IconData> icons;
  final TabController controller;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomAppBar({
    Key key,
    @required this.icons,
    @required this.selectedIndex,
    @required this.onTap,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 65.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              capitalizedAppName,
              style: const TextStyle(
                color: primaryColor,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
          ),
          SizedBox(
            height: double.infinity,
            width: 600.0,
            child: CustomTabBar(
              controller: controller,
              icons: icons,
              selectedIndex: selectedIndex,
              onTap: onTap,
              isBottomIndicator: true,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    UIServices().showDatSheet(
                      AppOptionsBottomSheet(),
                      true,
                      context,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: standardBorderRadius,
                      color: primaryColor,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "GET THE APP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Function onPressed;

  const CircleButton({
    Key key,
    @required this.icon,
    @required this.iconSize,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon),
        iconSize: iconSize,
        color: Colors.black,
        onPressed: onPressed,
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;
  final TabController controller;
  final bool isBottomIndicator;

  const CustomTabBar({
    Key key,
    @required this.controller,
    @required this.icons,
    @required this.selectedIndex,
    @required this.onTap,
    this.isBottomIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        border: isBottomIndicator
            ? Border(
                bottom: BorderSide(
                  color: primaryColor,
                  width: 3.0,
                ),
              )
            : Border(
                top: BorderSide(
                  color: primaryColor,
                  width: 3.0,
                ),
              ),
      ),
      tabs: icons
          .asMap()
          .map(
            (i, e) => MapEntry(
              i,
              Tab(
                icon: Icon(
                  e,
                  color: i == selectedIndex ? primaryColor : Colors.black45,
                  size: 30.0,
                ),
              ),
            ),
          )
          .values
          .toList(),
      onTap: onTap,
    );
  }
}
