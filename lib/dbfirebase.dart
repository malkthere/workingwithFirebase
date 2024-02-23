import 'package:cloud_firestore/cloud_firestore.dart';

class Databasemethods{
Future addData(Map<String, dynamic> LecInfoMap, String id)async{
return await FirebaseFirestore.instance
    .collection("lecturer")
    .doc(id)
    .set(LecInfoMap);
}
Future<Stream<QuerySnapshot>> getData(String CollectionName) async{
  return await FirebaseFirestore.instance.collection(CollectionName).snapshots();
}
}