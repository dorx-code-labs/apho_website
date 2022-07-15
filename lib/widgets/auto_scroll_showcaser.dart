import 'package:apho/widgets/single_image.dart';
import 'package:flutter/material.dart';

import '../constants/ui.dart';
import 'animated_bar.dart';

class AutoScrollShowcaser extends StatefulWidget {
  final List images;
  final double height;
  final Function(int) onPageChange;
  final Duration pause;
  final Duration animDuration;
  final bool darken;
  final double vpFraction;
  final bool widget;
  final String placeholderText;
  final bool showIndicator;
  AutoScrollShowcaser({
    Key key,
    @required this.images,
    this.onPageChange,
    this.height = 200,
    this.widget = false,
    this.vpFraction,
    this.darken = false,
    @required this.placeholderText,
    this.pause = const Duration(seconds: 5),
    this.animDuration = const Duration(milliseconds: 1),
    this.showIndicator = true,
  }) : super(key: key);

  @override
  _AutoScrollShowcaserState createState() => _AutoScrollShowcaserState();
}

class _AutoScrollShowcaserState extends State<AutoScrollShowcaser>
    with TickerProviderStateMixin {
  PageController _pageController;
  AnimationController _animController;
  Duration pause = Duration(seconds: 5);
  Duration animDuration = Duration(milliseconds: 500);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: widget.vpFraction ?? 1,
    );

    if (widget.pause != null) {
      pause = widget.pause;
    }

    _currentIndex = 0;
    _animController = AnimationController(vsync: this);
    _loadStory(animateToPage: false);
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();

        setState(() {
          if (_currentIndex + 1 < widget.images.length) {
            _currentIndex += 1;
            _loadStory();
          } else {
            // Out of bounds - loop story
            // You can also Navigator.of(context).pop() here
            _currentIndex = 0;
            _loadStory();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    if (_animController != null) _animController.dispose();
    if (_pageController != null) _pageController.dispose();
    super.dispose();
  }

  void _loadStory({bool animateToPage = true}) {
    _animController.stop();
    _animController.reset();
    _animController.duration = pause;
    _animController.forward();

    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: animDuration,
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: standardBorderRadius,
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            PageView(
              onPageChanged: (i) {
                _currentIndex = i;

                setState(() {});

                if (widget.onPageChange != null) {
                  widget.onPageChange(i);
                }

                _animController.stop();
                _animController.reset();
                _animController.duration = Duration(seconds: 5);
                _animController.forward();
              },
              controller: _pageController,
              children: widget.images.map<Widget>((e) {
                bool selected = _currentIndex == widget.images.indexOf(e);

                return Container(
                  padding: widget.vpFraction != null
                      ? selected
                          ? null
                          : EdgeInsets.symmetric(vertical: 20)
                      : null,
                  child: widget.widget
                      ? e
                      : SingleImage(
                          image: e,
                          darken: widget.darken,
                        ),
                );
              }).toList(),
            ),
            if (widget.showIndicator)
              Positioned(
                  bottom: 5,
                  left: 5,
                  right: 5,
                  child: Row(
                    children: widget.images
                        .asMap()
                        .map((i, e) {
                          return MapEntry(
                            i,
                            AnimatedBar(
                              animController: _animController,
                              position: i,
                              currentIndex: _currentIndex,
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ))
          ],
        ),
      ),
    );
  }
}
