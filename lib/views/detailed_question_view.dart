import 'package:apho/constants/images.dart';
import 'package:apho/models/question.dart';
import 'package:apho/models/tip.dart';
import 'package:apho/models/user.dart';
import 'package:apho/theming/theme_controller.dart';
import 'package:apho/widgets/single_image.dart';
import 'package:apho/widgets/top_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../constants/basic.dart';
import '../models/thing_type.dart';
import '../services/dynamic_link_services.dart';
import '../widgets/deleted_item.dart';
import 'detailed_image_view.dart';
import 'detailed_tip_view.dart';
import '../widgets/loading_view.dart';

class DetailedQuestionView extends StatefulWidget {
  final QuestionModel question;
  final String questionID;
  DetailedQuestionView({
    Key key,
    @required this.question,
    @required this.questionID,
  }) : super(key: key);

  @override
  _DetailedQuestionViewState createState() => _DetailedQuestionViewState();
}

class _DetailedQuestionViewState extends State<DetailedQuestionView> {
  String timeAgo;
  bool shareProcessing = false;

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
                  return DeletedItem(
                    what: "Question",
                  );
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

  body(
    QuestionModel question,
  ) {
    timeAgo = timeago.format(
      DateTime.fromMillisecondsSinceEpoch(question.time),
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                laboratory,
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8),
                BlendMode.darken,
              ),
            )),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: 15,
                      ),
                      SafeArea(
                        child: TopCard(
                          tip: question,
                          qn: true,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: 30,
                      ),
                      question.private
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                  ),
                                  child: Material(
                                    elevation: 7,
                                    borderRadius: BorderRadius.circular(140),
                                    child: Container(
                                        height: 64,
                                        width: 64,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white, width: 4),
                                            borderRadius:
                                                BorderRadius.circular(140)),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                            defaultUserPic,
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Anonymous asked :",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      timeAgo,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(question.senderID)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10.0,
                                            ),
                                            child: Material(
                                              elevation: 7,
                                              borderRadius:
                                                  BorderRadius.circular(140),
                                              child: Container(
                                                  height: 64,
                                                  width: 64,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              140)),
                                                  child: CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                      defaultUserPic,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SpinKitThreeBounce(
                                            color: Colors.blue,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            " asked :",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        timeAgo,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  );
                                } else {
                                  UserModel userModel = UserModel.fromSnapshot(
                                    snapshot.data,
                                  );

                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10.0,
                                        ),
                                        child: Material(
                                          elevation: 7,
                                          borderRadius:
                                              BorderRadius.circular(140),
                                          child: Container(
                                            height: 64,
                                            width: 64,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 4),
                                              borderRadius:
                                                  BorderRadius.circular(140),
                                            ),
                                            child: CircleAvatar(
                                              backgroundImage: userModel
                                                          .profilePic ==
                                                      null
                                                  ? AssetImage(
                                                      defaultUserPic,
                                                    )
                                                  : CachedNetworkImageProvider(
                                                      userModel.profilePic,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Visibility(
                                            visible: userModel.serviceProvider,
                                            child: Text(
                                              userModel.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            userModel.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            timeAgo,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          question.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          question.body,
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Visibility(
                        visible: question.imagesCount != 0,
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            top: 10,
                          ),
                          child: Material(
                            elevation: 8,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailedImage(
                                        images: question.images,
                                      ),
                                    ),
                                  );
                                },
                                child: Carousel(
                                  images: question.images
                                      .map((e) => SingleImage(image: e))
                                      .toList(),
                                  boxFit: BoxFit.cover,
                                  autoplay: true,
                                  indicatorBgPadding: 5.0,
                                  dotPosition: DotPosition.bottomCenter,
                                  animationCurve: Curves.fastOutSlowIn,
                                  animationDuration: Duration(
                                    milliseconds: 2000,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !question.pending &&
                            !question.rejected &&
                            question.answer != null,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0.0, 2),
                                  blurRadius: 6)
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Answer:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                question.answer ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: !question.pending && !question.rejected,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Text(
                            "Topics: ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !question.pending,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: question.pending || question.rejected
                              ? []
                              : buildChips(question.tags, true),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      question.pending || question.rejected
                          ? SizedBox(
                              height: 1,
                            )
                          : Container(
                              padding: EdgeInsetsDirectional.only(
                                top: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.5),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Related Health Tips",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Divider(
                                      color: Colors.white,
                                    ),
                                  ),
                                  strm(false, question),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Related Questions",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Divider(
                                      color: Colors.white,
                                    ),
                                  ),
                                  strm(true, question),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
          question.pending || question.rejected
              ? Positioned(
                  bottom: 10,
                  right: 10,
                  child: SizedBox(),
                )
              : Positioned(
                  bottom: 10,
                  right: 10,
                  child: Row(
                    children: [
                      FloatingActionButton(
                        heroTag: "share_question",
                        onPressed: () async {
                          setState(() {
                            shareProcessing = true;
                          });

                          String pp = await DynamicLinkServices().generateLink(
                            context: context,
                            id: question.id,
                            title: question.title,
                            desc: question.body,
                            type: ThingType.QUESTION,
                            image: question.images.isEmpty
                                ? null
                                : question.images[0],
                            userID: "Web User",
                          );

                          if (pp != null) {
                            Share.share(
                              pp,
                              subject:
                                  "Check out this ${ThingType.QUESTION} from $capitalizedAppName",
                            );
                          }

                          setState(() {
                            shareProcessing = false;
                          });
                        },
                        child: shareProcessing
                            ? CircularProgressIndicator()
                            : Icon(
                                Icons.share,
                              ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  strm(
    bool questions,
    QuestionModel question,
  ) {
    return StreamBuilder(
      stream: questions
          ? FirebaseFirestore.instance
              .collection(QuestionModel.DIRECTORY)
              .where(QuestionModel.QUESTION, isEqualTo: true)
              .where(QuestionModel.PENDING, isEqualTo: false)
              .where(QuestionModel.APPROVED, isEqualTo: true)
              .where(QuestionModel.TAGS, arrayContainsAny: question.tags)
              .orderBy(QuestionModel.DATEOFPOSTING, descending: true)
              .limitToLast(4)
              .snapshots()
          : FirebaseFirestore.instance
              .collection(QuestionModel.DIRECTORY)
              .where(QuestionModel.QUESTION, isEqualTo: false)
              .where(QuestionModel.TAGS, arrayContainsAny: question.tags)
              .orderBy(QuestionModel.DATEOFPOSTING, descending: true)
              .limitToLast(4)
              .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            children: [
              SizedBox(
                height: 70,
              ),
              LoadingWidget(),
              SizedBox(
                height: 70,
              ),
            ],
          );
        } else {
          return SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: snapshot.data.docs.length == 0
                ? Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            voidSvg,
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "No Results Found",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : snapshot.data.docs.length == 1 &&
                        snapshot.data.docs[0].id == question.id
                    ? Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              SvgPicture.asset(
                                voidSvg,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "No Results Found",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          if (questions) {
                            QuestionModel qn = QuestionModel.fromSnapshot(
                                snapshot.data.docs[index]);
                            return qn.id == question.id
                                ? SizedBox(height: 1)
                                : singleQn(qn);
                          } else {
                            TipModel tp = TipModel.fromSnapshot(
                                snapshot.data.docs[index]);
                            return tp.id == question.id
                                ? SizedBox(height: 1)
                                : singleTip(tp);
                          }
                        },
                      ),
          );
        }
      },
    );
  }

  singleTip(TipModel tip) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
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
          child: InkWell(
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailedTipView(
                    tip: tip,
                    tipID: tip.id,
                  ),
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    tip.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    tip.body,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        //  color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Spacer(),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: buildChips(tip.tags, false),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  singleQn(QuestionModel qn) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
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
          child: InkWell(
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailedQuestionView(
                    question: qn,
                    questionID: qn.id,
                  ),
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    qn.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    qn.body,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        //  color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Spacer(),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: buildChips(qn.tags, false),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  singleButton(
    String text,
    Color color,
    Function onPressed,
  ) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            height: 70,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildChips(List<dynamic> mans, bool real) {
    int count = 0;
    List<Widget> chips = [];
    if (real) {
      for (var element in mans) {
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
      }
    } else {
      for (var element in mans) {
        if (count < 3) {
          chips.add(Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Chip(
              label: Text(
                element,
              ),
              labelPadding:
                  EdgeInsets.only(top: 2, left: 8, right: 8, bottom: 2),
              elevation: 10,
            ),
          ));
          count++;
        } else {}
      }
    }

    return chips;
  }
}
