import 'package:flutter/material.dart';
import 'package:apho/constants/ui.dart';
import 'package:apho/services/ui_services.dart';

class SingleSelectTile extends StatelessWidget {
  final String asset;
  final String text;
  final String desc;
  final IconData icon;
  final bool selected;
  final Color iconColor;
  final Function onTap;
  const SingleSelectTile({
    Key key,
    @required this.onTap,
    @required this.selected,
    @required this.asset,
    this.desc,
    @required this.text,
    this.iconColor = primaryColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(
            selected ? 3 : 0,
          ),
          decoration: BoxDecoration(
            borderRadius: standardBorderRadius,
            border: selected ? Border.all(width: 1) : null,
          ),
          child: Material(
            borderRadius: standardBorderRadius,
            elevation: 8,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: standardBorderRadius,
                image: UIServices().decorationImage(
                  asset,
                  true,
                ),
              ),
              child: Row(
                children: [
                  if (icon != null)
                    Icon(
                      icon,
                      color: iconColor,
                    ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            color: asset != null ? Colors.white : null,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (desc != null)
                          Text(
                            desc,
                            style: TextStyle(
                              color: asset != null ? Colors.white : null,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
