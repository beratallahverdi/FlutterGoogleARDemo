import 'package:flutter/material.dart';
import 'package:gozlukstore/constants.dart';
import 'package:gozlukstore/models/Glass.dart';

import 'add_to_cart.dart';
import 'color_and_size.dart';
// import 'counter_with_fav_btn.dart';
import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatelessWidget {
  final Glass product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin,
                  ),
                  //height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: kDefaultPaddin),
                      ColorAndSize(product: product),
                      SizedBox(height: kDefaultPaddin),
                      Description(product: product),
                      SizedBox(height: kDefaultPaddin),
                      //CounterWithFavBtn(),
                      SizedBox(height: kDefaultPaddin),
                      AddToCart(product: product),
                      // TryVisual(product: product)
                    ],
                  ),
                ),
                ProductTitleWithImage(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }
}
