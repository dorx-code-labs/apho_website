import 'dart:io';

import 'package:apho/constants/constants_used_in_the_ui.dart';
import 'package:apho/constants/ui.dart';
import 'package:apho/models/service.dart';
import 'package:apho/theming/theme_controller.dart';
import 'package:apho/views/career_view.dart';
import 'package:apho/views/contact_us_view.dart';
import 'package:apho/views/health_tips.dart';
import 'package:apho/views/services_view.dart';
import 'package:apho/views/team_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants/core.dart';
import 'constants/images.dart';
import 'services/ui_services.dart';
import 'views/home_screen.dart';
import 'widgets/custom_divider.dart';
import 'widgets/nimbus_button.dart';
import 'widgets/responsive.dart';
import 'widgets/web_navigation_bar.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  /* PushNotification notification = PushNotification.fromData(
    title: message.notification?.title,
    body: message.notification?.body,
    attachedData: message.data,
  ); */
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final configurations = Configurations();

  await Firebase.initializeApp(
    name: "ApHO Website",
    options: FirebaseOptions(
      databaseURL: configurations.databaseUrl,
      apiKey: configurations.apiKey,
      appId: configurations.appId,
      messagingSenderId: configurations.senderID,
      projectId: configurations.projectId,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BookRouterDelegate _routerDelegate = BookRouterDelegate();
  BookRouteInformationParser _routeInformationParser =
      BookRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (context, brightness) {
        return MaterialApp.router(
          title: 'ApHO Digital Health Services',
          theme: ThemeData(
            scrollbarTheme: ScrollbarThemeData(
              radius: Radius.circular(borderDouble),
              thumbVisibility: MaterialStateProperty.all(true),
              interactive: true,
              thickness: MaterialStateProperty.all(10),
              thumbColor: MaterialStateProperty.all(
                primaryColor,
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            fontFamily: "Montserrat",
            brightness: brightness,
            primarySwatch: primaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routerDelegate: _routerDelegate,
          routeInformationParser: _routeInformationParser,
        );
      },
    );
  }
}

class BookRouteInformationParser extends RouteInformationParser<MyRoutePath> {
  static const SERVICES = "services";
  static const TEAMMEMBERS = "teamMembers";

  @override
  Future<MyRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    // Handle '/'
    if (uri.pathSegments.isEmpty) {
      return MyRoutePath.home();
    }

    if (uri.pathSegments[0] == MyRoutePath.FORUM) {
      return MyRoutePath.forum();
    }

    if (uri.pathSegments[0] == MyRoutePath.CONTACT) {
      return MyRoutePath.contact();
    }

    if (uri.pathSegments[0] == MyRoutePath.TEAM) {
      return MyRoutePath.teamView();
    }

    if (uri.pathSegments[0] == MyRoutePath.SERVICE) {
      return MyRoutePath.service();
    }

    if (uri.pathSegments.length == 2) {
      var remaining = uri.pathSegments[1];

      if (uri.pathSegments[0] == SERVICES) {
        ServiceModel sv;

        for (var element in services) {
          if (element.id == remaining) {
            sv = element;
          }
        }

        if (sv != null) {
          return MyRoutePath.serviceDetails(
            sv,
            remaining,
          );
        } else {
          return MyRoutePath.unknown();
        }
      } else {
        if (uri.pathSegments[0] == TEAMMEMBERS) {
          Team tt;
          for (var element in team) {
            if (element.id == remaining) {
              tt = element;
            }
          }

          if (tt != null) {
            return MyRoutePath.teamDetails(
              tt,
              remaining,
            );
          } else {
            return MyRoutePath.unknown();
          }
        } else {
          return MyRoutePath.unknown();
        }
      }
    }

    // Handle unknown routes
    return MyRoutePath.unknown();
  }

  @override
  // ignore: avoid_renaming_method_parameters
  RouteInformation restoreRouteInformation(MyRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }

    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }

    if (path.isServicePage) {
      return RouteInformation(location: '/$SERVICES/${path.id}');
    }

    if (path.isTeamDetails) {
      return RouteInformation(location: '/$TEAMMEMBERS/${path.id}');
    }

    if (path.isContactUs || path.isTeamPage || path.isForumPage) {
      return RouteInformation(location: '/${path.type}');
    }

    return null;
  }
}

