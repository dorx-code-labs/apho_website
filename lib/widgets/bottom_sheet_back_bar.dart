import 'package:apho/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:apho/services/navigation/navigation.dart';

class BackBar extends StatefulWidget {
  final String text;
  final bool webSensitive;
  final Function onPressed;
  final List<Widget> actions;
  final IconData icon;

  BackBar({
    Key key,
    @required this.icon,
    @required this.onPressed,
    this.webSensitive = false,
    @required this.text,
    this.actions,
  }) : super(key: key);

  @override
  State<BackBar> createState() => _BackBarState();
}

class _BackBarState extends State<BackBar> {
  @override
  Widget build(BuildContext context) {
    return widget.webSensitive && Responsive.isDesktop(context)
        ? SizedBox()
        : body();
  }

  body() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  widget.icon ?? Icons.arrow_back_ios_rounded,
                ),
                onPressed: widget.onPressed ??
                    () {
                      NavigationService().pop();
                    },
              ),
              Expanded(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (widget.actions != null && widget.actions.isNotEmpty)
                Row(
                  children: widget.actions.map((e) {
                    return e;
                  }).toList(),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
