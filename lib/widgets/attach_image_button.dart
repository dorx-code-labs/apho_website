import 'package:apho/theming/theme_controller.dart';
import 'package:flutter/material.dart';

class AttachImageButton extends StatelessWidget {
  final Function onAttachPressed;
  AttachImageButton({Key key, @required this.onAttachPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onAttachPressed();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,
            color: ThemeBuilder.of(context).getCurrentTheme() == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_photo_alternate),
              Text("Add Images")
            ],
          ),
        ),
      ),
    );
  }
}
