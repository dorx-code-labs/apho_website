import 'package:apho/widgets/bottom_sheet_back_bar.dart';
import 'package:flutter/material.dart';

class CareersBottomSheet extends StatefulWidget {
  CareersBottomSheet({Key key}) : super(key: key);

  @override
  State<CareersBottomSheet> createState() => _CareersBottomSheetState();
}

class _CareersBottomSheetState extends State<CareersBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackBar(
          icon: null,
          onPressed: null,
          text: "Careers",
        ),
        Expanded(
          child: Column(
            children: [//TODO: here
            ],
          ),
        )
      ],
    );
  }
}
