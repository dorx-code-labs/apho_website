import 'package:apho/constants/ui.dart';
import 'package:apho/main.dart';
import 'package:apho/models/thing_type.dart';
import 'package:apho/services/ui_services.dart';
import 'package:apho/views/home_screen.dart';
import 'package:apho/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

import '../constants/images.dart';
import 'nimbus_button.dart';

class WebNavigationBar extends StatefulWidget {
  final Function goHome;
  final String mode;
  final Function(String) switchToIndex;

  WebNavigationBar({
    Key key,
    @required this.goHome,
    @required this.mode,
    @required this.switchToIndex,
  }) : super(key: key);

  @override
  State<WebNavigationBar> createState() => _WebNavigationBarState();
}

class _WebNavigationBarState extends State<WebNavigationBar> {
  double barHeight = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 2,
      ),
      height: barHeight,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              widget.goHome();
            },
            child: Image.asset(
              logo,
              height: barHeight - 30,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          VerticalDivider(),
          SizedBox(
            width: 10,
          ),
          Row(
            children: [
              SingleNavBarItem(
                onTap: () {
                  widget.switchToIndex(
                    MyRoutePath.HOME,
                  );
                },
                title: "Home",
                isSelected: widget.mode == MyRoutePath.HOME,
              ),
              SingleNavBarItem(
                onTap: () {
                  widget.switchToIndex(
                    MyRoutePath.SERVICE,
                  );
                },
                subNavs: [
                  NavItemData(
                    name: "Obstetric and Newborn Care",
                    type: ThingType.SERVICE,
                  ),
                  NavItemData(
                    name: "Antenatal Care",
                    type: ThingType.SERVICE,
                  ),
                  NavItemData(
                    name: "Homecare Nurses",
                    type: ThingType.SERVICE,
                  ),
                  NavItemData(
                    name: "Cleaning and Housekeeping",
                    type: ThingType.SERVICE,
                  ),
                  NavItemData(
                    name: "PostNatal Care",
                    type: ThingType.SERVICE,
                  ),
                ],
                title: "Services",
                isSelected: widget.mode == MyRoutePath.SERVICE,
              ),
              SingleNavBarItem(
                onTap: () {
                  widget.switchToIndex(
                    MyRoutePath.FORUM,
                  );
                },
                title: "Health",
                isSelected: widget.mode == MyRoutePath.FORUM,
              ),
              SingleNavBarItem(
                onTap: () {
                  widget.switchToIndex(
                    MyRoutePath.TEAM,
                  );
                },
                title: "Team",
                isSelected: widget.mode == MyRoutePath.TEAM,
              ),
            ],
          ),
          Spacer(),
          NimbusButton(
            onPressed: () {
              UIServices().showDatSheet(
                AppOptionsBottomSheet(),
                true,
                context,
              );
            },
            buttonTitle: "Get the App",
          ),
          SizedBox(
            width: 5,
          ),
          NimbusButton(
            onPressed: () {
              widget.switchToIndex(
                MyRoutePath.CONTACT,
              );
            },
            buttonTitle: "Contact",
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}

class NavItemData {
  final String name;
  final String type;
  final Color color;
  final String desc;
  final IconData icon;
  bool isSelected;

  NavItemData({
    @required this.name,
    this.type,
    this.color,
    this.desc,
    this.icon,
    this.isSelected = false,
  });
}

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 60,
      color: Colors.grey,
    );
  }
}

class SingleNavBarItem extends StatefulWidget {
  final String title;
  final Color titleColor;
  final bool isSelected;
  final List<NavItemData> subNavs;
  final GestureTapCallback onTap;

  SingleNavBarItem({
    Key key,
    @required this.title,
    this.titleColor = Colors.black,
    this.isSelected = false,
    this.subNavs = const [],
    this.onTap,
  }) : super(key: key);

  @override
  State<SingleNavBarItem> createState() => _SingleNavBarItemState();
}

