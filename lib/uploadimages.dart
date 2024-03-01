//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tryingfirebase/dbfirebase.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Uploadimage extends StatefulWidget {
  const Uploadimage({super.key});
  //final Stream?  LecturerStream;
  @override
  State<Uploadimage> createState() => UploadimageState();
}

class UploadimageState extends  State<Uploadimage> {
  UploadimageState();
 // late Stream?  LecturerStream;
 // SellproductsState({Key? key}) ;
 // SellproductsState({Key? key});//, required this.item}) : super(key: key);
   PlatformFile? pickedFile;
   UploadTask? uploadTask;
   FilePickerResult? result;
   File? file;
   TextEditingController picname = new TextEditingController();
   String imtype="";


//  Stream? LecturerStream;


  TextEditingController lecName=new TextEditingController();



  @override
  Widget build(BuildContext context) {

    //
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("select a photo to upload"),
                      ),
    body:  Padding(
          padding: const EdgeInsets.all(16.0),
          //form
    child: Column(
        children: [
          if(pickedFile != null)
            Expanded(child:
            Container(
              color: Colors.blue[100],
              child: Image.file(File(pickedFile!.path!),width: double.infinity,fit: BoxFit.cover),
              )
            ),
          SizedBox(height:32),
          ElevatedButton(
            onPressed: () async {
              // x=filecontaint as String;
              selectimage();
            },
            child: const Text('Pick a pic'),
          ),
          ElevatedButton(
            onPressed: uploadimage,
            child: Text('upload'),
          ),
SizedBox(height: 32),
          TextField(
            controller: picname,

          ),
          buildProgress(),
        ]
    )

  )


    );
  }
Future selectimage() async{
    //final file = File(file);
  //  final ref = FirebaseStorage.instance.ref().child(file);
   // uploadTask = ref.putFile(file);
  try {
    result = await FilePicker.platform.pickFiles();
    // result = await FilePicker.platform.pickFiles();
    if (result != null) {
      if (!kIsWeb) {
        file = File(result!.files.single.path!);
        // readexcelfile(file);
      }
    } else {
      print("user cancled the picker");
      // User canceled the picker
    }

  } catch (_) {}
  super.setState(()  {
    pickedFile=result?.files.first;
    List<String> s2= result!.names.first.toString().split(".");
    picname.text=s2[0];
    imtype=s2[1];
  });

}
Future uploadimage() async{
    String name="pic name 02";
    final path ='photos/${picname.text}.${imtype}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path!);
    ref.putFile(file);
    setState(() {
      uploadTask = ref.putFile(file);
    });



    final snapshot=await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link:$urlDownload');
    setState(() {
      uploadTask=null;
    });
}
Widget buildProgress()=> StreamBuilder<TaskSnapshot>(
    stream: uploadTask?.snapshotEvents,
    builder:(context, snapshot){
      if(snapshot.hasData){
final data = snapshot.data!;
double progress = data.bytesTransferred /data.totalBytes;
return SizedBox(
      height: 50,
      child: Stack(
      fit: StackFit.expand,
      children: [
LinearProgressIndicator(
  value: progress,
  backgroundColor: Colors.grey,
  color: Colors.green,
),
        Center(
          child: Text(
            '${(100*progress).roundToDouble()}%',
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
      ),
      );
      }else{
        return const SizedBox(height: 50);
      }
    }
);
}
