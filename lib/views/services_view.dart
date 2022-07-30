import 'package:apho/constants/constants_used_in_the_ui.dart';
import 'package:apho/constants/images.dart';
import 'package:apho/models/service.dart';
import 'package:apho/services/ui_services.dart';
import 'package:apho/widgets/single_image.dart';
import 'package:flutter/material.dart';

import '../widgets/nimbus_button.dart';
import 'home_screen.dart';

class ServicesView extends StatefulWidget {
  final Function(dynamic) onTapItem;
  ServicesView({
    Key key,
    @required this.onTapItem,
  }) : super(key: key);

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView>
    with AutomaticKeepAliveClientMixin {
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
                      "SERVICES",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Services designed to meet all health needs out there.",
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SingleImage(
                image: nurse,
                height: 300,
                width: double.infinity,
              ),
              Column(
                children: services
                    .map<Widget>(
                      (e) => singleServiceThingie(e),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 150,
                child: Center(
                  child: NimbusButton(
                    onPressed: () {
                      UIServices().showDatSheet(
                        AppOptionsBottomSheet(),
                        true,
                        context,
                      );
                    },
                    buttonTitle: "Get the App",
                  ),
                ),
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

  singleServiceThingie(ServiceModel serviceModel) {
    return Container(
      width: double.infinity,
      color: serviceModel.color.withOpacity(0.15),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 50,
      ),
      child: Column(
        children: [
          Text(
            "SERVICE",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            serviceModel.name,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            serviceModel.desc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: UIServices().decorationImage(
                serviceModel.image,
                false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
