import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gozlukstore/constants.dart';
import 'package:gozlukstore/models/Glass.dart';
import 'package:gozlukstore/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Glass product;

  const DetailsScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: product.color,
      appBar: buildAppBar(context),
      body: Body(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: product.color,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/heart.svg", color: Colors.black,),
          onPressed: () {},
        ),
        /*
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        */
        IconButton(
          icon: SvgPicture.asset("assets/icons/cart.svg", color: Colors.black,),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
