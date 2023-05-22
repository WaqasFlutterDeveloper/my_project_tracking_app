import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iub_transport_system/components/textFieldDesign.dart';
import 'package:path_provider/path_provider.dart';
class StudentBussRuteInfo extends StatefulWidget {
  const StudentBussRuteInfo({Key? key}) : super(key: key);

  @override
  State<StudentBussRuteInfo> createState() => _StudentBussRuteInfoState();
}

class _StudentBussRuteInfoState extends State<StudentBussRuteInfo> {
late Future<ListResult> futureFiles;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FutureBuilder<ListResult>(
        future: futureFiles,
          builder:(context ,snapshot){
            if(snapshot.hasData){
              final files = snapshot.data!.items;
              return ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context ,index){
                    final files =snapshot.data!.items;
                    return ListTile(
                      trailing: IconButton(
                        icon: Icon(Icons.download,color: Colors.black,),
                        onPressed: (){

                        },
                      ),
                    );
                  }
              );
            }
            return Center(child: CircularProgressIndicator());
          }
      ),
    );
  }
Future downloadFile(Reference reference)async{
final dir =await getApplicationDocumentsDirectory();
final file =File('${dir.path}/${reference.name}');

await reference.writeToFile(file);
ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('downloaded sucessfull',style: TextStyle(fontSize: 25.0),)));
}
}

class BusCard extends StatefulWidget {
  const BusCard({Key? key}) : super(key: key);

  @override
  State<BusCard> createState() => _BusCardState();
}

class _BusCardState extends State<BusCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue[700], borderRadius: BorderRadius.circular(12)),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SOURCE',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    Text(
                      // data['src_name']!,
                      'source_name',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      // data['src_town']!,
                      'Town_name',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Text(
                  '→',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'DESTINATION',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    Text(
                      // data['des_name']!,
                      'destination_name',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      // data['des_town']!,
                      'town_name',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Icon(
                  Icons.directions,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    // data['distance'].toString() +
                    '5'+
                        ' KM, via ' +
                        // data['inter_towns']!,
                        'city',
                    maxLines: 2,
                    // overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Icon(
                  Icons.directions_bus,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  // data['brand']! +
                  'bus_No'+
                      ', ' +
                      // data['chair_count'].toString() +
                      'driver_name',
                  // ['Non-AC', 'AC'][data['ac']!],
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  // data['start_time'].toString(),
                  'start_time',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Icon(
                  Icons.timelapse_rounded,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  // data['duration'].toString(),
                  'duration',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




