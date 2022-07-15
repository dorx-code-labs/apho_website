import 'package:apho/constants/ui.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';

class CustomScrollBar extends StatefulWidget {
  final BoxScrollView Function(ScrollController) builder;
  CustomScrollBar({
    Key key,
    this.builder,
  }) : super(key: key);

  @override
  State<CustomScrollBar> createState() => _CustomScrollBarState();
}

class _CustomScrollBarState extends State<CustomScrollBar> {
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollbar(
      heightScrollThumb: 200,
      backgroundColor: primaryColor,
      child: widget.builder(controller),
      controller: controller,
      scrollThumbBuilder: _scrollThumbBuilder,
    );
  }

  Widget _scrollThumbBuilder(
      Color backgroundColor,
      Animation<double> thumbAnimation,
      Animation<double> labelAnimation,
      double height,
      {Text labelText,
      BoxConstraints labelConstraints}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: standardBorderRadius,
        gradient: LinearGradient(
          colors: [
            primaryColor,
            altColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      width: 12,
      height: height,
    );
  }
}
