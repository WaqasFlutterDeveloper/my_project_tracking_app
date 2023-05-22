import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iub_transport_system/Drawer/contact_us.dart';
import '../../const.dart';
import '../student_main/bus_ schedule.dart';
import 'bus_sechdule.dart';
class DriverInfo extends StatefulWidget {
  const DriverInfo({Key? key}) : super(key: key);

  @override
  State<DriverInfo> createState() => _DriverInfoState();
}

class _DriverInfoState extends State<DriverInfo> {
  String? oldBus = null;
  String? newBus = null;
  String? route = null;
  final _dropdownFormKey = GlobalKey<FormState>();
  final firebase = FirebaseFirestore.instance;
  List<DropdownMenuItem<String>> get dropdownItemsAllocatedBus{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Bus-1"),value: "Bus-1"),
      DropdownMenuItem(child: Text("Bus-2"),value: "Bus-2"),
      DropdownMenuItem(child: Text("Bus-3"),value: "Bus-3"),
      DropdownMenuItem(child: Text("Bus-4"),value: "Bus-4"),
      DropdownMenuItem(child: Text("Bus-5"),value: "Bus-5"),
      DropdownMenuItem(child: Text("Bus-6"),value: "Bus-6"),
      DropdownMenuItem(child: Text("Bus-7"),value: "Bus-7"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsAllocationBus{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Bus-1"),value: "Bus-1"),
      DropdownMenuItem(child: Text("Bus-2"),value: "Bus-2"),
      DropdownMenuItem(child: Text("Bus-3"),value: "Bus-3"),
      DropdownMenuItem(child: Text("Bus-4"),value: "Bus-4"),
      DropdownMenuItem(child: Text("Bus-5"),value: "Bus-5"),
      DropdownMenuItem(child: Text("Bus-6"),value: "Bus-6"),
      DropdownMenuItem(child: Text("Bus-7"),value: "Bus-7"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsRoutes{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("ByPass BWN"),value: "Bus-1"),
      DropdownMenuItem(child: Text("Model Town BWN"),value: "Bus-2"),
      DropdownMenuItem(child: Text("City BWN"),value: "Bus-3"),
    ];
    return menuItems;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Update Driver Info'),
        elevation: .1,
        backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body:  Form(
          key: _dropdownFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Allocate New Bus And New Rotues',style: TextStyle(
                  backgroundColor: Colors.black,
                  color: kAppBarColour
                ),),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kCardColour, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: kCardColour, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: kCardColour,
                        hintText: 'Select Allocated Bus',
                        hintStyle: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      validator: (value) => value == null ? "Select Allocated Bus" : null,
                      dropdownColor: kBackGroundColour,
                      iconEnabledColor: Colors.white,
                      value: oldBus,
                      onChanged: (String? newValue) {
                        setState(() {
                          oldBus = newValue!;
                          // print(selectedValue);
                        });
                      },
                      items: dropdownItemsAllocatedBus),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kCardColour, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: kCardColour, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: kCardColour,
                          hintText: 'Select new Allocation Bus',
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      validator: (value) => value == null ? "Select new Allocation Bus" : null,
                      dropdownColor: kBackGroundColour,
                      value: newBus,
                      iconEnabledColor: Colors.white,
                      onChanged: (String? newValue) {
                        setState(() {
                          newBus = newValue!;
                          // print(selectedValue);
                        });
                      },
                      items: dropdownItemsAllocationBus),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kCardColour, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: kCardColour, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: kCardColour,
                          hintText: 'Select a route',
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      validator: (value) => value == null ? "Select a Route" : null,
                      dropdownColor: kBackGroundColour,
                      iconEnabledColor: Colors.white,
                      value:route,
                      onChanged: (String? newValue) {
                        setState(() {
                          route = newValue!;
                          // print(selectedValue);
                        });
                      },
                      items: dropdownItemsRoutes),
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       if (_dropdownFormKey.currentState!.validate()) {
                //         //valid flow
                //       }
                //     },
                //     child: Text("Submit"))
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kAppBarColour,
        onPressed: () {
          setState(() async{
            print(oldBus);
            print(newBus);
            print(route);
            try {
              final post = await firebase.collection("locations").
              where("Bus-no", isEqualTo: oldBus!)
                  .limit(1)
                  .get()
                  .then((QuerySnapshot snapshot) {
                //Here we get the document reference and return to the post variable.
                return snapshot.docs[0].reference;
              });

              var batch = firebase.batch();
              //Updates the field value, using post as document reference
              batch.update(post, {
                'Bus-no': newBus
              });
              batch.commit();

            } catch (e) {
              print(e);
            }
          });



        },
        label: const Text("Submit"),
      ),
    );
  }
}
// Navigator.push(context,
// MaterialPageRoute(builder: (context) => BusSechedule()));