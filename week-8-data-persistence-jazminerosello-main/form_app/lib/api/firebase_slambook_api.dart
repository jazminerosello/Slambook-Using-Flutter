import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_app/model/slambook_model.dart';

class FirebaseRecordAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  //para kapag mag-Add ng record
  Future<String> addSlambook(Map<String, dynamic> rec) async {
    try {
      await db.collection("Slambook").add(rec);
      return "Successfully added to slambook!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  //to get the collection in database
  Stream<QuerySnapshot> getAllSlambook() {
    return db.collection("Slambook").snapshots();
  }

  //for deleting 
  Future<String> deleteSlambook(String? id) async {
    try {
      await db.collection("Slambook").doc(id).delete();

      return "Successfully deleted a record!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  //for edigint 
  Future<String> editSlambook(String? id, SlambookRecord temp) async {
    try {
      // print("New String: $title");
      await db.collection("Slambook").doc(id).update({
        "nickname": temp.nickname, 
        "age": temp.age,
        "inRelationship": temp.inRelationship,
        "superpower": temp.superpower,
        "motto": temp.motto,
        "happiness_level": temp.happiness_level
      });

      return "Successfully edited a record!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
