import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gozlukstore/models/Glass.dart';
import 'package:path_provider/path_provider.dart';
import 'try_visual.dart';
import '../../../constants.dart';
import '../../../FileCRUD.dart';

Future<String> modelFileAsyncFetch(Glass product) async 
{
  // final String path = await getExternalStorageDirectory().then((value) => value.path);
  if (product.arSupported.isEmpty) return null;

  var instance = await FileIO.create();
  final String modelFileName = "${product.title}.sfb";

  return await instance.fileExist("$modelFileName") ? 
    "${instance.dirPath}/${product.title}.sfb"
    : await instance.downloadFileGetFilePath(product.arSupported, "${product.title}.sfb");
}

class AddToCart extends StatelessWidget {
    const AddToCart({ Key key, @required this.product,}) : super(key: key);
    final Glass product;

    Expanded tryVisualUI(BuildContext context, String modelFilePath) {
        return  
            Expanded
            (
                child: SizedBox(
                height: 50,
                child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                    color: Color(0xFF3D82AE),
                    onPressed: product.arSupported.isEmpty ? 
                        null: () { Navigator.push(context, MaterialPageRoute( builder: (context) => CameraView( modelFilePath: modelFilePath,)),);},
                    child: 
                        Text(
                            "Try Visual".toUpperCase(),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                            ),
                        ),
                ),
            ),
        );
    }

    Expanded tryBuyNowUI() {
        return  
            Expanded
            (
                child: SizedBox(
                height: 50,
                child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                    color: Color(0xFF3D82AE),
                    onPressed: () => {},
                    child: 
                        Text(
                            "Buy Now".toUpperCase(),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                            ),
                        ),
                ),
            ),
        );
    }
    
    @override
    Widget build(BuildContext context) {
        return FutureBuilder<String>(
            future: modelFileAsyncFetch(product),
            builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                    if (snapshot.data != null) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
                            child: Row(
                                children: <Widget>[
                                    tryVisualUI(context, snapshot.data),
                                    tryBuyNowUI(),
                                ],
                            ),
                        );
                    } 
                    else {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
                            child: Row(
                                children: <Widget>[
                                    tryBuyNowUI(),
                                ],
                            ),
                        );
                    }
                } 
                else {
                    return CircularProgressIndicator();
                }
            }
        );
    }
}
