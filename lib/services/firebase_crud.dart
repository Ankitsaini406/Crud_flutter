// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/response.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference collection = firestore.collection('Employee');
class FirebaseCrud {
  //CRUD method here
  static Future<Response> addEmployee({
    required String name,
    required String position,
    required String contactno,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer = collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "employee_name" : name,
      "position" : position,
      "contact_no" : contactno
    };

    var result = await documentReferencer
    .set(data)
    .whenComplete((){
      response.code = 200;
      response.message = "Sucessfully added to database";
    })
    .catchError((e){
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readEmployee(){
    CollectionReference notesItemCollection = collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> updateEmployee({
    required String name,
    required String position,
    required String contactno,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": name,
      "position": position,
      "contact_no": contactno
    };

    await documentReferencer
      .update(data)
      .whenComplete(() {
        response.code = 200;
        response.message = "Sucessfully updated Employee";
      })
      .catchError((e) {
        response.code = 500;
        response.message = e;
      });

      return response;

  }

  static Future<Response> deleteEmployee({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = collection.doc(docId);

    await documentReferencer
      .delete()
      .whenComplete(() {
        response.code = 200;
        response.message = "Sucessfully Deleted Employee";
      })
      .catchError((e) {
        response.code = 500;
        response.message = e;
      });

      return response;
  }
}