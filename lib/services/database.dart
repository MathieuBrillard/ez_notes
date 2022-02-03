import 'package:firedart/firedart.dart';
import 'package:ez_notes/models/brew.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid = ''});

  // collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  //TODO: update les collections pour les notes, catégories, reminders, settings, etc
  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // get brew list form document list
  List<Brew> _brewListFromDocumentList(List<Document> documents) {
    // List<Brew> toReturn = [];
    // for (var row in documents) {
    //   toReturn += [
    //     Brew(
    //         name: row['name'] ?? '',
    //         sugars: row['sugars'] ?? '0',
    //         strength: row['strength'] ?? 0)
    //   ];
    // }
    // return toReturn;

    return documents.map((doc) {
      return Brew(
          name: doc['name'] ?? '',
          sugars: doc['sugars'] ?? '0',
          strength: doc['strength'] ?? 0);
    }).toList();
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.stream.map(_brewListFromDocumentList);
  }
}
