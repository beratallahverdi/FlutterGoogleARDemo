import 'package:flutter/material.dart';
import 'package:gozlukstore/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gozlukstore/models/Glass.dart';
import 'package:gozlukstore/file_create_write.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';


class SplashScreen extends StatefulWidget {
    @override
    _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
{    
    Future retrieveData() async
    {
        List<Map<String, dynamic>> allContent = new List<Map<String, dynamic>>();
        //Firestore.instance.collection("gozlukstore").where("ar_supported",isNull: false).getDocuments();
        await Firestore.instance.collection("gozlukstore").getDocuments().then((QuerySnapshot snapshot) {
            snapshot.documents.forEach((f) {
                allContent.add(Glass.fromJson(f.data, f.documentID).toJson());
            });
        });

        return allContent; 
    }

 

  

    @override
    void initState() 
    {
        super.initState();

        String fileName = "hello.sfb";
        var instance = FileIO();

Navigator.of(context).pushReplacement(MaterialPageRoute( builder: (BuildContext context) => HomeScreen()));

        // instance.fileExist(fileName).then((isExist) {
        //     if(isExist) Navigator.of(context).pushReplacement(MaterialPageRoute( builder: (BuildContext context) => HomeScreen()));
        //     else {
        //         instance.downloadFile("https://firebasestorage.googleapis.com/v0/b/glassfirebase-d8358.appspot.com/o/gozluk_berat_final180.sfb?alt=media&token=51361b58-0285-48fe-a411-fd7d4fe2ea45","hello.sfb")
        //         .then((var allContent) { if(allContent.isEmpty) throw('Firebase connection error'); else instance.createFile(allContent, "data.json");})
        //         .then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomeScreen())))
        //         .catchError((e)=> errorAlertDialog(e))
        //         .whenComplete(() => print("Process completed!"));
        //     }
        // });



 

        //    instance.fileExist(fileName).then((isExist) {
        //     if(isExist) Navigator.of(context).pushReplacement(MaterialPageRoute( builder: (BuildContext context) => HomeScreen()));
        //     else {
        //         instance.downloadFile("https://firebasestorage.googleapis.com/v0/b/glassfirebase-d8358.appspot.com/o/gozluk_berat_final180.sfb?alt=media&token=51361b58-0285-48fe-a411-fd7d4fe2ea45","hello.sfb")
        //         .then((value) => print(value.path))
        //         .then((value) => instance.fileExist(fileName))
        //         .then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomeScreen())))
        //         .catchError((e)=> errorAlertDialog(e))
        //         .whenComplete(() => print("Process completed!"));
        //     }
        // });
    }
    


    Future<void> errorAlertDialog(String error) async {
        return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(error),
                        content: SingleChildScrollView(
                            child: ListBody(
                                children: <Widget>[
                                    Text('Please tap the EXIT button and come back again!'),
                                ],
                            ),
                        ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text('EXIT'),
                            onPressed: () {
                                pop(); // Application will exit.
                            },
                        ),
                    ],
                );
            },
        );
    }

    // https://api.flutter.dev/flutter/services/SystemNavigator/pop.html
    static Future<void> pop({bool animated}) async {
        await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop', animated);
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: FlutterLogo(
                    size:400
                )
            ),
        );
    }
}