import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gozlukstore/constants.dart';
import 'package:gozlukstore/models/FirebaseData.dart';
import 'package:gozlukstore/models/Glass.dart';
import 'package:gozlukstore/screens/details/details_screen.dart';
import 'categorries.dart';
import 'item_card.dart';

class Body extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: < Widget > [
                Categories(),
                Expanded(
                child: _buildBody(context)
                /*Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: kDefaultPaddin,
                            crossAxisSpacing: kDefaultPaddin,
                            childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) => ItemCard(
                            glasses: glasses[index],
                            press: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                        product: getDataJSON()[index],
                                    ),
                                )
                            ),
                        )
                    ),
                ),*/    
            ),
        ],
    );
}

Widget _buildBody(BuildContext context) {
    return StreamBuilder < QuerySnapshot > (
        stream: FirebaseData.allData(),
        builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            return _buildList(context, snapshot.data.documents);
        },
    );
}

Widget _buildList(BuildContext context, List < DocumentSnapshot > snapshot) {
    return
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: snapshot.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                    glasses: Glass.fromJson(snapshot[index].data, snapshot[index].documentID),
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                product: Glass.fromJson(snapshot[index].data, snapshot[index].documentID),
                            )
                        )
                    )
                ),
                //snapshot.map((data) => _buildListItem(context, data)).toList(),
            )
        );
    }
}
