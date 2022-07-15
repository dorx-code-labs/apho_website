import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:apho/constants/images.dart';

class NoDataFound extends StatefulWidget {
  final String text;
  final bool withExpanded;
  final String doSthText;
  final Function onTap;
  final double picSize;
  NoDataFound({
    Key key,
    @required this.text,
    this.onTap,
    this.withExpanded = false,
    this.doSthText,
    this.picSize,
  }) : super(key: key);

  @override
  _NoDataFoundState createState() => _NoDataFoundState();
}

class _NoDataFoundState extends State<NoDataFound> {
  @override
  Widget build(BuildContext context) {
    return widget.withExpanded
        ? Column(
            children: [
              Expanded(child: body()),
            ],
          )
        : Center(child: body());
  }

  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.withExpanded) Spacer(),
        if (widget.withExpanded)
          Expanded(
            child: SvgPicture.asset(
              voidSvg,
              height:
                  widget.picSize ?? MediaQuery.of(context).size.height * 0.2,
            ),
          ),
        if (!widget.withExpanded)
          SvgPicture.asset(
            voidSvg,
            height: widget.picSize ?? MediaQuery.of(context).size.height * 0.1,
          ),
        SizedBox(
          height: 5,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        if (widget.onTap != null)
          TextButton(
            onPressed: () {
              widget.onTap();
            },
            child: Text(
              widget.doSthText ?? "Tap Me",
            ),
          ),
        if (widget.withExpanded) Spacer(),
      ],
    );
  }
}
