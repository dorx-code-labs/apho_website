import 'package:apho/views/home_screen.dart';
import 'package:apho/widgets/single_image.dart';
import 'package:flutter/material.dart';

import '../constants/constants_used_in_the_ui.dart';

class ProductsView extends StatefulWidget {
  ProductsView({Key key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  SingleProductsView(
                    product: apps[0],
                    color: Theme.of(context).canvasColor,
                  ),
                  SingleProductsView(
                    product: apps[1],
                    color: Colors.pink.withOpacity(0.2),
                  ),
                  Footer(),
                ])
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

class SingleProductsView extends StatefulWidget {
  final ProjectModel product;
  final Color color;
  SingleProductsView({
    Key key,
    @required this.product,
    @required this.color,
  }) : super(key: key);

  @override
  State<SingleProductsView> createState() => _SingleProductsViewState();
}

class _SingleProductsViewState extends State<SingleProductsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            widget.product.name,
            style: TextStyle(
              fontSize: 50,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            widget.product.topDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SingleImage(
            height: 300,
            fit: BoxFit.contain,
            image: widget.product.coverImage,
            width: double.infinity,
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              singleTextCard(
                "01",
                "Problem",
                widget.product.problem,
                widget.product.color.withOpacity(0.2),
              ),
              singleTextCard(
                "02",
                "Solution",
                widget.product.solution,
                widget.product.color.withOpacity(0.3),
              ),
              singleTextCard(
                "03",
                "Results",
                widget.product.result,
                widget.product.color.withOpacity(0.4),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "The Problem",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            widget.product.problemDetails,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SingleImage(
            height: 300,
            image: widget.product.problemImage,
            width: double.infinity,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "The Solution",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            widget.product.solutionDetails,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  singleTextCard(
    String number,
    String type,
    String details,
    Color color,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 50,
      ),
      color: color,
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            type,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            details,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
