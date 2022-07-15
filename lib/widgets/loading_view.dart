import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;
  const LoadingWidget({
    Key key,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(8),
        child: SpinKitThreeBounce(
          size: 20,
          color: color,
        ),
      ),
    );
  }
}
