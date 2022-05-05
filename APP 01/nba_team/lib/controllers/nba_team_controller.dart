import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:nba_team/providers/nba_team_provider.dart';
import 'package:provider/provider.dart';

class Instances {
  //Firestore instance create
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called category that references the firestore collection
  CollectionReference teams = FirebaseFirestore.instance.collection('teams');

  //Get All Team data
  Stream<QuerySnapshot> testStream() =>
      FirebaseFirestore.instance.collection('teams').snapshots();
}
