import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bre_crew/model/brew.dart';
class DataBaseService{
  final String uid;
  DataBaseService({this.uid});
  //collection refrence
  final CollectionReference brewCollection=FirebaseFirestore.instance.collection('brews');
  //update user data
Future updateUserData(String sugar,String name,int strength){
  return brewCollection.doc(uid)
      .set({
    'sugar': sugar,
    'name': name,
    'strength': strength
  });

}

// get brew List from querysnapshot

List<Brew> _brewListFromQuerySnapshot(QuerySnapshot snapshot){
  return snapshot.docs.map((document) {
    return Brew(
      sugar: document.data()['sugar']??'0',
      name: document.data()['name'] ?? '',
      strength: document.data()['strength'] ?? 0
    );
  }).toList();
}
// get stream of brews collection
//   Stream<QuerySnapshot> get brews{
//     return brewCollection.snapshots();
//   }
  // instead of above use this after maping
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewListFromQuerySnapshot);
  }

}