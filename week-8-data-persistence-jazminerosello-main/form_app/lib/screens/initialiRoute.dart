import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/slambook_model.dart';
import '../screens/slambook.dart';
import 'package:provider/provider.dart';

// import '../package:provider/provider.dart';
import '../provider/slambook_provider.dart';
// import 'package:animated_background/animated_background.dart';
import 'thirdRoute.dart';

class InitialRoute extends StatefulWidget {
  static const routename = '/friendsPage';
  const InitialRoute({super.key});

  @override
  State<InitialRoute> createState() => InitialRouteState();
}

class InitialRouteState extends State<InitialRoute> {
  static const routename = '/friendsPage';

  List<Map<String, dynamic>> friendsList = []; //list of map na pagstore-an ng
  String? newNickname;
  int? newAge;
  bool _isSwitch = false;
  String? power;
  String? newMotto;
  double _currentSliderValue = 0;
  final _fk = GlobalKey<FormState>();

  static final List<String> _dropdownOptions = [
    "Makalipad",
    "Maging Invisible",
    "Mapaibig siya",
    "Mapabago ang isip niya",
    "Mapalimot siya",
    "Mabalik ang nakaraan",
    "Mapaghiwalay sila",
    "Makarma siya",
    "Mapasagasaan siya sa pison",
    "Mapaitim ang tuhod ng iniibig niya"
  ];

  static final Map<String, bool> _motto = {
    "Haters gonna hate": true,
    "Bakers gonna Bake": false,
    "If cannot be, borrow one from three": false,
    "Less is more, more or less": false,
    "Better late than sorry": false,
    "Don't talk to strangers when your mouth is full": false,
    "Let's burn the bridge when we get there": false
  };


  @override
  Widget build(BuildContext context) {
    
    Stream<QuerySnapshot> recordsStream = context.watch<SlambookProvider>().record;

    return Scaffold(
        drawer: Drawer(
            //for the drawer
            child: ListView(padding: EdgeInsets.zero, children: [
          SizedBox(height: 60),
          ListTile(
            title: const Text('Friends', style: TextStyle(fontFamily: "DancingScript-VariableFont_wght", color: Colors.white, fontSize: 29),),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Slambook', style: TextStyle(fontFamily: "DancingScript-VariableFont_wght", color: Colors.white, fontSize: 29),),
            //kapag pinindot yung slambook sa drawer mag asyn then magwait para sa irireturn ng slambook na list of map
            onTap: () async {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Slambook()));
            },
          )
        ])),
        
