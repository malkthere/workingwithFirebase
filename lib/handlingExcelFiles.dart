import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_excel/excel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';
import 'package:random_string/random_string.dart';
import 'package:tryingfirebase/sqldb.dart';

import 'dbfirebase.dart';


class Excelfiles {
  int _counter = 0;
  SqlDb sqlDb = SqlDb();

  //get selectedExcel => null;
  var excel = Excel.createExcel();

  void createexcelfile() async{
    Sheet sheetObject = excel['فاتورة 01'];
    var cell = sheetObject.cell(CellIndex.indexByString("A1"));
    cell.value = 8; // dynamic values support provided;
    List<String> data = ["Mr","’mazin", "Alkathiri"];
    // sheetObject = selectedExcel["Sheet1"];
    sheetObject.appendRow(data);
    saveExcel();

  }
  saveExcel() async {
    //request for storage permission
    var res = await Permission.storage.request();
    var fileBytes = excel.save();
    //var directory = await getApplicationDocumentsDirectory();

    File(join("/storage/emulated/0/Download/billNo03.xlsx"))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);
    //"/storage/emulated/0/Download/"  download folder address
    //excel2.xlsx is the file name "feel free to change the file name to anything you want"



  }

  void readexcelfile(File? file) async {
    //var file = "/storage/emulated/0/Download/billNo02.xlsx";
    int count=0;
    String department;
    String? departmentID;
    String? level;
    int? intlevel;
    var bytes = file!.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      // print(table); //sheet Name
      ////  print(excel.tables[table]?.maxCols);
      // print(excel.tables[table]?.maxRows);
      int counter=0;
      for (var row in excel.tables[table]!.rows) {
        // print("$row");
        if(counter==1){
          int counter2=0;
          for (var cell in row) {
            if(counter2==4) {
              //  print('cell ${cell!.rowIndex}/${cell.columnIndex}');
              if (cell != null)
                print(cell!.value);
              ////////////
              List<Map> response2= await sqlDb.readData("SELECT DeptID FROM department WHERE DeptName = '${cell!.value.toString()}'");
              print(response2);

              //  print(departmentID+"hhh");
              if(response2.isEmpty){

                String sqlQ = "INSERT INTO department ('DeptName') VALUES ('${cell!.value.toString()}')";
                int response = await sqlDb.insertData(sqlQ);
                print("this department is not in the database, now is add "+response.toString());
                departmentID=response.toString();
                print(departmentID);

              }else{
                departmentID=response2[0]['DeptID'].toString();

              }
              ////////////
            }
            counter2++;
          }
        }
        if(counter==2){
          int counter2=0;
          for (var cell in row) {
            if(counter2==4) {
              //  print('cell ${cell!.rowIndex}/${cell.columnIndex}');
              if (cell != null)
                level=cell!.value.toString();
              //print(s2[4].toString());
              if (level=="الاول") intlevel=1;
              else if (level=="الثاني") intlevel=2;
              else if (level=="الثالث") intlevel=3;
              else intlevel=4;
              //print(intlevel);
                print(cell!.value);
            }
            counter2++;
          }
        }
        if(counter>6){
          var stdName;
          var stdID;
          int counter2=0;
          for (var cell in row) {
            if(counter2==1) {
              //  print('cell ${cell!.rowIndex}/${cell.columnIndex}');
              if (cell != null)
                stdName=cell.value;
              print(cell!.value);
            }
            if(counter2==2) {
              //  print('cell ${cell!.rowIndex}/${cell.columnIndex}');
              if (cell != null)
                stdID=cell.value;
              print(cell!.value);

            }
            counter2++;
          }
          Map<String, dynamic> StdData={
            "StdName":stdName,
            "StdID":stdID,
            "DeptID":departmentID,
            "level":intlevel,
          };
          String id =randomAlphaNumeric(10);
          await Databasemethods().addAnyData(StdData, id,"Std_info").then((value) {
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
        counter++;
      }
    }
  }

}