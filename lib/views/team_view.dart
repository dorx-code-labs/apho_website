import 'package:apho/services/ui_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants_used_in_the_ui.dart';
import '../constants/images.dart';
import '../constants/ui.dart';
import '../widgets/single_image.dart';
import 'home_screen.dart';

class TeamView extends StatefulWidget {
  final bool pushed;
  TeamView({
    Key key,
    this.pushed = false,
  }) : super(key: key);

  @override
  State<TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.pushed
        ? Scaffold(
            body: SafeArea(
              child: body(),
            ),
          )
        : body();
  }

  Widget body() {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "OUR TEAM",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "ApHO brings together experienced product teams who understand product-led growth, enabling our clients to get to market faster and scale their businesses.",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SingleImage(
                image: familyNurse,
                height: 300,
                width: double.infinity,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
        SliverGrid(
          delegate: SliverChildListDelegate(
            team
                .map<Widget>(
                  (e) => Container(
                    margin: EdgeInsets.all(5),
                    child: Material(
                      borderRadius: standardBorderRadius,
                      elevation: standardElevation,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: standardBorderRadius,
                          color: e.color.withOpacity(0.2),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: UIServices().decorationImage(
                                    e.image,
                                    false,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    e.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    e.post,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (e.phone != null)
                                        GestureDetector(
                                          onTap: () {
                                            launchUrl(
                                              Uri.parse("tel:${e.phone}"),
                                            );
                                          },
                                          child: CircleAvatar(
                                            child: Icon(
                                              Icons.phone,
                                            ),
                                          ),
                                        ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      if (e.linkedIn != null)
                                        GestureDetector(
                                          onTap: () {
                                            launchUrl(
                                              Uri.parse("tel:${e.linkedIn}"),
                                            );
                                          },
                                          child: CircleAvatar(
                                            child: Icon(
                                              FontAwesomeIcons.linkedin,
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400.0,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(
                height: 20,
              ),
              Footer(),
            ],
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
