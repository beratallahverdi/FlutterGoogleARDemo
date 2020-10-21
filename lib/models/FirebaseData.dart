import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gozlukstore/models/Glass.dart';

class FirebaseData {
    static String collection = "gozlukstore";
    static List<Glass> gozlukler;
    static List<DocumentSnapshot> veriler;
    static Stream<QuerySnapshot> allData() {
    Stream<QuerySnapshot> allData = Firestore.instance.collection(collection).snapshots();
    // a.forEach((element){
    //   element.documents.forEach((element) { element.data.forEach((key, value) {print('$key = $value');});});
    // });
    /*veriler.forEach((element) {
      gozlukler.add(Glass.fromJson(element.data, element.documentID));
    });*/
    return allData;
  }
}

mixin private {}