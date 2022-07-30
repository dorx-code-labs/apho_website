import 'package:apho/constants/images.dart';
import 'package:apho/models/question.dart';
import 'package:apho/models/tip.dart';
import 'package:apho/theming/theme_controller.dart';
import 'package:apho/widgets/single_image.dart';
import 'package:apho/widgets/top_card.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

import '../constants/basic.dart';
import '../models/thing_type.dart';
import '../services/dynamic_link_services.dart';
import '../widgets/deleted_item.dart';
import 'detailed_image_view.dart';
import 'detailed_question_view.dart';
import '../widgets/loading_view.dart';

class DetailedTipView extends StatefulWidget {
  final TipModel tip;
  final String tipID;
  DetailedTipView({
    Key key,
    @required this.tip,
    @required this.tipID,
  }) : super(key: key);

  @override
  _DetailedTipViewState createState() => _DetailedTipViewState();
}

class _DetailedTipViewState extends State<DetailedTipView> {
  bool shareProcessing = false;

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

  body(
    TipModel tip,
  ) {
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
                          tip: tip,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          tip.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          tip.body,
                          style: TextStyle(
                            fontSize: 18,
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
                        visible: tip.imagesCount != 0,
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
                                        images: tip.images,
                                      ),
                                    ),
                                  );
                                },
                                child: Carousel(
                                  images: tip.images
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
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
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
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: buildChips(tip.tags, true),
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
                      Container(
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
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            strm(false, tip),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Related Questions",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            strm(true, tip),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                FloatingActionButton(
                  heroTag: "share_tip",
                  onPressed: () async {
                    setState(() {
                      shareProcessing = true;
                    });

                    String pp = await DynamicLinkServices().generateLink(
                      context: context,
                      id: tip.id,
                      title: tip.title,
                      desc: tip.body,
                      type: ThingType.HEALTHTIP,
                      image: tip.images.isEmpty ? null : tip.images[0],
                      userID: "website visitor",
                    );

                    if (pp != null) {
                      Share.share(
                        pp,
                        subject:
                            "Check out this ${ThingType.HEALTHTIP} from $capitalizedAppName",
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

  strm(bool questions, TipModel tip) {
    return StreamBuilder(
      stream: questions
          ? FirebaseFirestore.instance
              .collection(QuestionModel.DIRECTORY)
              .where(QuestionModel.QUESTION, isEqualTo: true)
              .where(QuestionModel.PENDING, isEqualTo: false)
              .where(QuestionModel.APPROVED, isEqualTo: true)
              .where(QuestionModel.TAGS, arrayContainsAny: tip.tags)
              .orderBy(QuestionModel.DATEOFPOSTING, descending: true)
              .limitToLast(4)
              .snapshots()
          : FirebaseFirestore.instance
              .collection(QuestionModel.DIRECTORY)
              .where(QuestionModel.QUESTION, isEqualTo: false)
              .where(QuestionModel.TAGS, arrayContainsAny: tip.tags)
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
                        snapshot.data.docs[0].id == tip.id
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
                            return qn.id == tip.id
                                ? SizedBox(height: 1)
                                : singleQn(qn);
                          } else {
                            TipModel tp = TipModel.fromSnapshot(
                                snapshot.data.docs[index]);
                            return tp.id == tip.id
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
