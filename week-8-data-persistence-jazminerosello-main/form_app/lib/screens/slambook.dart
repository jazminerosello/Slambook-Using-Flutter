import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_app/model/slambook_model.dart';
import 'package:provider/provider.dart';
import '../provider/slambook_provider.dart';
import 'initialiRoute.dart';
// import 'screenArguments.dart';
///import 'friends.dart';

class Slambook extends StatefulWidget {
  const Slambook({super.key});

  @override
  State<Slambook> createState() => _SlambookState();
}

class _SlambookState extends State<Slambook> {
  double _currentSliderValue = 1; //initial where the slider is
  bool isSwitch = false;

  bool isSaved = false;
  int pick = 0;
  //String dropValue = _dropdownOptions.first;
  String mottoVal = "Haters gonna hate";
  String nameVal = "";
  //list of map to store all the data orvalues being submitted
  SlambookRecord? slambookList;

  //varibales na gagamitin for temporary storage ng map or list of map
  String name = "";
  int age = 0;
  double hap_level = 0;
  String superpower = _dropdownOptions.first;
  String nickname = "";
  String mot = "";

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

  //to store the value of all users answers to the form
  Map<String, dynamic> summary = {
    'name': "",
    'nickname': "",
    'age': "",
    //'relationship_status' : false,
    'happiness_level': "",
    'superpower': _dropdownOptions.first,
    'motto': "Haters gonna hate",
  };

  //to be used to limit users when answering in age since it should be just number
  bool get isValidNum {
    final numRanger = RegExp(r"[0-1000]{1000}$");
    return numRanger.hasMatch(this as String);
  }

