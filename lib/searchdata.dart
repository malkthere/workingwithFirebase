import 'package:tryingfirebase/dbfirebase.dart';
import 'package:flutter/material.dart';
import 'package:tryingfirebase/showdata.dart';
class Searchdata extends StatefulWidget {
  const Searchdata({super.key});

  @override
  State<Searchdata> createState() => SearchdataState();
}
class Product {
  final String costname;
  final String proname;
  final String quantaty;
  final String price;
  final int total;

  Product(this.costname, this.proname, this.quantaty, this.price, this.total);


}
class SearchdataState extends  State<Searchdata> {




  Stream? LecturerStream;



  TextEditingController collectionname=TextEditingController();
  TextEditingController docname=TextEditingController();
  TextEditingController docvalue=TextEditingController();
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

          TextField(
            controller: collectionname,

          ),
          TextField(
            controller: docname,
          ),
          TextField(
            controller: docvalue,
          ),
          ElevatedButton(
              child: Text(
                "بحث",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              onPressed: () async{




                  LecturerStream=await Databasemethods().getselectedData(collectionname.text,docname.text,docvalue.text).then((value) {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Showdata(LecturerStream: value),
                      ),
                    );
                   });


              }
          ),
            //Expanded(child: allLecDetails()),
        ]
    )

  )


    );
  }
}
