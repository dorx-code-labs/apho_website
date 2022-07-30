import 'package:apho/services/ui_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants_used_in_the_ui.dart';
import '../constants/ui.dart';
import 'home_screen.dart';

class TeamView extends StatefulWidget {
  final Function(dynamic) onTapItem;
  TeamView({
    Key key,
    @required this.onTapItem,
  }) : super(key: key);

  @override
  State<TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

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
                  ],
                ),
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
              Column(
                children: team
                    .map(
                      (e) => SingleTeamMember(
                        team: e,
                      ),
                    )
                    .toList(),
              ),
              Footer(
                onTapItem: widget.onTapItem,
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SingleTeamMember extends StatefulWidget {
  final Team team;
  SingleTeamMember({
    Key key,
    @required this.team,
  }) : super(key: key);

  @override
  State<SingleTeamMember> createState() => _SingleTeamMemberState();
}

class _SingleTeamMemberState extends State<SingleTeamMember>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 6),
            ),
            child: Column(
              children: [
                Text(
                  widget.team.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.team.post,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(
                  widget.team.image,
                ),
              ),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.team.desc,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          if (widget.team.employmentHistory != null)
            SizedBox(
              height: 40,
            ),
          if (widget.team.employmentHistory != null)
            Text(
              "Present",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          if (widget.team.employmentHistory != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.team.employmentHistory.entries
                    .map(
                      (e) => Column(
                        children: [
                          Text(
                            "${e.value["year"]} - Present",
                          ),
                          Text(
                            e.key,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if (e.value["desc"] != null)
                            Text(
                              e.value["desc"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          Divider(
                            height: 40,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          if (widget.team.past != null)
            SizedBox(
              height: 40,
            ),
          if (widget.team.past != null)
            Text(
              "Past",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          if (widget.team.past != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.team.past.entries
                  .map(
                    (e) => Column(
                      children: [
                        Text(
                          e.key,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (e.value["location"] != null)
                          Text(
                            e.value["location"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        if (e.value["achievement"] != null)
                          Text(
                            "Proudest Achievement:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (e.value["achievement"] != null)
                          Text(
                            "${e.value["achievement"]}",
                          ),
                        Divider(
                          height: 40,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          SizedBox(
            height: 40,
          ),
          if (widget.team.skills != null)
            Text(
              "Skills",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          if (widget.team.skills != null)
            Wrap(
              children: widget.team.skills
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SkillLevel(
                        skillLevelWidth: MediaQuery.of(context).size.width * 0.8,
                        controller: _controller,
                        skill: e.skill,
                        level: e.level,
                      ),
                    ),
                  )
                  .toList(),
            ),
          Divider(
            height: 80,
          ),
        ],
      ),
    );
  }
}

class SkillLevel extends StatefulWidget {
  SkillLevel({
    Key key,
    @required this.skill,
    @required this.level,
    @required this.controller,
    this.skillStyle,
    this.levelStyle,
    this.skillLevelColor = primaryColor,
    this.baseColor = Colors.grey,
    this.skillLevelWidth = 100,
    this.baseThickness = 2.0,
    this.skillLevelThickness = 7.0,
    this.curve = Curves.fastOutSlowIn,
  }) : super(key: key);

  final String skill;
  final double level;
  final TextStyle skillStyle;
  final TextStyle levelStyle;
  final Color skillLevelColor;
  final Color baseColor;
  final double skillLevelWidth;
  final double baseThickness;
  final double skillLevelThickness;
  final AnimationController controller;
  final Curve curve;

  @override
  State<SkillLevel> createState() => _SkillLevelState();
}

class _SkillLevelState extends State<SkillLevel> {
  Animation<double> animation;

  @override
  void initState() {
    animation = Tween(begin: 0.0, end: widget.level).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: widget.curve,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: _buildChild(animation.value),
      builder: (context, _) {
        return _buildChild(animation.value);
      },
    );
  }

  Widget _buildChild(double level) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle defaultStyle = textTheme.subtitle2;
    return SizedBox(
      width: widget.skillLevelWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.skill,
                style: widget.skillStyle ?? defaultStyle,
              ),
              Text(
                "${level.toInt()} %",
                style: widget.levelStyle ?? defaultStyle,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Stack(
            children: [
              Container(
                height: widget.baseThickness,
                margin: EdgeInsets.only(
                  top: (widget.skillLevelThickness - widget.baseThickness) / 2,
                ),
                width: MediaQuery.of(context).size.width,
                color: widget.baseColor,
              ),
              Container(
                height: widget.skillLevelThickness,
                width: widget.skillLevelWidth * (level / 100),
                color: widget.skillLevelColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
