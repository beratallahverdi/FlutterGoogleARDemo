import 'package:flutter/material.dart';
import 'package:gozlukstore/models/Glass.dart';
import 'package:transparent_image/transparent_image.dart';


import '../../../constants.dart';

class ItemCard extends StatelessWidget {
  final Glass glasses;
  final Function press;
  const ItemCard({
    Key key,
    this.glasses,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: glasses.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${glasses.documentID}",
                child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: glasses.images.first,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              glasses.title,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\$${glasses.seller.first.price}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
