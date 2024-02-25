import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';
import 'package:tryingfirebase/dbfirebase.dart';
import 'package:tryingfirebase/exceldataupload.dart';
import 'package:tryingfirebase/searchdata.dart';
import 'package:tryingfirebase/showdata.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var _formKey = GlobalKey<FormState>();
  TextEditingController lecName=new TextEditingController();
  TextEditingController lecPhNo=new TextEditingController();
  TextEditingController lecCol=new TextEditingController();
  TextEditingController lecDept=new TextEditingController();
  Databasemethods dbobj=new Databasemethods();
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
     // TRY THIS: Try changing the color here to a specific color (to
     // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
     // change color while the other colors stay the same.
     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
     // Here we take the value from the MyHomePage object that was created by
     // the App.build method, and use it to set our appbar title.
     title: Text(widget.title),


        ),
        body: Center(
     // Center is a layout widget. It takes a single child and positions it
     // in the middle of the parent.
     child: Column(
       // Column is also a layout widget. It takes a list of children and
       // arranges them vertically. By default, it sizes itself to fit its
       // children horizontally, and tries to be as tall as its parent.
       //
       // Column has various properties to control how it sizes itself and
       // how it positions its children. Here we use mainAxisAlignment to
       // center the children vertically; the main axis here is the vertical
       // axis because Columns are vertical (the cross axis would be
       // horizontal).
       //
       // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
       // action in the IDE, or press "p" in the console), to see the
       // wireframe for each widget.
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
          Form(
           key: _formKey,
           child: Column(
             children: <Widget>[
               Text(
                 "إضافة منتجات للفاتورة ",
                 style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
               ),
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
               //box styling
               SizedBox(
                 height: MediaQuery.of(context).size.width * 0.1,
               ),
               //text input

               SizedBox(
                 height: MediaQuery.of(context).size.width * 0.1,
               ),
               FittedBox(
                 child: Row(
                   children: [
                     ElevatedButton(
                         child: Text(
                           "تسجيل",
                           style: TextStyle(
                             fontSize: 16.0,
                           ),
                         ),
                         onPressed: () async{

                           String id =randomAlphaNumeric(10);
                           // _submit();
                           Map<String, dynamic> lecInfoMap={
                             "lecName":lecName.text,
                             "ID":id,
                             "lecCol":lecCol.text,
                             "lecDept":lecDept.text,
                             "lecPhNo":lecPhNo.text,
                           };
                           await Databasemethods().addLecData(lecInfoMap, id).then((value) {
                             Fluttertoast.showToast(
                                 msg: "Lecturer infor have been added successfully ",
                                 toastLength: Toast.LENGTH_SHORT,
                                 gravity: ToastGravity.CENTER,
                                 timeInSecForIosWeb: 1,
                                 backgroundColor: Colors.red,
                                 textColor: Colors.white,
                                 fontSize: 16.0
                             );
                           });
                           //await dbobj.addData(LecInfoMap, id)

                           //costname.text="";
                           lecName.text="";
                           lecCol.text="";
                           lecDept.text="";
                           lecPhNo.text="";

                         }
                     ),
                     ElevatedButton(
                         child: Text(
                           "صفحة العرض",
                           style: TextStyle(
                             fontSize: 16.0,
                           ),
                         ),
                         onPressed: () async{
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => Showdata(LecturerStream:null),
                             ),
                           );
                         }
                     ),
                     ElevatedButton(
                         child: Text(
                           "صفحة البحث",
                           style: TextStyle(
                             fontSize: 16.0,
                           ),
                         ),
                         onPressed: () async{
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => Searchdata(),
                             ),
                           );
                         }
                     ),
                     ElevatedButton(
                         child: Text(
                           "رفع البيانات من ملف اكسل",
                           style: TextStyle(
                             fontSize: 16.0,
                           ),
                         ),
                         onPressed: () async{
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => Uploadexcel(),
                             ),
                           );
                         }
                     ),


                   ],
                 ),
               ),
             ],
           ),
         ),
       ],
     ),
        ),
        floatingActionButton: FloatingActionButton(
     onPressed: _incrementCounter,
     tooltip: 'Increment',
     child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
