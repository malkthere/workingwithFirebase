//import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'package:tryingfirebase/dbfirebase.dart';
import 'package:flutter/material.dart';
import 'package:tryingfirebase/sqldb.dart';

import 'handlingExcelFiles.dart';
class Uploadexcel extends StatefulWidget {
  const Uploadexcel({super.key});

  @override
  State<Uploadexcel> createState() => UploadexcelState();
}
class Product {
  final String costname;
  final String proname;
  final String quantaty;
  final String price;
  final int total;

  Product(this.costname, this.proname, this.quantaty, this.price, this.total);


}

SqlDb sqlDb = SqlDb();

class UploadexcelState extends  State<Uploadexcel> {
  // SellproductsState({Key? key}) ;
  // SellproductsState({Key? key});//, required this.item}) : super(key: key);







  @override
  Widget build(BuildContext context) {
    FilePickerResult? result;
    File? file;
    Excelfiles excelobj=new Excelfiles();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("upload excel data to Firestore DB"),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                // x=filecontaint as String;
                try {
                  result = await FilePicker.platform.pickFiles();
                  // result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    if (!kIsWeb) {
                      file = File(result!.files.single.path!);
                      excelobj.readexcelfile(file);
                    }
                  } else {
                    print("user cancled the picker");
                    // User canceled the picker
                  }

                } catch (_) {}
                super.setState(()  {

                });
              },
              child: const Text('Pick an Excel File'),
            ),
            ElevatedButton(
              onPressed: () async {
                excelobj.createexcelfile();
              },
              child: const Text('create an excel file'),
            ),
            ElevatedButton(
              onPressed: () async {
                List<Map> response2= await sqlDb.readData("SELECT * FROM department");
                print(response2);

                for (var i in response2){
                  String id =randomAlphaNumeric(10);

                  Map<String, dynamic> dept={
                    "DeptID":i["DeptID"],
                    "DeptName":i["DeptName"],
                  };
                  await Databasemethods().addAnyData(dept, id,"department").then((value) {
                    Fluttertoast.showToast(
                        msg: "a student info have been added ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  });
                }


              },
              child: const Text('copy from SQFLITE to firestore database'),
            ),


          ],
        ),
      ),


    );
  }
}
