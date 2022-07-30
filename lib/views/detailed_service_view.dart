import 'package:apho/models/service.dart';
import 'package:flutter/material.dart';

class DetailedServiceView extends StatefulWidget {
  final ServiceModel serviceModel;
  DetailedServiceView({
    Key key,
    @required this.serviceModel,
  }) : super(key: key);

  @override
  State<DetailedServiceView> createState() => _DetailedServiceViewState();
}

class _DetailedServiceViewState extends State<DetailedServiceView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(
              widget.serviceModel.image,
              height: MediaQuery.of(context).size.height * 0.8,
            ),
          ],
        ),
      ],
    );
  }
}
