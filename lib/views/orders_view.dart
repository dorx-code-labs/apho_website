/* import 'package:apho/models/order.dart';
import 'package:apho/services/auth_provider_widget.dart';
import 'package:apho/services/navigation.dart';
import 'package:apho/theming/theme_controller.dart';
import 'package:apho/views/order_some_medicine.dart';
import 'package:apho/widgets/custom_dialog_box.dart';
import 'package:apho/widgets/top_back_bar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'loading_view.dart';
import 'not_signed_in.dart';

class OrdersView extends StatefulWidget {
  OrdersView({Key key}) : super(key: key);

  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  User user;
  List<String> stuff = [];
  dynamic data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: AuthProvider.of(context).auth.onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final bool signedIn = snapshot.hasData;

              if (signedIn) {
                user = snapshot.data;

                return signedInView();
              } else {
                return NotSignedInView();
              }
            } else {
              return LoadingWidget();
            }
          },
        ),
      ),
    );
  }

  signedInView() {
    return StreamBuilder(
      stream: FirebaseDatabase.instance
          .ref()
          .child("orders")
          .child(user.uid)
          .onValue,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: LoadingWidget(),
          );
        } else {
          data.clear();
          stuff.clear();

          if (snapshot.data != null && snapshot.data.snapshot.value != null) {
            data = snapshot.data.snapshot.value;
            data.forEach((key, value) {
              stuff.add(key);
            });
          }

          return SafeArea(
              child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    BackBar(
                        icon: null, onPressed: null, text: "Medicine Orders")
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      padding: EdgeInsets.all(2),
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              singleAddPostCard(
                                context,
                                "assets/images/medications.jpg",
                                "Order for Medicine",
                                () {
                                  NavigationService().push(
                                    context: context,
                                    page: OrderMedicine(),
                                  );
                                },
                                "question",
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              data == null || data.length == 0
                  ? SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SvgPicture.asset(
                            "assets/images/void.svg",
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Place some orders for medicine and you will be able to track your order here",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return singleOrder(
                          stuff[index],
                        );
                      }, childCount: stuff.length),
                    )
            ],
          ));
        }
      },
    );
  }

  singleOrder(String orderID) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("orders")
          .doc(orderID)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingWidget();
        } else {
          if (!snapshot.data.exists) {
            return Container(
              margin: EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 7,
                right: 7,
              ),
              width: double.infinity,
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
                  child: Column(
                    children: [
                      Container(
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
                              color:
                                  ThemeBuilder.of(context).getCurrentTheme() ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                            )),
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 10,
                            bottom: 10,
                            right: 10,
                          ),
                          width: double.infinity,
                          child: Text(
                            "This order was deleted",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialogBox(
                                  showSignInButton: false,
                                  buttonText: "Un-Save",
                                  bodyText:
                                      "Do you really want to cancel this order",
                                  showOtherButton: true,
                                  onButtonTap: () {
                                    FirebaseDatabase.instance
                                        .ref()
                                        .child("orders")
                                        .child(user.uid)
                                        .child(orderID)
                                        .remove();
                                  },
                                );
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Remove it",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            Order order = Order.fromSnapshot(
              snapshot.data,
            );

            return Container(
              margin: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5,
              ),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ExpansionTile(
                        title: Text(
                          order.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        childrenPadding: EdgeInsets.all(8),
                        expandedAlignment: Alignment.topLeft,
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        subtitle: Text("${timeago.format(
                          DateTime.fromMillisecondsSinceEpoch(order.date),
                        )}"),
                        children: [
                          Text(
                            "${order.quantity.toString()} units",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Price per unit: ${order.price.toString()} UGX",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Total cost: ${(order.price * order.quantity).toString()} UGX",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: singleButton(
                              "Cancel Order",
                              Colors.red,
                              () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                      showSignInButton: false,
                                      buttonText: "Cancel",
                                      bodyText:
                                          "Do you really want to cancel this order",
                                      showOtherButton: true,
                                      onButtonTap: () {
                                        FirebaseDatabase.instance
                                            .ref()
                                            .child("orders")
                                            .child(user.uid)
                                            .child(orderID)
                                            .remove()
                                            .then((value) {
                                          FirebaseFirestore.instance
                                              .collection("orders")
                                              .doc(orderID)
                                              .delete();
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }

  singleAddPostCard(BuildContext context, String asset, String title,
      Function onPressed, String tag) {
    return GestureDetector(
      onTap: onPressed,
      child: Hero(
        tag: tag,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.124,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                image: AssetImage(asset),
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
                fit: BoxFit.cover),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold),
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
            padding: EdgeInsets.all(15),
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
                  fontSize: 16,
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
}
 */