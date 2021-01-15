import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:CoffeeCrew/models/coffee.dart';
import 'package:CoffeeCrew/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference coffeeCollection =
      Firestore.instance.collection('coffees');

  Future updateUserData(
    String sugars,
    String name,
    int strength,
  ) async {
    return await coffeeCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //coffee list from snapshot
  List<Coffee> _coffeelistFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Coffee(
          name: doc.data['name'] ?? '',
          strength: doc.data['strength'] ?? 0,
          sugars: doc.data['sugars'] ?? '0');
    }).toList();
  }

  //userData from snapshot

  UserData _userDatafromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  //get coffees Streams
  Stream<List<Coffee>> get coffees {
    return coffeeCollection.snapshots().map(_coffeelistFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return coffeeCollection
        .document(uid)
        .snapshots()
        .map(_userDatafromSnapshot);
  }
}