class _SingleNavBarItemState extends State<SingleNavBarItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: Responsive.isMobile(context)
          ? widget.subNavs.isNotEmpty
              ? ExpansionTile(
                  trailing: Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                  title: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  childrenPadding: EdgeInsets.only(
                    left: 20,
                  ),
                  children: [
                    if (widget.subNavs != null)
                      Column(
                        children: widget.subNavs
                            .map(
                              (e) => ListTile(
                                onTap: () {
                                  widget.onTap();
                                },
                                title: Text(
                                  e.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )
                  ],
                )
              : ListTile(
                  onTap: () {
                    widget.onTap();
                  },
                  title: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
          : widget.subNavs.isNotEmpty
              ? FocusedMenuHolder(
                  onPressed: () {},
                  openWithTap: true,
                  menuItems: widget.subNavs
                      .map(
                        (e) => FocusedMenuItem(
                          title: Text(
                            e.name,
                          ),
                          onPressed: () {
                            widget.onTap();
                            /*  if (e.type == ThingType.SERVICE) {
                              NavigationService().push(
                                ServicesView(),
                              );
                            } else {
                              NavigationService().push(
                                ProductsView(),
                              );
                            } */
                          },
                        ),
                      )
                      .toList(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 3,
                    ),
                    child: InkWell(
                      onTap: widget.onTap,
                      child: Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: [
                          if (!Responsive.isMobile(context))
                            widget.isSelected
                                ? Positioned(
                                    top: 12,
                                    child: SelectedIndicator(
                                      width: 60,
                                    ),
                                  )
                                : Positioned(
                                    top: 12,
                                    child: AnimatedHoverIndicator(
                                      isHover: _hovering,
                                      width: 60,
                                    ),
                                  ),
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 3,
                  ),
                  child: InkWell(
                    onTap: widget.onTap,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        if (!Responsive.isMobile(context))
                          widget.isSelected
                              ? Positioned(
                                  top: 12,
                                  child: SelectedIndicator(
                                    width: 60,
                                  ),
                                )
                              : Positioned(
                                  top: 12,
                                  child: AnimatedHoverIndicator(
                                    isHover: _hovering,
                                    width: 60,
                                  ),
                                ),
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  void _mouseEnter(bool hovering) {
    setState(() {
      _hovering = hovering;
    });
  }
}

class SelectedIndicator extends StatelessWidget {
  SelectedIndicator({
    Key key,
    @required this.width,
    this.indicatorColor = primaryColor,
    this.height = 6,
    this.opacity = 0.85,
  }) : super(key: key);

  final Color indicatorColor;
  final double width;
  final double height;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: width,
        height: height,
        color: indicatorColor,
      ),
    );
  }
}

class AnimatedHoverIndicator extends StatelessWidget {
  AnimatedHoverIndicator({
    Key key,
    @required this.width,
    this.indicatorColor = primaryColor,
    this.height = 6,
    this.curve = Curves.linearToEaseOut,
    this.isHover = false,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  final Color indicatorColor;
  final double width;
  final double height;
  final Curve curve;
  final Duration duration;
  final bool isHover;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isHover ? width : 0,
      height: height,
      color: indicatorColor,
      duration: duration,
      curve: curve,
    );
  }
}

class AnimatedHoverIndicator2 extends StatelessWidget {
  AnimatedHoverIndicator2({
    Key key,
    // required this.width,
    @required this.animation,
    this.indicatorColor = Colors.white,
    this.height = 1,
    this.curve = Curves.linearToEaseOut,
    this.duration = const Duration(milliseconds: 800),
  }) : super(key: key);

  final Color indicatorColor;
  // final double width;
  final double height;
  final Curve curve;
  final Animation<double> animation;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: animation.value,
      height: height,
      color: indicatorColor,
      duration: duration,
      curve: curve,
    );
  }
}
