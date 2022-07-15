import 'package:apho/constants/ui.dart';
import 'package:apho/models/question.dart';
import 'package:apho/models/tip.dart';
import 'package:apho/services/ui_services.dart';
import 'package:apho/widgets/single_question.dart';
import 'package:apho/widgets/single_tip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import 'no_data_found_view.dart';

class ForumPage extends StatefulWidget {
  final int selected;
  ForumPage({
    Key key,
    this.selected,
  }) : super(key: key);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  TabController _controller;

  List<String> modes = [
    "Public Forum",
    "Health Tips",
  ];

  @override
  void initState() {
    _controller = TabController(
      initialIndex: widget.selected ?? 0,
      length: 2,
      vsync: this,
    );

    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Map<String, TipModel> tips = {};
  List<TipModel> taps = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return body();
  }

  body() {
    return SafeArea(
        child: NestedScrollView(
      headerSliverBuilder: (context, inner) {
        return [
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverAppBarDelegate(
              TabBar(
                controller: _controller,
                isScrollable: true,
                labelColor: getTabColor(context, true),
                unselectedLabelColor: getTabColor(context, false),
                tabs: modes.map((e) {
                  return Tab(
                    text: e,
                  );
                }).toList(),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _controller,
        children: [
          PublicForum(),
          HealthTipsView(),
        ],
      ),
    ));
  }
}

class HealthTipsView extends StatefulWidget {
  HealthTipsView({
    Key key,
  }) : super(key: key);

  @override
  _HealthTipsViewState createState() => _HealthTipsViewState();
}

class _HealthTipsViewState extends State<HealthTipsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PaginateFirestore(
      isLive: true,
      itemsPerPage: 2,
      itemBuilder: (context, snapshot, index) {
        TipModel tip = TipModel.fromSnapshot(
          snapshot[index],
        );

        return SingleHealthTip(
          tip: tip,
        );
      },
      onEmpty: NoDataFound(
        text: "No Questions Found",
      ),
      query: FirebaseFirestore.instance
          .collection(QuestionModel.DIRECTORY)
          .where(QuestionModel.QUESTION, isEqualTo: false)
          .orderBy(QuestionModel.DATEOFPOSTING),
      itemBuilderType: PaginateBuilderType.listView,
    );
  }
}

class PublicForum extends StatefulWidget {
  PublicForum({Key key}) : super(key: key);

  @override
  _PublicForumState createState() => _PublicForumState();
}

class _PublicForumState extends State<PublicForum>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: PaginateFirestore(
            isLive: true,
            itemsPerPage: 2,
            itemBuilder: (context, snapshot, index) {
              QuestionModel qn = QuestionModel.fromSnapshot(
                snapshot[index],
              );

              return SingleQuestion(
                questionID: qn.id,
                question: qn,
              );
            },
            onEmpty: NoDataFound(
              text: "No Health Tips Found",
            ),
            query: FirebaseFirestore.instance
                .collection(QuestionModel.DIRECTORY)
                .where(QuestionModel.QUESTION, isEqualTo: true)
                .where(QuestionModel.APPROVED, isEqualTo: true)
                .orderBy(QuestionModel.DATEOFPOSTING),
            itemBuilderType: PaginateBuilderType.listView,
          ),
        )
      ],
    );
  }
}
