import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iub_transport_system/components/textFieldDesign.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../const.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String url ='';
  int? num;
uploadDataToFirebase()async{
  // generate random number
  num =Random().nextInt(10);
  //this is use to pic the pdf file
  FilePickerResult? result =await FilePicker.platform.pickFiles();
  File pick =File(result!.files.single.path.toString());
  var file =pick.readAsBytesSync();
  String name = DateTime.now().microsecondsSinceEpoch.toString();

  //  upload file to firebase
  var pdfFile = FirebaseStorage.instance.ref().child(name).child("/.pdf");
  UploadTask task = pdfFile.putData(file);
  TaskSnapshot taskSnapshot = await task;
  url = await taskSnapshot.ref.getDownloadURL();
  print(url);

  // upload url to Cloudstorage
  await FirebaseFirestore.instance.collection("file").doc().set({
    'fileUrl':url,
    'num':"Document#"+num.toString(),
  });
}
  Future<void> downloadFileExample() async {
    //First you get the documents folder location on the device...
    Directory appDocDir = await getApplicationDocumentsDirectory();
    //Here you'll specify the file it should be saved as
    File downloadToFile = File('${appDocDir.path}/downloaded-pdf.pdf');
    //Here you'll specify the file it should download from Cloud Storage
    String fileToDownload = 'file';

    //Now you can try to download the specified file, and write it to the downloadToFile.
    try {
      await FirebaseStorage.instance
          .ref(fileToDownload)
          .writeToFile(downloadToFile);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print('Download error: $e');
    }
  }

  final storageRef = FirebaseStorage.instance.ref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColour,
        title: Text("Upload Bus Time Table"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("file").snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
                itemBuilder: (context ,i){
                  QueryDocumentSnapshot d =snapshot.data!.docs[i];
                  return InkWell(
                    onTap: (){
                      downloadFileExample();
                      // download();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => View(url:d['fileUrl'])));
                    },
                    child: Container(
                      child: Text(d['num']),
                    ),
                  );
                }
            );
          }
          return Center(child: CircularProgressIndicator());
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          uploadDataToFirebase();
        },
      ),
      );
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //
    //     },
    //     child: Icon(Icons.add,color: Colors.white,),
    //     backgroundColor: Colors.red,
    //   ),
    // );
  }
}

class View extends StatefulWidget {
  String url;
  View({required this.url});

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  PdfViewerController? pdfViewerController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: SfPdfViewer.network(
                widget.url,
                pageLayoutMode: PdfPageLayoutMode.single)));
  }
}