        appBar: AppBar(
          title: const Text('Friends Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, fontFamily: "DancingScript-VariableFont_wght", color: Colors.white)),
        ),
        body: StreamBuilder(
          stream: recordsStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error encountered! ${snapshot.error}"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data?.docs.length == 0) {
              return Center(
                child: Column(children: [
                SizedBox(height: 90),
                Text("No Friends yet!", style: TextStyle(fontSize: 47, fontWeight: FontWeight.bold, fontFamily: "DancingScript-VariableFont_wght", color: Colors.black),),
                Image.network('https://media.tenor.com/VMPjx96bIbUAAAAi/bella-tontonbella.gif',
                width: 300, //for the image or gif 
                height: 400)])
                      
              );
            }

            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: ((context, index) {
                SlambookRecord rec = SlambookRecord.fromJson(snapshot.data?.docs[index].data() as Map<String, dynamic>); //kunin yung mga instances of objects na nasa firebase
                rec.id = snapshot.data?.docs[index].id;
                return Dismissible(
                  key: Key(rec.id.toString()),
                  onDismissed: (direction) {
                    //to delete
                    context.read<SlambookProvider>().deleteRecord(rec.id!);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            '${rec.name} is deleted in the record of the slambook')));
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.black),
                  ),
                  child: ListTile(
                      title: Text(rec.name.toString(), style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: "DancingScript-VariableFont_wght", color: Colors.black),),
                      leading: Icon(Icons.people, color: Colors.black),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () { 
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                          backgroundColor: Color.fromARGB(255, 227, 219, 242),
                                          title: Text('Edit Details of ${rec.name}', style: TextStyle(fontFamily: "DancingScript-VariableFont_wght", color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                                          content: StatefulBuilder(builder:(BuildContext context,StateSetter setState) { //use this one para mapagana setState inside the alertdialog
                                            return SingleChildScrollView(
                                                child: Form(
                                                 key: _fk,
                                                 child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          "current nickname in the record is ${rec.nickname}",
                                                      hintStyle: TextStyle(fontSize: 20, fontFamily: "Caveat", color: Colors.black), //eto yung nakalgay sa loob ng paglalagyan ng user input
                                                      labelText: "Nickname",
                                                      labelStyle: TextStyle(fontSize: 20, fontFamily: "Caveat", color: Colors.black),
                                                    ),
                                                    onChanged: (String value) {
                                                      newNickname = value;
                                                    },
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                const Divider(),
                                                Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                          width: 115,
                                                          child: TextFormField(
                                                            decoration:
                                                                InputDecoration(
                                                              border:OutlineInputBorder(),
                                                              hintText:"Current age in the record is ${rec.age}", //eto yung nakalgay sa loob ng paglalagyan ng user input
                                                              hintStyle: TextStyle(fontSize: 20, fontFamily: "Caveat", color: Colors.black),
                                                              labelText: "Age",
                                                              labelStyle: TextStyle(fontSize: 20, fontFamily: "Caveat", color: Colors.black),
                                                            ),
                                                            keyboardType:
                                                                TextInputType.number, //to limit and make sure that user will input numbers only
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.digitsOnly
                                                            ],
                                                            onChanged:
                                                                (String value) {
                                                              newAge =int.parse(value);
                                                            },
                                                            //validate if null or empty is the textfield, if it is then display prompt mesage
                                                            validator: (value) {
                                                              if (value ==null ||value.isEmpty) {
                                                                return 'Enter Valid Number';
                                                              }
                                                              return null;
                                                            },
                                                          )),

                                                      //to display the in a relationship text beside the switch button
                                                      Text("In a relationship",
                                                          style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold, fontFamily: "Caveat", color: Colors.black)),
                                                      //for the switch button
                                                      Switch(
                                                        //designs and layout of the switch button
                                                        activeColor: Colors.amber,
                                                        activeTrackColor: Colors.cyan,
                                                        inactiveThumbColor:Colors.blueGrey.shade600,
                                                        inactiveTrackColor: Colors.grey.shade400,
                                                        splashRadius: 50.0,
                                                        value: rec.inRelationship, //set value as isSwitch which is a boolean intiialized as false
                                                        onChanged: (value) =>
                                                            setState(() {
                                                          rec.inRelationship =value;
                                                        }),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Divider(),
                                                Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Text("HAPPINESS LEVEL",
                                                      style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20, fontFamily: "Caveat", color: Colors.black)),
                                                ),
                                                Text(
                                                    "On a scale of 1-Happy, gaano kasaya ang adulting?",
                                                    style: TextStyle(fontSize: 18, fontFamily: "Caveat", color: Colors.black)),
                                                Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Slider(
                                                    min: 0, //set minimun as 0
                                                    value: rec.happiness_level, //set the initialized point where the slider points to the currentSliderValue or 1
                                                    max: 10, //set maximum as 10
                                                    divisions: 10,
                                                    label: rec.happiness_level.round().toString(),
                                                    onChanged: (double value) {
                                                      setState(() {
                                                        rec.happiness_level =value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                const Divider(),
                                                Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Text("SUPERPOWER",
                                                      style: TextStyle(
                                                          fontWeight:FontWeight.bold,fontSize: 20, fontFamily: "Caveat", color: Colors.black)),
                                                ),

                                                Text(
                                                    "If you were to have a superpower,\n what would you choose?",
                                                    style: TextStyle(
                                                        fontSize: 20, fontFamily: "Caveat", color: Colors.black)),

                                                //for the dropdownButton use also a .map function to iterate over the map
                                                Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child:
                                                      DropdownButtonFormField<String>(
                                                        dropdownColor: Colors.blue[50],
                                                    value: rec.superpower,
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        power =value!; //store the value to the superpower key in summary map
                                                      });
                                                    },
                                                    //for the items in the dropdown
                                                    items: _dropdownOptions.map<DropdownMenuItem<String>>((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value, style:  TextStyle(
                                                        fontSize: 20, fontFamily: "Caveat", color: Colors.black)),
                                                        );
                                                      },
                                                    ).toList(),
                                                    //for onSaved, store the newValue to the summary superpower key
                                                    onSaved: (newValue) {
                                                      power = newValue;
                                                    },
                                                  ),
                                                ),
                                                const Divider(),
                                                Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Text("Motto",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20, fontFamily: "Caveat", color: Colors.black)),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: _motto.entries
                                                      .map((entry) {
                                                    return Row(
                                                      children: [
                                                        Radio(
                                                           fillColor: MaterialStateColor.resolveWith(
                  (states) => Color.fromARGB(255, 6, 6, 6)),
                                                          value: entry.key,
                                                          groupValue: rec.motto,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              rec.motto = value.toString();
                                                              _motto[entry.key] = false;
                                                              _motto[value.toString()] =true;
                                                            });
                                                          },
                                                        ),
                                                        Expanded(child: Text(entry.key, style: TextStyle(fontFamily: "Caveat", color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold))),
                                                      ],
                                                    );
                                                  }).toList(),
                                                )
                                              ]),
                                            ));
                                          }),
                                          actions: [
                                            TextButton(
                                              child: Text('Save',  style: TextStyle(
                                                        fontSize: 22, fontFamily: "Caveat",color: Colors.black, fontWeight: FontWeight.bold)),
                                              onPressed: () {
                                              //since not all fields are required to be filled out, these ifs would met the condition na
                                              //kapag may sagot si user in a certain field, 'yung na-assign sa mga varibales na value iaassign sa rec. para rekta lagay nalang ng ganon
                                              //sa instance ng slambookrecord
                                                if(newNickname != null){rec.nickname = newNickname;}
                                                if(newAge != null){rec.age = newAge;}
                                                if(power != null){rec.superpower = power;}
                                                   SlambookRecord temp =
                                                    SlambookRecord(
                                                        name: rec.name,
                                                        nickname: rec.nickname,
                                                        age: rec.age,
                                                        inRelationship:rec.inRelationship,
                                                        happiness_level: rec.happiness_level,
                                                        superpower: rec.superpower,
                                                        motto: rec.motto);
                                                context.read<SlambookProvider>().editRecord(rec.id!, temp);
                                                Navigator.of(context).pop();
                                              }
                                            ),
                                            TextButton(
                                              child: Text('Cancel', style: TextStyle(
                                                        fontSize: 22, fontFamily: "Caveat", color: Colors.black, fontWeight: FontWeight.bold)),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ]));
                            },
                            icon: const Icon(Icons.create_outlined, color: Colors.black),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<SlambookProvider>().deleteRecord(rec.id!);
                            },
                            icon: const Icon(Icons.delete, color: Colors.black),
                          ),
                          
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ThirdRoute(sum: rec)));
                      }
                      ),

                );
              
              }
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              //para mapunta sa slambook use async wait tapos wiat sa iririturn ng slambook then access each elements sa result thenadd yon sa friendsList
              var result = await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Slambook()));
            },
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            child: const Icon(Icons.book, color: Colors.black)));
  }
}
