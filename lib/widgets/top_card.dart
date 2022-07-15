import 'package:apho/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopCard extends StatelessWidget {
  final dynamic tip;
  final bool qn;
  TopCard({
    Key key,
    @required this.tip,
    this.qn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(tip.time);
    String dateNumba = DateFormat("dd").format(date);
    String dateMonth = DateFormat("MMM").format(date);
    String dateYear = DateFormat("yyyy").format(date);
    String dateHours = DateFormat("HH").format(date);
    String dateMinutes = DateFormat("mm").format(date);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 6, right: 6),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 22,
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.white,
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.all(2),
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
                child: Container(
                  //  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage(
                         logo,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            qn != null && qn
                                ? "ApHO Public Forum"
                                : "ApHO Health Tip",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                              "$dateNumba, $dateMonth $dateYear at $dateHours:$dateMinutes")
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
