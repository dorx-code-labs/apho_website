import 'package:apho/constants/constants_used_in_the_ui.dart';
import 'package:apho/constants/ui.dart';
import 'package:apho/models/service.dart';
import 'package:apho/theming/theme_controller.dart';
import 'package:apho/views/contact_us_view.dart';
import 'package:apho/views/health_tips.dart';
import 'package:apho/views/team_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'constants/core.dart';
import 'constants/images.dart';
import 'services/navigation/navigation.dart';
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
/* 
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
 */
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
      print("-----------------the segments are home---------------");
      return MyRoutePath.home();
    }

    if (uri.pathSegments[0] == MyRoutePath.FORUM) {
      print("-----------------the segments are forum---------------");
      return MyRoutePath.forum();
    }

    if (uri.pathSegments[0] == MyRoutePath.CONTACT) {
      print("-----------------the segments are contact---------------");
      return MyRoutePath.contact();
    }

    if (uri.pathSegments[0] == MyRoutePath.TEAM) {
      print("-----------------the segments are team---------------");
      return MyRoutePath.teamView();
    }

    if (uri.pathSegments.length == 2) {
      print("-----------------the segments are multiple---------------");
      var remaining = uri.pathSegments[1];

      if (uri.pathSegments[0] == SERVICES) {
        ServiceModel sv;

        for (var element in services) {
          if (element.id == remaining) {
            sv = element;
          }
        }

        if (sv != null) {
          return MyRoutePath.service(
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
    print("-----------------the segments are unknown---------------");
    return MyRoutePath.unknown();
  }

  @override
  // ignore: avoid_renaming_method_parameters
  RouteInformation restoreRouteInformation(MyRoutePath path) {
    if (path.isUnknown) {
      print("-----------------its a 404---------------");
      return RouteInformation(location: '/404');
    }

    if (path.isHomePage) {
      print("-----------------its home---------------");
      return RouteInformation(location: '/');
    }

    if (path.isServicePage) {
      return RouteInformation(location: '/$SERVICES/${path.id}');
    }

    if (path.isTeamDetails) {
      return RouteInformation(location: '/$TEAMMEMBERS/${path.id}');
    }

    if (path.isContactUs || path.isTeamPage || path.isForumPage) {
      print("-----------------its ${path.type}---------------");
      return RouteInformation(location: '/${path.type}');
    }

    print("-----------------its some unknown shit ${path.type}---------------");
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
      print("unknown config");
      return MyRoutePath.unknown();
    }

    if (mode == MyRoutePath.FORUM) {
      print("forum config");
      return MyRoutePath.forum();
    }

    if (mode == MyRoutePath.CONTACT) {
      print("contact config");
      return MyRoutePath.contact();
    }

    if (mode == MyRoutePath.SERVICE) {
      print("service config");
      return MyRoutePath.service(data, id);
    }

    if (mode == MyRoutePath.TEAM) {
      print("team config");
      return MyRoutePath.teamView();
    }

    if (mode == MyRoutePath.TEAMDETAILS) {
      print("team deets config");
      return MyRoutePath.teamDetails(data, id);
    }

    print("home config");
    return MyRoutePath.home();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey(MyRoutePath.HOME),
          child: MyScaffold(
            onTapped: _handleBookTapped,
            child: HomeScreen(),
          ),
        ),
        if (show404)
          MaterialPage(
            key: ValueKey('UnknownPage'),
            child: UnknownScreen(),
          )
        else if (mode == MyRoutePath.FORUM)
          DefaultScaffold(
            child: ForumPage(),
            onTapped: _handleBookTapped,
          )
        else if (mode == MyRoutePath.CONTACT)
          DefaultScaffold(
            onTapped: _handleBookTapped,
            child: ContactUsView(
              pushed: false,
            ),
          )
        else if (mode == MyRoutePath.SERVICE)
          DefaultScaffold(
            onTapped: _handleBookTapped,
            child: Container(),
          )
        else if (mode == MyRoutePath.TEAM)
          DefaultScaffold(
            onTapped: _handleBookTapped,
            child: TeamView(),
          )
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
    print("here's the path type: ${path.type}");
    print("here's the path id: ${path.id}");
    print("here's path isContact: ${path.isContactUs}");

    if (path.isUnknown) {
      show404 = true;
      return;
    }

    if (path.isContactUs) {
      print("making mode to be contact");
      mode = MyRoutePath.CONTACT;
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

    if (path.isServicePage) {
      ServiceModel sv;

      for (var element in services) {
        if (element.id == path.id) {
          sv = element;
        }
      }

      if (sv != null) {
        mode = MyRoutePath.SERVICE;
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
    print("done reconfigging and this is mode: $mode");
  }

  void _handleBookTapped(String mm) {
    print(mm.toString());
    mode = mm;
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

  MyRoutePath.home()
      : data = null,
        id = null,
        type = HOME,
        isUnknown = false;

  MyRoutePath.service(
    this.data,
    this.id,
  )   : isUnknown = false,
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
  bool get isTeamDetails => type == TEAMDETAILS;
  bool get isContactUs => type == CONTACT;
}

class DefaultScaffold extends Page {
  final ValueChanged<String> onTapped;
  final Widget child;

  const DefaultScaffold({
    Key key,
    @required this.onTapped,
    @required this.child,
  }) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return MyScaffold(
          child: child,
          onTapped: onTapped,
        );
      },
    );
  }
}

class MyScaffold extends StatelessWidget {
  final Widget child;
  final ValueChanged<String> onTapped;
  const MyScaffold({
    Key key,
    @required this.child,
    @required this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onTapped(MyRoutePath.HOME);
              },
              switchToIndex: (b) {
                onTapped(b);
              },
              currentIndex: 2,
            ),
            tablet: WebNavigationBar(
              goHome: () {
                onTapped(MyRoutePath.HOME);
              },
              switchToIndex: (b) {
                onTapped(b);
              },
              currentIndex: 1,
            ),
            mobile: SizedBox(),
          ),
          Expanded(
            child: child,
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
                                NavigationService().pop();
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
                                  NavigationService().pop();
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
                                onTap: () {},
                              ),
                              singleDrawerItem(
                                otherPages: services,
                                label: "Services",
                                onTap: () {},
                              ),
                              singleDrawerItem(
                                label: "Health",
                                onTap: () {},
                              ),
                              singleDrawerItem(
                                label: "Team",
                                onTap: () {},
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              NimbusButton(
                                width: double.infinity,
                                buttonTitle: "Contact",
                                onPressed: () {
                                  NavigationService().pop();
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              NimbusButton(
                                width: double.infinity,
                                buttonTitle: "Get The App",
                                onPressed: () {
                                  NavigationService().pop();

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
                      NavigationService().pop();

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
