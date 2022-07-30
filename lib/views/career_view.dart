import 'package:apho/models/career_item.dart';
import 'package:apho/views/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import 'no_data_found_view.dart';

class CareersView extends StatefulWidget {
  final Function(dynamic) onTapItem;
  CareersView({
    Key key,
    @required this.onTapItem,
  }) : super(key: key);

  @override
  State<CareersView> createState() => _CareersViewState();
}

class _CareersViewState extends State<CareersView> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Scrollbar(
            controller: controller,
            child: PaginateFirestore(
              scrollController: controller,
              isLive: true,
              itemsPerPage: 2,
              itemBuilder: (context, snapshot, index) {
                CareerModel qn = CareerModel.fromSnapshot(
                  snapshot[index],
                );

                return SingleCareerItem(
                  model: qn,
                );
              },
              onEmpty: NoDataFound(
                text: "Sorry. There's no Job Openings at the moment.",
              ),
              query: FirebaseFirestore.instance
                  .collection(CareerModel.DIRECTORY)
                  .orderBy(CareerModel.DATE),
              itemBuilderType: PaginateBuilderType.listView,
            ),
          ),
        ),
        Footer(
          onTapItem: widget.onTapItem,
        )
      ],
    );
  }
}

class SingleCareerItem extends StatefulWidget {
  final CareerModel model;
  SingleCareerItem({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  State<SingleCareerItem> createState() => _SingleCareerItemState();
}

class _SingleCareerItemState extends State<SingleCareerItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
