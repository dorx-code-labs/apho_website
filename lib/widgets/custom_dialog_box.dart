import 'package:flutter/material.dart';
import 'package:apho/constants/basic.dart';
import 'package:apho/constants/images.dart';
import 'package:apho/constants/ui.dart';
import 'package:apho/services/navigation/navigation.dart';

class CustomDialogBox extends StatelessWidget {
  final String bodyText;
  final bool showOtherButton;
  final String buttonText;
  final List<String> bullets;
  final Function onButtonTap;
  final String afterBullets;
  final Widget child;

  CustomDialogBox({
    Key key,
    @required this.bodyText,
    @required this.buttonText,
    @required this.onButtonTap,
    @required this.showOtherButton,
    this.afterBullets,
    this.bullets,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    width: 80,
                    height: 80,
                    image: AssetImage(
                      logo,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    capitalizedAppName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              if (child != null) child,
              if (child == null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      bodyText ??
                          "You need to log in or create an account to use this feature. Press the button below to log in.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (bullets != null && bullets.isNotEmpty)
                      Column(
                        children: bullets.map((e) {
                          return Padding(
                            padding: EdgeInsets.all(3),
                            child: Row(
                              children: [
                                Text("-"),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    e,
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    if (afterBullets != null)
                      Text(
                        afterBullets,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              if (child == null)
                SizedBox(
                  height: 20,
                ),
              if (child == null)
                Container(
                    child: showOtherButton != null && showOtherButton
                        ? InkWell(
                            onTap: () async {
                              NavigationService().pop();
                              onButtonTap();
                            },
                            child: Material(
                              borderRadius: standardBorderRadius,
                              elevation: standardElevation,
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 10,
                                  bottom: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: standardBorderRadius,
                                ),
                                child: Text(
                                  buttonText,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 1,
                          ))
            ],
          ),
        ),
      ),
    );
  }
}
