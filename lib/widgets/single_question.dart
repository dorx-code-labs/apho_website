import 'package:apho/models/thing_type.dart';
import 'package:apho/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apho/models/question.dart';
import 'package:apho/services/navigation/navigation.dart';
import 'package:apho/theming/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:apho/views/detailed_question_view.dart';
import 'package:apho/widgets/pictures_grid.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../constants/ui.dart';
import '../models/question.dart';
import 'deleted_item.dart';
import 'favorite_button.dart';
import 'loading_view.dart';

class SingleQuestion extends StatefulWidget {
  final QuestionModel question;
  final String questionID;
  SingleQuestion({
    Key key,
    @required this.question,
    @required this.questionID,
  }) : super(key: key);

  @override
  _SingleQuestionState createState() => _SingleQuestionState();
}

class _SingleQuestionState extends State<SingleQuestion> {
  String timeAgo;

  @override
  Widget build(BuildContext context) {
    return widget.question == null
        ? StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(QuestionModel.DIRECTORY)
                .doc(widget.questionID)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.data() == null) {
                  return DeletedItem(what: "Question");
                } else {
                  QuestionModel model = QuestionModel.fromSnapshot(
                    snapshot.data,
                  );

                  return body(model);
                }
              } else {
                return LoadingWidget();
              }
            })
        : body(
            widget.question,
          );
  }

  body(QuestionModel question) {
    timeAgo = timeago.format(
      DateTime.fromMillisecondsSinceEpoch(question.time),
    );

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 4,
      ),
      child: Material(
        elevation: 8,
        borderRadius: standardBorderRadius,
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: standardBorderRadius,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      NavigationService().push(
                        DetailedQuestionView(
                          questionID: question.id,
                          question: question,
                        ),
                      );
                    },
                    child: Container(
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
                          Container(
                            padding: EdgeInsets.only(
                              top: 10,
                            ),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                question.private
                                    ? Text(
                                        "Anonymous asked",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection(UserModel.DIRECTORY)
                                            .doc(question.senderID)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return LoadingWidget();
                                          } else {
                                            UserModel userModel =
                                                UserModel.fromSnapshot(
                                                    snapshot.data);

                                            return Text(
                                              "${userModel.name} asked",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                Text(
                                  timeAgo,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                question.body,
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
                                images: question.images,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if (question.answer != null)
                    Text(
                      "Answered",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(
                    height: 5,
                  ),
                  if (question.pending)
                    Text(
                      "Pending Approval",
                    ),
                  if (question.approved)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FavoriteButton(
                          thingID: question.id,
                          thingType: ThingType.QUESTION,
                        ),
                      ],
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
