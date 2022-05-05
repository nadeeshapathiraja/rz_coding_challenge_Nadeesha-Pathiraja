import 'package:cloud_firestore/cloud_firestore.dart';

class InstancesUsers {
  //Firestore instance create
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called category that references the firestore collection
  CollectionReference players =
      FirebaseFirestore.instance.collection('players');

  //Get All Team data
  // Stream<QuerySnapshot> userStream(String selectedId) =>
  //     FirebaseFirestore.instance.collection('players').snapshots();

//Load all users
  Stream<QuerySnapshot> userStream(String selectedId) =>
      players.where('team_id', isEqualTo: selectedId).snapshots();

// load single user data
  Stream<QuerySnapshot> SelecteduserStream(String userId) =>
      players.where('id', isEqualTo: userId).snapshots();
}
