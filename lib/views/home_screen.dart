import 'package:apho/constants/basic.dart';
import 'package:apho/constants/core.dart';
import 'package:apho/constants/images.dart';
import 'package:apho/constants/ui.dart';
import 'package:apho/main.dart';
import 'package:apho/models/service.dart';
import 'package:apho/services/firebase_service.dart';
import 'package:apho/services/text_service.dart';
import 'package:apho/widgets/auto_scroll_showcaser.dart';
import 'package:apho/widgets/custom_divider.dart';
import 'package:apho/widgets/informational_box.dart';
import 'package:apho/widgets/responsive.dart';
import 'package:apho/widgets/single_image.dart';
import 'package:apho/widgets/single_select_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants_used_in_the_ui.dart';
import '../services/ui_services.dart';
import '../widgets/bottom_sheet_back_bar.dart';
import '../widgets/nimbus_button.dart';

class HomeScreen extends StatefulWidget {
  final Function(dynamic) onTapItem;
  HomeScreen({
    Key key,
    @required this.onTapItem,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scrollbar(
      controller: controller,
      child: CustomScrollView(
        controller: controller,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "ApHO Digital Health Solutions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "ApHO provides you a set of apps that enable you to receive life changing health services all from the confort of your home and-or office.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              appLinkToPlaystore,
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          googleSVG,
                          width: 200,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      singleRowIconThing(
                        "Hundreds of health workers at your disposal.",
                        Icons.health_and_safety,
                      ),
                      singleRowIconThing(
                        "Panic Button for those times you need emergency health care.",
                        Icons.emergency,
                      ),
                      singleRowIconThing(
                        "Health at your doorstep.",
                        Icons.home,
                      ),
                      singleRowIconThing(
                        "Maternity section for new mothers.",
                        Icons.female,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 550,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: -80,
                              left: 0,
                              right: 0,
                              child: Image.asset(
                                phoneScreenshot,
                                height: 600,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AutoScrollShowcaser(
                        showIndicator: false,
                        darken: true,
                        height: double.infinity,
                        images: [
                          yogaBalance,
                          healthTips,
                        ],
                        placeholderText: capitalizedAppName,
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                          25,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ApHO Digital Health Solutions",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              "Changing the way you receive healthcare",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Permit us to redefine health for you with our revolutionary services and apps that bring a whole new world of health closer to you",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                  wordSpacing: 1.5),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            NimbusButton(
                              onPressed: () {
                                UIServices().showDatSheet(
                                  AppOptionsBottomSheet(),
                                  true,
                                  context,
                                );
                              },
                              buttonTitle: "Get Started",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.8,
                ),
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "It's what we do",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "We utilize technology to connect families and communities to health care and social services in the comfort of their home",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Column(
                  children: apps
                      .map<Widget>(
                        (e) => singleProject(e),
                      )
                      .toList(),
                ),
                SizedBox(
                  height: 80,
                ),
                Column(
                  children: [
                    Text(
                      "Testimonials",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Don't just take our word for it",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    AutoScrollShowcaser(
                      vpFraction: 0.8,
                      showIndicator: false,
                      onPageChange: (b) {
                        setState(() {
                          _currentIndex = b;
                        });
                      },
                      animDuration: Duration(milliseconds: 200),
                      height: MediaQuery.of(context).size.height * 0.6,
                      images: testimonies
                          .map<Widget>(
                            (e) => Container(
                              padding: EdgeInsets.all(5),
                              child: Material(
                                borderRadius: standardBorderRadius,
                                elevation: standardElevation,
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        e.text,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        e.projectName,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${e.commenter != null ? "${e.commenter} | " : ""}${e.post != null ? "${e.post} | " : ""}${e.company != null ? "${e.company} | " : ""}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      placeholderText: "ApHO",
                      widget: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: testimonies.map((e) {
                        bool selected = _currentIndex == testimonies.indexOf(e);

                        return Container(
                          decoration: BoxDecoration(
                            color: selected
                                ? primaryColor
                                : primaryColor.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 2,
                            vertical: 4,
                          ),
                          width: selected ? 15 : 8,
                          height: selected ? 15 : 8,
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      color: primaryColor.withOpacity(
                        0.5,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 100,
                        horizontal: 20,
                      ),
                      child: Column(children: [
                        Text(
                          "HOW WE DO IT",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "We are using technology to bring health closer to you and your family.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverGrid(
            delegate: SliverChildListDelegate(
              services
                  .map<Widget>(
                    (e) => GestureDetector(
                      onTap: () {
                        widget.onTapItem(
                          {
                            "page": MyRoutePath.SERVICEDETAILS,
                            "id": e.id,
                          },
                        );
                      },
                      child: SingleHomeScreenServiceCard(
                        service: e,
                      ),
                    ),
                  )
                  .toList(),
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300.0,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    image: UIServices().decorationImage(
                      acrylic,
                      true,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                          phoneScreenshot,
                        ),
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.5),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Text(
                        "All in one sleek beautiful package",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "3 Easy Steps",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      tileThing(
                        count: 1,
                        title: "Install The App",
                        desc: "Or you can use the web app. We have that too.",
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      tileThing(
                        title: "Find what you need",
                        desc:
                            "There's a lot to chose from. It's okay to be overwhelmed.",
                        count: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      tileThing(
                        title: "Set An Appointment",
                        desc:
                            "Set an appointment with one of our professional health providers and await to be served.",
                        count: 3,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: UIServices().decorationImage(
                      familyNurse,
                      true,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "ARE YOU A DOCTOR?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '''ApHO Digital Health Solutions is available to all healthcare providers including practitioners, specialists, therapists, counsellors, and more.

Need more information about doctors on ApHO Digital Health Solutions? Contact our doctor liaison team on\n\n$aphoPhoneNumber\n
If you are interested in providing healthcare services, click the join us button below!''',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      NimbusButton(
                        buttonColor: Colors.white,
                        titleColor: primaryColor,
                        onPressed: () {
                          launchUrl(
                            Uri.parse("tel:$aphoPhoneNumber"),
                          );
                        },
                        buttonTitle: "Join Us",
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Footer(
                  onTapItem: widget.onTapItem,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget singleRowIconThing(
    String text,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 3,
      ),
      child: Row(
        mainAxisAlignment: Responsive.isMobile(context)
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: primaryColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }

  singleProject(ProjectModel model) {
    return Responsive(
      desktop: projectRow(model),
      tablet: projectRow(model),
      mobile: Column(
        children: [
          breakthroughApLaunch(model),
          breakthroughAppImage(model),
        ],
      ),
    );
  }

  projectRow(ProjectModel e) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Row(
        children: e.left
            ? [
                Expanded(
                  child: breakthroughAppImage(e),
                ),
                Expanded(
                  child: breakthroughApLaunch(e),
                ),
              ]
            : [
                Expanded(
                  child: breakthroughApLaunch(e),
                ),
                Expanded(
                  child: breakthroughAppImage(e),
                ),
              ],
      ),
    );
  }

  Widget breakthroughAppImage(ProjectModel e) {
    return Container(
      decoration: BoxDecoration(
        color: e.color.withOpacity(0.6),
      ),
      height: Responsive.isMobile(context)
          ? MediaQuery.of(context).size.height * 0.7
          : double.infinity,
      width: double.infinity,
      child: Image(
        image: AssetImage(
          e.coverImage,
        ),
      ),
    );
  }

  Widget breakthroughApLaunch(ProjectModel e) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 45,
      ),
      color: e.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            logo,
            height: 60,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            e.title,
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            e.desc,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          NimbusButton(
            buttonTitle: "Get The App",
            onPressed: () {
              UIServices().showDatSheet(
                AppOptionsBottomSheet(),
                true,
                context,
              );
            },
          ),
        ],
      ),
    );
  }

  tileThing({
    @required String title,
    @required String desc,
    @required int count,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              color: primaryColor,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  desc,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SingleHomeScreenServiceCard extends StatefulWidget {
  final ServiceModel service;
  SingleHomeScreenServiceCard({
    Key key,
    @required this.service,
  }) : super(key: key);

  @override
  State<SingleHomeScreenServiceCard> createState() =>
      _SingleHomeScreenServiceCardState();
}

class _SingleHomeScreenServiceCardState
    extends State<SingleHomeScreenServiceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Material(
        borderRadius: standardBorderRadius,
        elevation: standardElevation,
        child: Container(
          decoration: BoxDecoration(
            image: UIServices().decorationImage(
              widget.service.image,
              true,
            ),
            borderRadius: standardBorderRadius,
            color: Theme.of(context).canvasColor,
          ),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: widget.service.color.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.service.icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.service.name,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Footer extends StatefulWidget {
  final Function(dynamic) onTapItem;
  const Footer({
    Key key,
    @required this.onTapItem,
  }) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: darkerBlue,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Responsive(
              tablet:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: firstColumn(
                    false,
                  ),
                ),
                Expanded(
                  child: secondColumn(
                    false,
                  ),
                ),
                Expanded(
                  child: thirdColumn(
                    false,
                  ),
                ),
              ]),
              desktop:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: firstColumn(
                    false,
                  ),
                ),
                Expanded(
                  child: secondColumn(
                    false,
                  ),
                ),
                Expanded(
                  child: thirdColumn(
                    false,
                  ),
                ),
              ]),
              mobile: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  firstColumn(
                    true,
                  ),
                  secondColumn(
                    true,
                  ),
                  thirdColumn(
                    true,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomDivider(),
            SizedBox(
              height: 20,
            ),
            titleText(
              "The ApHO Mission: To Create a digital health environment of providing comprehensive, affordable and cost efficient health services to people globally in their location",
            ),
            SizedBox(
              height: 40,
            ),
            titleText(
              "The ApHO Vision: To be the most caring and quick health service providers reaching many people around the world in their different locations.",
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            CustomDivider(),
            SizedBox(
              height: 20,
            ),
            titleText(
              "ApHO Digital Health Solutions",
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                launchUrl(
                  Uri.parse("https://reactug.org/terms-and-conditions/"),
                );
              },
              child: titleText(
                "Terms of Service",
              ),
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                launchUrl(
                  Uri.parse("https://reactug.org/privacy-policy/"),
                );
              },
              child: titleText(
                "Privacy Policy",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      StorageServices().launchSocialLink(
                        aphoTwitter,
                        TWITTERURLLEAD,
                      );
                    },
                    child: CircleAvatar(
                      child: Icon(
                        FontAwesomeIcons.twitter,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      StorageServices().launchSocialLink(
                        aphoFacebook,
                        FACEBOOKURLLEAD,
                      );
                    },
                    child: CircleAvatar(
                      child: Icon(
                        FontAwesomeIcons.facebook,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      launchUrl(
                        Uri.parse("tel:$aphoPhoneNumber"),
                      );
                    },
                    child: CircleAvatar(
                      child: Icon(
                        FontAwesomeIcons.phone,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget firstColumn(bool center) {
    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        SingleImage(
          image: logo,
          height: 60,
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            launchUrl(
              Uri.parse(
                "mailto:<$contactEmail>?subject=&body=",
              ),
            );
          },
          child: titleText(
            "email",
          ),
        ),
        Text(
          contactEmail,
          style: TextStyle(
            fontSize: 22,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget titleText(String text) {
    return Text(
      text.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget footerItemText(String text) {
    return Text(
      text.capitalizeFirstOfEach,
      textAlign:
          Responsive.isMobile(context) ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget secondColumn(bool center) {
    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        titleText(
          "services",
        ),
      ]
          .followedBy(
        services
            .map<Widget>(
              (e) => GestureDetector(
                onTap: () {
                  widget.onTapItem({
                    "page": MyRoutePath.SERVICE,
                    "id": e.id,
                  });
                },
                child: footerItemText(
                  e.name,
                ),
              ),
            )
            .toList(),
      )
          .followedBy(
        [
          SizedBox(
            height: 20,
          ),
          titleText(
            "apps",
          ),
          GestureDetector(
            onTap: () {
              UIServices().showDatSheet(
                AppOptionsBottomSheet(),
                true,
                context,
              );
            },
            child: footerItemText(
              "ApHO",
            ),
          ),
          GestureDetector(
            onTap: () {
              UIServices().showDatSheet(
                AppOptionsBottomSheet(),
                true,
                context,
              );
            },
            child: footerItemText(
              "ApHO Provider",
            ),
          ),
        ],
      ).toList(),
    );
  }

  Widget thirdColumn(
    bool center,
  ) {
    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        titleText(
          "Company",
        ),
        GestureDetector(
          onTap: () {
            widget.onTapItem(
              {
                "page": MyRoutePath.TEAM,
              },
            );
          },
          child: footerItemText(
            "Team",
          ),
        ),
        GestureDetector(
          onTap: () {
            widget.onTapItem(
              {
                "page": MyRoutePath.CONTACT,
              },
            );
          },
          child: footerItemText(
            "Contact Us",
          ),
        ),
        /*  GestureDetector(
          onTap: () {
          UIServices().showDatSheet(
            
            , willThisThingNeedScrolling, context)
          },
          child: footerItemText(
            "Careers",
          ),
        ), */
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            launchUrl(
              Uri.parse(
                "tel:$aphoPhoneNumber",
              ),
            );
          },
          child: footerItemText(
            aphoPhoneNumber,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        footerItemText(
          "Plot 13, Old Kira Road\nKamwookya\nKampala, Uganda",
        ),
      ],
    );
  }
}

class AppOptionsBottomSheet extends StatefulWidget {
  AppOptionsBottomSheet({Key key}) : super(key: key);

  @override
  State<AppOptionsBottomSheet> createState() => _AppOptionsBottomSheetState();
}

class _AppOptionsBottomSheetState extends State<AppOptionsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackBar(
          icon: null,
          onPressed: null,
          text: "Please select an option",
        ),
        InformationalBox(
          visible: true,
          onClose: null,
          message:
              "ApHO offers you world class health services all in the confort of your home. Please select which option here best defines you",
        ),
        SingleSelectTile(
          onTap: () {
            Navigator.of(context).pop();

            UIServices().showDatSheet(
              RealAppOptions(
                client: true,
              ),
              true,
              context,
            );
          },
          selected: false,
          icon: Icons.sick,
          asset: null,
          text: "I'm looking for quality healthcare",
        ),
        SingleSelectTile(
          onTap: () {
            Navigator.of(context).pop();

            UIServices().showDatSheet(
              RealAppOptions(
                client: false,
              ),
              true,
              context,
            );
          },
          selected: false,
          asset: null,
          text: "I'm a health care provider, seeking to work on ApHO.",
          icon: Icons.health_and_safety,
        ),
        SingleSelectTile(
          onTap: () {
            Navigator.of(context).pop();

            launchUrl(
              Uri.parse(
                "tel:$aphoPhoneNumber",
              ),
            );
          },
          selected: false,
          asset: null,
          text: "I'm neither of the above. But I'd like to partner with ApHO.",
          icon: Icons.link,
        ),
      ],
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton({
    Key key,
    this.textTitle,
    this.onTap,
    this.color,
  }) : super(key: key);

  final Color color;
  final String textTitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: MaterialButton(
        height: size.height * 0.09,
        minWidth: size.width * 0.15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
        ),
        onPressed: () {
          if (onTap != null) {
            onTap();
          }
        },
        color: color,
        child: Text(
          textTitle.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}

class RealAppOptions extends StatefulWidget {
  final bool client;
  RealAppOptions({
    Key key,
    @required this.client,
  }) : super(key: key);

  @override
  State<RealAppOptions> createState() => _RealAppOptionsState();
}

class _RealAppOptionsState extends State<RealAppOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackBar(
          icon: null,
          onPressed: null,
          text: "Please select an option.",
        ),
        SingleSelectTile(
          onTap: () {
            Navigator.of(context).pop();

            launchUrl(
              Uri.parse(
                widget.client ? appLinkToPlaystore : appLinkToServiceProvider,
              ),
            );
          },
          selected: false,
          icon: FontAwesomeIcons.googlePlay,
          asset: null,
          desc:
              "Tap here to go to the google playstore account for the Application for Health Online.",
          text: "Get App from Playstore",
        ),
        SingleSelectTile(
          iconColor: primaryColor,
          onTap: () {
            Navigator.of(context).pop();

            launchUrl(
              Uri.parse(
                widget.client
                    ? linkToAphOWebApp
                    : linkToAphoServiceProviderWebApp,
              ),
            );
          },
          selected: false,
          desc:
              "Incase you don't have a smart phone, or you lack storage on your phone.",
          asset: null,
          text: "Use the Web App",
          icon: Icons.http,
        ),
      ],
    );
  }
}
