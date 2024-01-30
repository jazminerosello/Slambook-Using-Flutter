/*
  Created by: Claizel Coubeili Cepe
  Date: updated April 26, 2023
  Description: Sample todo app with Firebase 
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/slambook_model.dart';
import '../api/firebase_slambook_api.dart';

class SlambookProvider with ChangeNotifier {
  late FirebaseRecordAPI firebaseService;
  late Stream<QuerySnapshot> _recordStream;

  SlambookProvider() {
    firebaseService = FirebaseRecordAPI();
    fetchRecs();
  }

  // getter
  Stream<QuerySnapshot> get record => _recordStream;

  fetchRecs() {
    _recordStream = firebaseService.getAllSlambook();
    notifyListeners();
  }

  //method to add tas ang ipapasa sa addSlambook ay nakajson format na item na
  void addRecord(SlambookRecord item) async {
    String message = await firebaseService.addSlambook(item.toJson(item));
    print(message);

    notifyListeners();
  }

  //for edit, tas ang ipapasa is 'yung temp na instance ng Slambook
  void editRecord(String id, SlambookRecord temp) async {
    String message = await firebaseService.editSlambook(id, temp);
    print(message);
    notifyListeners();
  }

//for deleting
  void deleteRecord(String id) async {
    String message = await firebaseService.deleteSlambook(id);
    print(message);
    notifyListeners();
  }
}
