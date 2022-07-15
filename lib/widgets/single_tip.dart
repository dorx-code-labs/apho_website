import 'package:apho/models/tip.dart';
import 'package:apho/services/navigation/navigation.dart';
import 'package:apho/theming/theme_controller.dart';
import 'package:apho/views/detailed_tip_view.dart';
import 'package:apho/widgets/pictures_grid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/question.dart';
import 'deleted_item.dart';
import 'loading_view.dart';

class SingleHealthTip extends StatefulWidget {
  final TipModel tip;
  final Function onTap;
  final String tipID;
  SingleHealthTip({
    Key key,
    @required this.tip,
    this.onTap,
    this.tipID,
  }) : super(key: key);

  @override
  State<SingleHealthTip> createState() => _SingleHealthTipState();
}

class _SingleHealthTipState extends State<SingleHealthTip> {
  @override
  Widget build(BuildContext context) {
    return widget.tip == null
        ? StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(QuestionModel.DIRECTORY)
                .doc(widget.tipID)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.data() == null) {
                  return DeletedItem(what: "Health Tip");
                } else {
                  TipModel model = TipModel.fromSnapshot(
                    snapshot.data,
                  );

                  return body(model);
                }
              } else {
                return LoadingWidget();
              }
            })
        : body(
            widget.tip,
          );
  }

  body(TipModel tip) {
    return Container(
      margin: EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: 7,
        right: 7,
      ),
      child: Material(
        elevation: 15,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(
            4,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: widget.onTap ??
                    () async {
                      NavigationService().push(
                        DetailedTipView(
                          tipID: tip.id,
                          tip: tip,
                        ),
                      );
                    },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: 12,
                    bottom: 10,
                    right: 12,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      border: Border.all(
                        width: 1,
                        color: ThemeBuilder.of(context).getCurrentTheme() ==
                                Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        tip.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        tip.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            //  color: Colors.grey[700],
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PicturesGrid(
                        images: tip.images,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: buildChips(
                          tip.tags,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildChips(List<dynamic> mans) {
    int count = 0;
    List<Widget> chips = [];
    for (var element in mans) {
      if (count < 3) {
        chips.add(Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Chip(
            label: Text(
              element,
            ),
            labelPadding: EdgeInsets.only(top: 2, left: 8, right: 8, bottom: 2),
            elevation: 10,
          ),
        ));
        count++;
      } else {}
    }

    return chips;
  }
}
