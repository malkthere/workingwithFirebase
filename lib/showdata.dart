import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  late Stream?  LecturerStream;
 // SellproductsState({Key? key}) ;
 // SellproductsState({Key? key});//, required this.item}) : super(key: key);



//  Stream? LecturerStream;
  getontheload() async{
    if (await LecturerStream==null){
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
  TextEditingController lecName=new TextEditingController();
  TextEditingController lecPhNo=new TextEditingController();
  TextEditingController lecCol=new TextEditingController();
  TextEditingController lecDept=new TextEditingController();
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

  child: Column(
    children: [
      Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("name : "+ds["lecName"],style:TextStyle(color: Colors.blue,fontSize: 20.0, fontWeight: FontWeight.bold) ),
              GestureDetector(
                  onTap: (){
                    lecName.text=ds["lecName"];
                    lecCol.text=ds["lecCol"];
                    lecPhNo.text=ds["lecPhNo"];
                      lecDept.text=ds["lecDept"];
                    editLecturerInfo(ds["ID"]);
                  },
                  child: Icon(Icons.edit, color: Colors.amber))
              ],
            ),
          ),
          Text("college : "+ds["lecCol"],style:TextStyle(color: Colors.blue,fontSize: 20.0, fontWeight: FontWeight.bold) ),
          Text("Department : "+ds["lecDept"],style:TextStyle(color: Colors.blue,fontSize: 20.0, fontWeight: FontWeight.bold) ),
          Text("Phone No. : "+ds["lecPhNo"],style:TextStyle(color: Colors.blue,fontSize: 20.0, fontWeight: FontWeight.bold) ),

        ],
      ),
        // SizedBox(width: 60.0),

      ),
              SizedBox(height: 20.0)
    ],
  ),
  // SizedBox(width: 60.0),

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
  Future editLecturerInfo(String id)=> showDialog(context: context, builder: (context)=>AlertDialog(
    content: Container(
      child: Column(children: [
        Row(children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child:Icon(Icons.cancel),
          ),

          Text("Edit")
        ],),
        Text(
          "إضافة منتجات للفاتورة ",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        //styling
        TextFormField(
          controller: lecName,
          decoration: InputDecoration(labelText: 'اسم المحاضر'),
          keyboardType: TextInputType.emailAddress,
          onFieldSubmitted: (value) {

          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter a valid email!';
            }
            return null;
          },
        ),
        TextFormField(
          controller: lecCol,
          decoration: InputDecoration(labelText: 'كلية'),
          keyboardType: TextInputType.emailAddress,
          onFieldSubmitted: (value) {
            //Validator
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter a valid email!';
            }
            return null;
          },
        ),
        TextFormField(
          controller: lecDept,
          decoration: InputDecoration(labelText: 'مدرس بقسم'),
          keyboardType: TextInputType.emailAddress,
          onFieldSubmitted: (value) {
            //Validator
          },
          validator: (value) {
            if (value!.isEmpty)
            {
              return 'Enter a valid email!';
            }
            return null;
          },
        ),
        TextFormField(
          controller: lecPhNo,
          decoration: InputDecoration(labelText: 'رقم الهاتف'),
          keyboardType: TextInputType.emailAddress,
          onFieldSubmitted: (value) {
            //Validator
          },
          validator: (value) {
            if (value!.isEmpty)
            {
              return 'Enter a valid email!';
            }
            return null;
          },
        ),
      SizedBox(width: 40.0),
      ElevatedButton(
          onPressed: ()async{
        Map<String, dynamic> lecInfoMap={
          "lecName":lecName.text,
          "ID":id,
          "lecCol":lecCol.text,
          "lecDept":lecDept.text,
          "lecPhNo":lecPhNo.text,
        };
        await Databasemethods().updateData(lecInfoMap, id,"lecturer").then((value) {
          Fluttertoast.showToast(
              msg: "تم تحديث البيانات ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.pop(context);
        });
      }, child: Text("تحديث"))],

        ),
    ),
  ));

}