  final TextEditingController _textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(() {
      //print("Latest Value: ${_textFieldController.text}");
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  //to display the summary which is formed in column and every child of this column is a row
  Widget displayText() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                //column for the name, nickname etc.
                Text("Name:\t",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Caveat",
                        color: Colors.black)),
                Text("Nickname:\t",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Caveat",
                        color: Colors.black)),
                Text("Age:\t",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Caveat",
                        color: Colors.black)),

                Text("Happiness:\t",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Caveat",
                        color: Colors.black)),
                Text("Superpower:\t",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Caveat",
                        color: Colors.black)),
                Text("Motto in Life:\t",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Caveat",
                        color: Colors.black)),
              ]),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //to display the value na align sa 1st column
                Expanded(
                  flex: 0,
                  child: Text('${summary["name"]}',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: "Caveat",
                          color: Colors.black)),
                ),
                Expanded(
                  flex: 0,
                  child: Text('${summary["nickname"]}',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: "Caveat",
                          color: Colors.black)),
                ),
                Expanded(
                  flex: 0,
                  child: Text('${summary["age"]}',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: "Caveat",
                          color: Colors.black)),
                ),
                Expanded(
                  flex: 0,
                  child: Text('${summary["happiness_level"]}',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: "Caveat",
                          color: Colors.black)),
                ),
                Expanded(
                  flex: 0,
                  child: Text('${summary["superpower"]}',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: "Caveat",
                          color: Colors.black)),
                ),
                Expanded(
                  flex: 0,
                  child: Text('${summary["motto"]}',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: "Caveat",
                          color: Colors.black)),
                ),
              ]),
        ]);
  }

  //for the radio button or for motto with the use of .map() function
  Column radioB() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _motto.entries.map((entry) {
        return Row(
          children: [
            Radio(
              value: entry.key,
              fillColor: MaterialStateColor.resolveWith(
                  (states) => Color.fromARGB(255, 6, 6, 6)),
              groupValue: mottoVal,
              onChanged: (value) {
                setState(() {
                  mottoVal = value.toString();
                  _motto[entry.key] = false;
                  _motto[value.toString()] = true;
                });
              },
            ),
            Expanded(
                child: Text(entry.key,
                    style: TextStyle(
                        fontFamily: "Caveat",
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold))),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
          //for mavgar or drawer
          SizedBox(height: 60),
          ListTile(
            title: const Text(
              'Friends',
              style: TextStyle(
                  fontFamily: "DancingScript-VariableFont_wght",
                  color: Colors.white,
                  fontSize: 29),
            ),
            onTap: () {
              Navigator.pop(context);
              // context.read<SlambookProvider>().addTodo(slambookList!);
              Navigator.of(context).pop();
              // Navigator.pop(context, slambookList); //pass the slambookList to the after the top of stack or the screen after you pop this screen

              // print("to add:");
              // print(slambookList);
            },
          ),
          ListTile(
            title: const Text(
              'Slambook',
              style: TextStyle(
                  fontFamily: "DancingScript-VariableFont_wght",
                  color: Colors.white,
                  fontSize: 29),
            ),
            onTap: () {
              Navigator.pop(context);
              //Navigator.pushNamed(context, '/second');
            },
          )
        ])),
        appBar: AppBar(
            title: const Text('Slambook',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: "DancingScript-VariableFont_wght",
                    color: Colors.white))),
        body: SingleChildScrollView(
          child: Form(
            //for the form
            //wrapped in a form
            key: _formKey,
            child: Column(
              children: [
                Divider(
                  thickness: 3,
                  color: Colors.grey,
                ),
                //for the title of the form
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "The Tita Slambook",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Caveat",
                          color: Colors.black),
                    )),

                // textfield for name
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Name",
                      hintStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: "Caveat",
                          color: Colors
                              .black), //eto yung nakalgay sa loob ng paglalagyan ng user input
                      labelText: "Name",
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: "Caveat",
                          color: Colors.black),
                    ),
                    onChanged: (String value) {
                      //store the value the users input in the summary with the key name
                      summary['name'] = value;
                      nameVal = value;
                      name = value;
                    },
                    //validate if the textfield is empty or null, if it is not then print prompt message
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),

                const Divider(),
                //for the textfield for nickname using TextFormField
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Nickname",
                      hintStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: "Caveat",
                          color: Colors
                              .black), //eto yung nakalgay sa loob ng paglalagyan ng user input
                      labelText: "Nickname",
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: "Caveat",
                          color: Colors.black),
                    ),
                    onChanged: (String value) {
                      nickname = value;
                      //when users input value or strings, store it in the summary with the key of nickname
                      summary["nickname"] = value;
                    },
                    //validate if the textfield for this one is empty or null, if it is then propmpt proper message
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),

                const Divider(),
                //textfield for age input
                Padding(
                  padding: EdgeInsets.all(10),
                  child:
                      //use row for the part of age, and switch button
                      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 115,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText:
                                "Age", //eto yung nakalgay sa loob ng paglalagyan ng user input
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontFamily: "Caveat",
                                color: Colors.black),
                            labelText: "Age",
                            labelStyle: TextStyle(
                                fontSize: 20,
                                fontFamily: "Caveat",
                                color: Colors.black),
                          ),
                          keyboardType: TextInputType
                              .number, //to limit and make sure that user will input numbers only
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (String value) {
                            age = int.parse(value);
                            //store the value users have input in the summary with the key age
                            summary['age'] = int.parse(value);
                          },
                          //validate if null or empty is the textfield, if it is then display prompt mesage
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Valid Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      //to display the in a relationship text beside the switch button
                      Text("In a relationship",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Caveat",
                              color: Colors.black)),
                      //for the switch button
                      Switch(
                        //designs and layout of the switch button
                        activeColor: Colors.amber,
                        activeTrackColor: Colors.cyan,
                        inactiveThumbColor: Colors.blueGrey.shade600,
                        inactiveTrackColor: Colors.grey.shade400,
                        splashRadius: 50.0,
                        value:
                            isSwitch, //set value as isSwitch which is a boolean intiialized as false
                        onChanged: (value) => setState(
                          () => //if it is clicked then update the isSwitch as the value or true
                              isSwitch = value,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                //for the happiness level text to be displayed and the description below it
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("HAPPINESS LEVEL",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: "Caveat",
                          color: Colors.black)),
                ),
                Text("On a scale of 1-Happy, gaano kasaya ang adulting?",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Caveat",
                        color: Colors.black)),

                //for the slider
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Slider(
                    min: 0, //set minimun as 0
                    value:
                        _currentSliderValue, //set the initialized point where the slider points to the currentSliderValue or 1
                    max: 10, //set maximum as 10
                    divisions: 10,
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                        hap_level =
                            value; //set the currentSliderValue as the value where users put the slider
                      });
                    },
                  ),
                ),
                const Divider(),

                //to display the superpower text adn its description
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("SUPERPOWER",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: "Caveat",
                          color: Colors.black)),
                ),

                Text(
                    "If you were to have a superpower,\n what would you choose?",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Caveat",
                        color: Colors.black)),

                //for the dropdownButton use also a .map function to iterate over the map
                Padding(
                  padding: EdgeInsets.all(10),
                  child: DropdownButtonFormField<String>(
                    dropdownColor: Colors.blue[50],
                    value: _dropdownOptions.first,
                    onChanged: (String? value) {
                      setState(() {
                        superpower =
                            value!; //store the value to the superpower key in summary map
                      });
                    },
                    //for the items in the dropdown
                    items: _dropdownOptions.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Caveat",
                                  color: Colors.black)),
                        );
                      },
                    ).toList(),
                    //for onSaved, store the newValue to the summary superpower key
                    onSaved: (newValue) {
                      summary['superpower'] = newValue;
                    },
                  ),
                ),
                const Divider(),
                //for the motto part
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Motto",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: "Caveat",
                          color: Colors.black)),
                ),
                radioB(), //call the function radioB() to display radiobutton

                //for the submit button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //check if all need to be validated are validated
                      _formKey.currentState
                          ?.save(); //set the state of the form as save
                      isSaved =
                          true; //changed the isSaved as true for displaying the summary using visibility
                      summary['relationship_status'] =
                          isSwitch; //set the value for this key
                      summary['happiness_level'] = _currentSliderValue;
                      summary['motto'] = mottoVal;
                      mot = mottoVal;

                      setState(() {
                        //store the summary or value of summary to the map temp then iyon ang ipasa o ilagay sa list of map na slambookList
                        SlambookRecord temp = SlambookRecord(
                          name: name,
                          nickname: nickname,
                          age: age,
                          inRelationship: isSwitch,
                          happiness_level: hap_level,
                          superpower: superpower,
                          motto: mot,
                        );

                        
                        slambookList = temp;
                        //clear the temp variables
                        name = "";
                        nickname = "";
                        age = 0;
                        hap_level = 0;
                        superpower = _dropdownOptions.first;
                        mot = "";

                        context.read<SlambookProvider>().addRecord(slambookList!); //tawagin addrecord para maiadd sa database
                        isSaved = true;
                        
                      });
                    }
                  },
                  child: const Text('Submit'),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                ),

                const Divider(),
                //to display the summary usng the visibility
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: isSaved == true,
                    child:
                        displayText(), //displayText() is the widget or function that will print all the summary of the users answer
                  ),
                ),

                //button for reset
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState
                        ?.reset(); //set the state of the form as resett
                    isSaved = false;
                    _currentSliderValue = 1;
                    nameVal = "";
                    for (var mo in _motto.entries) {
                      if (_motto[mo] == true) {
                        _motto[mo] == false;
                      }
                    }
                    _motto["Haters gonna hate"] = true;
                    mottoVal = "Haters gonna hate";
                    setState(() => isSwitch = false); //rest the isSwitch
                  },
                  child: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    primary:
                        Color.fromARGB(255, 200, 37, 37), // Background colo
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            child: const Icon(Icons.people)));
  }
}
