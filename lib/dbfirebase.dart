import 'package:cloud_firestore/cloud_firestore.dart';

class Databasemethods{
Future addLecData(Map<String, dynamic> LecInfoMap, String id)async{
return await FirebaseFirestore.instance
    .collection("lecturer")
    .doc(id)
    .set(LecInfoMap);
}
Future addAnyData(Map<String, dynamic> ListMap, String id, String CollectionName)async{
return await FirebaseFirestore.instance
    .collection(CollectionName)
    .doc(id)
    .set(ListMap);
}


Future<Stream<QuerySnapshot>> getData(String CollectionName) async{
  return await FirebaseFirestore.instance.collection(CollectionName).snapshots();
}
}