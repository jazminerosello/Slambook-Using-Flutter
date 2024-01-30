/*
  Created by: Claizel Coubeili Cepe
  Date: updated April 26, 2023
  Description: Sample todo app with Firebase 
*/
import 'dart:convert';

class SlambookRecord {
  String? name;
  String? nickname;
  String? id;
  int? age;
  bool inRelationship;
  double happiness_level;
  String? superpower;
  String? motto;
  

  SlambookRecord({
    required this.name,
    required this.nickname,
    required this.age,
    required this.inRelationship,
    required this.happiness_level,
    required this.superpower,
    required this.motto,
    this.id
  });

  // Factory constructor to instantiate object from json format
  factory SlambookRecord.fromJson(Map<String, dynamic> json) {
    //return a model of the collection in db
    return SlambookRecord(
      id: json['id'],
      name: json['name'],
      nickname: json['nickname'],
      age: json['age'],
      inRelationship: json['inRelationship'],
      motto: json['motto'],
      superpower: json['superpower'],
      happiness_level: json['happiness_level']
    );
  }

  //map the data
  static List<SlambookRecord> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<SlambookRecord>((dynamic d) => SlambookRecord.fromJson(d)).toList();
  }

  //nakamap
  Map<String, dynamic> toJson(SlambookRecord record) {
    return {
      'name': record.name,
      'nickname': record.nickname,
      'age': record.age,
      'inRelationship': record.inRelationship,
      'superpower': record.superpower,
      'happiness_level': record.happiness_level,
      'motto': record.motto,
      
    };
  }
}
