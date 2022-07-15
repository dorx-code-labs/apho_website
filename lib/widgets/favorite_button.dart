import 'package:apho/constants/ui.dart';
import 'package:apho/widgets/custom_dialog_box.dart';
import 'package:flutter/material.dart';

import '../services/ui_services.dart';
import '../views/home_screen.dart';

class FavoriteButton extends StatefulWidget {
  final String thingID;
  final String thingType;

  FavoriteButton({
    Key key,
    @required this.thingID,
    @required this.thingType,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return likedButton(
      false,
      false,
    );
  }

  likedButton(
    bool liked,
    bool tappable,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialogBox(
                bodyText:
                    "Saving of health tips and questions is only available in the app of the web app. Tap this button to proceed to the app",
                buttonText: "Press Me",
                onButtonTap: () {
                  UIServices().showDatSheet(
                    AppOptionsBottomSheet(),
                    true,
                    context,
                  );
                },
                showOtherButton: true,
              );
            },
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: standardBorderRadius,
            border: Border.all(
              color: Colors.grey,
            ),
            color: liked ? Colors.red : Theme.of(context).canvasColor,
          ),
          child: Text(
            liked ? "Saved" : "Save",
            style: TextStyle(
              color: liked ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }
}
