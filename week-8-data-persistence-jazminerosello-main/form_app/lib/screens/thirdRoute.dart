import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_app/model/slambook_model.dart';
import 'package:provider/provider.dart';
import '../provider/slambook_provider.dart';

class ThirdRoute extends StatelessWidget {
  static const routename = '/friendsInfo';
  ThirdRoute({super.key, required this.sum});
  final SlambookRecord sum; //map or storage nung ipapasa ng initialiRoute.dart na instance ng slambookRecord

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text('Friends Information',style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, fontFamily: "DancingScript-VariableFont_wght", color: Colors.white))),
        body: Center(
          child: Column(children: [
              SizedBox(height: 100),
              Icon(Icons.people, color: Colors.black), //for the icon

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        //column for the name, nickname etc.
                        Text("Name:\t",
                            style: TextStyle(fontSize: 22,fontWeight:FontWeight.bold, fontFamily: "Caveat", color: Colors.black)),
                        Text("Nickname:\t",
                            style: TextStyle(fontSize: 22,fontWeight:FontWeight.bold, fontFamily: "Caveat", color: Colors.black)),
                        Text("Age:\t",
                            style: TextStyle(fontSize: 22,fontWeight:FontWeight.bold, fontFamily: "Caveat", color: Colors.black)),
                        Text("In Relationship:\t",
                            style: TextStyle(fontSize: 22,fontWeight:FontWeight.bold, fontFamily: "Caveat", color: Colors.black)),

                        Text("Happiness:\t",
                            style: TextStyle(fontSize: 22,fontWeight:FontWeight.bold, fontFamily: "Caveat", color: Colors.black)),
                        Text("Superpower:\t",
                            style: TextStyle(fontSize: 22,fontWeight:FontWeight.bold, fontFamily: "Caveat", color: Colors.black)),
                        Text("Motto in Life:\t",
                            style: TextStyle(fontSize: 22,fontWeight:FontWeight.bold, fontFamily: "Caveat", color: Colors.black)),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //to display the value na align sa 1st column
                        Expanded(
                            flex: 0,
                            child: Text('${sum.name}',
                                style: TextStyle(fontSize: 22, fontFamily: "Caveat", color: Colors.black)),),
                        Expanded(
                            flex: 0,
                            child: Text('${sum.nickname}',
                              style: TextStyle(fontSize: 22, fontFamily: "Caveat", color: Colors.black)),),
                        Expanded(
                            flex: 0,
                            child: Text('${sum.age}',
                                style: TextStyle(fontSize: 22, fontFamily: "Caveat", color: Colors.black)),),
                         Expanded(
                            flex: 0,
                            child: Text('${sum.inRelationship}',
                               style: TextStyle(fontSize: 22, fontFamily: "Caveat", color: Colors.black)),),
                        Expanded(
                            flex: 0,
                            child: Text('${sum.happiness_level}',
                                style: TextStyle(fontSize: 22, fontFamily: "Caveat", color: Colors.black)),),
                        Expanded(
                            flex: 0,
                            child: Text('${sum.superpower}',
                                style: TextStyle(fontSize: 22, fontFamily: "Caveat", color: Colors.black)),),
                        Expanded(
                          flex: 0,
                            child: Text('${sum.motto}',
                                style: TextStyle(fontSize: 22, fontFamily: "Caveat", color: Colors.black)),),
                      ]),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                
                onPressed: () {
                  
                  Navigator.pop(context,"Go back");
                   //button go back para kapag pinindot  mapapop yung current top of stock tas babalik doon sa dating screen
                },
                child: const Text('Go back!', style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold, fontFamily: "Caveat", color: Colors.black)),
              ),
            ]),
          ),
        );
  }
}
