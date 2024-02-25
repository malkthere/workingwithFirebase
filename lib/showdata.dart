import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tryingfirebase/dbfirebase.dart';
import 'package:flutter/material.dart';
class Showdata extends StatefulWidget {
  const Showdata({super.key,required this.LecturerStream});
  final Stream?  LecturerStream;
  @override
  State<Showdata> createState() => ShowdataState(LecturerStream);
}

class ShowdataState extends  State<Showdata> {
   ShowdataState(this.LecturerStream);
  late final Stream?  LecturerStream;
 // SellproductsState({Key? key}) ;
 // SellproductsState({Key? key});//, required this.item}) : super(key: key);



//  Stream? LecturerStream;
  getontheload() async{
    if (await LecturerStream!.isEmpty){
      LecturerStream=await Databasemethods().getData("lecturer");
    }

    setState(() {

    });
  }
  @override
  void initState() {
    getontheload();
    super.initState();
  }
  Widget allLecDetails(){
    return StreamBuilder(
        stream: LecturerStream,
        builder:(context, AsyncSnapshot snapshot){
        return snapshot.hasData
       ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index){
DocumentSnapshot ds=snapshot.data.docs[index];
return Material(
  elevation: 5.0,
  borderRadius: BorderRadius.circular(10),
  child: Container(
    padding: EdgeInsets.all(20),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("name : "+ds["lecName"],style:TextStyle(color: Colors.blue,fontSize: 20.0, fontWeight: FontWeight.bold) ),
        Text("college : "+ds["lecCol"],style:TextStyle(color: Colors.blue,fontSize: 20.0, fontWeight: FontWeight.bold) ),
        Text("Department : "+ds["lecDept"],style:TextStyle(color: Colors.blue,fontSize: 20.0, fontWeight: FontWeight.bold) ),
        Text("Phone No. : "+ds["lecPhNo"],style:TextStyle(color: Colors.blue,fontSize: 20.0, fontWeight: FontWeight.bold) ),

      ],
    ),

  ),
);
            }):Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Sell a product"),
                      ),
    body:  Padding(
          padding: const EdgeInsets.all(16.0),
          //form
    child: Column(
        children: [
Expanded(child: allLecDetails()),
        ]
    )

  )


    );
  }
}