class BookRouterDelegate extends RouterDelegate<MyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  String mode;
  String id;
  dynamic data;

  bool show404 = false;

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  MyRoutePath get currentConfiguration {
    if (show404) {
      return MyRoutePath.unknown();
    }

    if (mode == MyRoutePath.FORUM) {
      return MyRoutePath.forum();
    }

    if (mode == MyRoutePath.HOME) {
      return MyRoutePath.home();
    }

    if (mode == MyRoutePath.CAREER) {
      return MyRoutePath.career();
    }

    if (mode == MyRoutePath.CONTACT) {
      return MyRoutePath.contact();
    }

    if (mode == MyRoutePath.SERVICE) {
      return MyRoutePath.service();
    }

    if (mode == MyRoutePath.SERVICEDETAILS) {
      return MyRoutePath.serviceDetails(data, id);
    }

    if (mode == MyRoutePath.TEAM) {
      return MyRoutePath.teamView();
    }

    if (mode == MyRoutePath.TEAMDETAILS) {
      return MyRoutePath.teamDetails(data, id);
    }

    return MyRoutePath.home();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (mode == MyRoutePath.HOME || mode == null)
          MaterialPage(
            key: ValueKey(MyRoutePath.HOME),
            child: MyScaffold(
              mode: mode,
              onTapped: _handleBookTapped,
              child: HomeScreen(
                onTapItem: _handleBookTapped,
              ),
            ),
          ),
        if (show404)
          MaterialPage(
            key: ValueKey('UnknownPage'),
            child: UnknownScreen(),
          ),
        if (mode == MyRoutePath.FORUM)
          MaterialPage(
            key: ValueKey(MyRoutePath.FORUM),
            child: MyScaffold(
              mode: mode,
              onTapped: _handleBookTapped,
              child: ForumPage(
                onTapItem: _handleBookTapped,
              ),
            ),
          ),
        if (mode == MyRoutePath.CONTACT)
          MaterialPage(
            key: ValueKey(MyRoutePath.CONTACT),
            child: MyScaffold(
              mode: mode,
              onTapped: _handleBookTapped,
              child: ContactUsView(
                onTapItem: _handleBookTapped,
              ),
            ),
          ),
        if (mode == MyRoutePath.SERVICE)
          MaterialPage(
            key: ValueKey(MyRoutePath.SERVICE),
            child: MyScaffold(
              mode: mode,
              onTapped: _handleBookTapped,
              child: ServicesView(
                onTapItem: _handleBookTapped,
              ),
            ),
          ),
        if (mode == MyRoutePath.TEAM)
          MaterialPage(
            key: ValueKey(MyRoutePath.CONTACT),
            child: MyScaffold(
              mode: mode,
              onTapped: _handleBookTapped,
              child: TeamView(
                onTapItem: _handleBookTapped,
              ),
            ),
          ),
        if (mode == MyRoutePath.CAREER)
          MaterialPage(
            key: ValueKey(MyRoutePath.CAREER),
            child: MyScaffold(
              mode: mode,
              onTapped: _handleBookTapped,
              child: CareersView(
                onTapItem: _handleBookTapped,
              ),
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        data = null;
        mode = null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> setNewRoutePath(MyRoutePath path) async {
    if (path.isUnknown) {
      show404 = true;
      return;
    }

    if (path.isContactUs) {
      mode = MyRoutePath.CONTACT;
    }

    if (path.isCareer) {
      mode = MyRoutePath.CAREER;
    }

    if (path.isTeamPage) {
      mode = MyRoutePath.TEAM;
    }

    if (path.isServicePage) {
      mode = MyRoutePath.SERVICE;
    }

    if (path.isForumPage) {
      mode = MyRoutePath.FORUM;
    }

    if (path.isHomePage) {
      mode = MyRoutePath.HOME;
    }

    if (path.isServiceDetails) {
      ServiceModel sv;

      for (var element in services) {
        if (element.id == path.id) {
          sv = element;
        }
      }

      if (sv != null) {
        mode = MyRoutePath.SERVICEDETAILS;
        data = sv;
      } else {
        show404 = true;
        return;
      }
    }

    if (path.isTeamDetails) {
      Team sv;

      for (var element in team) {
        if (element.id == path.id) {
          sv = element;
        }
      }

      if (sv != null) {
        mode = MyRoutePath.TEAMDETAILS;
        data = sv;
      } else {
        show404 = true;
        return;
      }
    }

    show404 = false;
  }

  void _handleBookTapped(dynamic mm) {
    mode = mm["page"];
    id = mm["id"];
    notifyListeners();
  }
}

class MyRoutePath {
  final dynamic data;
  final String type;
  final String id;
  final bool isUnknown;

  static const FORUM = "forum";
  static const HOME = "home";
  static const TEAM = "team";
  static const TEAMDETAILS = "teamDetails";
  static const SERVICE = "service";
  static const CONTACT = "contact";
  static const SERVICEDETAILS = "serviceDetails";
  static const CAREER = "career";

  MyRoutePath.home()
      : data = null,
        id = null,
        type = HOME,
        isUnknown = false;

  MyRoutePath.serviceDetails(
    this.data,
    this.id,
  )   : isUnknown = false,
        type = SERVICEDETAILS;

  MyRoutePath.career()
      : isUnknown = false,
        data = null,
        id = null,
        type = CAREER;

  MyRoutePath.service()
      : isUnknown = false,
        data = null,
        id = null,
        type = SERVICE;

  MyRoutePath.teamDetails(
    this.data,
    this.id,
  )   : isUnknown = false,
        type = TEAMDETAILS;

  MyRoutePath.teamView()
      : data = null,
        type = TEAM,
        id = null,
        isUnknown = false;

  MyRoutePath.forum()
      : data = null,
        type = FORUM,
        id = null,
        isUnknown = false;

  MyRoutePath.contact()
      : data = null,
        type = CONTACT,
        id = null,
        isUnknown = false;

  MyRoutePath.unknown()
      : data = null,
        id = null,
        type = null,
        isUnknown = true;

  bool get isHomePage => type == HOME;
  bool get isServicePage => type == SERVICE;
  bool get isTeamPage => type == TEAM;
  bool get isForumPage => type == FORUM;
  bool get isCareer => type == CAREER;
  bool get isServiceDetails => type == SERVICEDETAILS;
  bool get isTeamDetails => type == TEAMDETAILS;
  bool get isContactUs => type == CONTACT;
}

class MyScaffold extends StatefulWidget {
  final Widget child;
  final String mode;
  final ValueChanged<Map> onTapped;
  const MyScaffold({
    Key key,
    @required this.child,
    @required this.mode,
    @required this.onTapped,
  }) : super(key: key);

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        hoverColor: primaryColor,
        hoverElevation: standardElevation,
        onPressed: () async {
          var whatsapp = "+256755572967";

          var whatsappUrlAndroid =
              "whatsapp://send?phone=" + whatsapp + "&text=hello";
          var whatappUrlIos =
              "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

          if (Platform.isIOS) {
            // for iOS phone only

            await launchUrl(
              Uri.parse(whatappUrlIos),
            );
          } else {
            // android , web

            await launchUrl(
              Uri.parse(whatsappUrlAndroid),
            );
          }
        },
        icon: Icon(
          FontAwesomeIcons.whatsapp,
        ),
        label: Text(
          "Chat with us",
        ),
      ),
      appBar: Responsive.isMobile(context)
          ? AppBar(
              backgroundColor: Theme.of(context).canvasColor,
              iconTheme: IconThemeData(
                color: Colors.grey,
              ),
              centerTitle: false,
              title: Image.asset(
                logo,
                height: 50,
              ),
            )
          : null,
      body: Column(
        children: [
          Responsive(
            desktop: WebNavigationBar(
              goHome: () {
                widget.onTapped({
                  "page": MyRoutePath.HOME,
                });
              },
              switchToIndex: (b) {
                widget.onTapped({
                  "page": b,
                });
              },
              mode: widget.mode,
            ),
            tablet: WebNavigationBar(
              goHome: () {
                widget.onTapped({
                  "page": MyRoutePath.HOME,
                });
              },
              switchToIndex: (b) {
                widget.onTapped({
                  "page": b,
                });
              },
              mode: widget.mode,
            ),
            mobile: SizedBox(),
          ),
          Expanded(
            child: widget.child,
          )
        ],
      ),
      endDrawer: Responsive.isMobile(context)
          ? Drawer(
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 25,
                  horizontal: 10,
                ),
                color: Theme.of(context).canvasColor,
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.close,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Image.asset(
                                  logo,
                                  height: 60,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              singleDrawerItem(
                                label: "Home",
                                onTap: () {
                                  widget.onTapped({
                                    "page": MyRoutePath.HOME,
                                  });
                                },
                              ),
                              singleDrawerItem(
                                otherPages: services,
                                label: "Services",
                                onTap: () {
                                  widget.onTapped({
                                    "page": MyRoutePath.SERVICE,
                                  });
                                },
                              ),
                              singleDrawerItem(
                                label: "Health",
                                onTap: () {
                                  widget.onTapped({
                                    "page": MyRoutePath.FORUM,
                                  });
                                },
                              ),
                              singleDrawerItem(
                                label: "Team",
                                onTap: () {
                                  widget.onTapped({
                                    "page": MyRoutePath.TEAM,
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              NimbusButton(
                                width: double.infinity,
                                buttonTitle: "Contact",
                                onPressed: () {
                                  Navigator.of(context).pop();

                                  widget.onTapped({
                                    "page": MyRoutePath.HOME,
                                  });
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              NimbusButton(
                                width: double.infinity,
                                buttonTitle: "Get The App",
                                onPressed: () {
                                  Navigator.of(context).pop();

                                  UIServices().showDatSheet(
                                    AppOptionsBottomSheet(),
                                    true,
                                    context,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }

  singleDrawerItem({
    @required String label,
    String image,
    @required Function onTap,
    List otherPages,
  }) {
    return otherPages != null && otherPages.isNotEmpty
        ? FocusedMenuHolder(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                CustomDivider()
              ],
            ),
            onPressed: () {},
            openWithTap: true,
            menuItems: otherPages
                .map(
                  (e) => FocusedMenuItem(
                    backgroundColor: e.color,
                    title: Text(
                      e.name,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();

                      onTap();
                    },
                  ),
                )
                .toList(),
          )
        : InkWell(
            onTap: () {
              // NavigationService().pop();

              onTap();
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                CustomDivider()
              ],
            ),
          );
  }
}

class UnknownScreen extends StatefulWidget {
  const UnknownScreen({Key key}) : super(key: key);

  @override
  State<UnknownScreen> createState() => _UnknownScreenState();
}

class _UnknownScreenState extends State<UnknownScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;

  final RelativeRectTween _relativeRectTween = RelativeRectTween(
    begin: RelativeRect.fromLTRB(24, 24, 24, 200),
    end: RelativeRect.fromLTRB(24, 24, 24, 250),
  );

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xffd8f3dc),
      body: Stack(
        children: [
          PositionedTransition(
            rect: _relativeRectTween.animate(_controller),
            child: Image.asset(
              logo,
              height: 300,
            ),
          ),
          Positioned(
            top: 150,
            bottom: 0,
            left: 24,
            right: 24,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  '404',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50,
                      letterSpacing: 2,
                      color: Color(0xff2f3640),
                      fontFamily: 'Anton',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Sorry, we couldn\'t find the page!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xff2f3640),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
