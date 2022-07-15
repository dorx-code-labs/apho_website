import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:apho/constants/ui.dart';


const BLUE = "blue";
const GREEN = "green";
const RED = "red";
const YELLOW = "yellow";
const PURPLE = "purple";
const PINK = "pink";

enum AuthFormType { signIn, signUp, reset }

class UIServices {
  Color colorFromString(String kala) {
    return kala == BLUE
        ? Colors.blue
        : kala == GREEN
            ? Colors.green
            : kala == PINK
                ? Colors.pink
                : kala == PURPLE
                    ? Colors.purple
                    : kala == YELLOW
                        ? Colors.yellow
                        : kala == RED
                            ? Colors.red
                            : Colors.blue;
  }

  Future<dynamic> showDatSheet(
    Widget sheet,
    bool willThisThingNeedScrolling,
    BuildContext context, {
    double height,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: willThisThingNeedScrolling,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SizedBox(
          height: height ?? MediaQuery.of(context).size.height * 0.8,
          child: StatefulBuilder(builder: (context, setIt) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Theme.of(context).canvasColor,
                  elevation: standardElevation,
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: 10,
                    width: 50,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        16,
                      ),
                      topRight: Radius.circular(
                        16,
                      ),
                    ),
                    child: Container(
                      color: Theme.of(context).canvasColor,
                      child: sheet,
                    ),
                  ),
                )
              ],
            );
          }),
        );
      },
    );
  }

  getImageProvider(
    dynamic asset,
  ) {
    return asset is File
        ? FileImage(asset)
        : asset.toString().trim().contains(
                  "assets/images",
                )
            ? AssetImage(
                asset,
              )
            : CachedNetworkImageProvider(
                asset,
              );
  }

  DecorationImage decorationImage(
    dynamic asset,
    bool darken,
  ) {
    return asset == null
        ? null
        : DecorationImage(
            image: asset is File
                ? FileImage(asset)
                : asset.toString().trim().contains(
                          "assets/images",
                        )
                    ? AssetImage(
                        asset,
                      )
                    : CachedNetworkImageProvider(
                        asset,
                      ),
            fit: BoxFit.cover,
            colorFilter: darken
                ? ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.darken,
                  )
                : null,
          );
  }
}

class MySliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  MySliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(MySliverAppBarDelegate oldDelegate) {
    return false;
  }
}
