import 'package:ez_notes/models/user.dart';
import 'package:firedart/firedart.dart';
import 'package:ez_notes/models/brew.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid = ''});

  // collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  //TODO: update les collections pour les notes, catégories, reminders, settings, etc
  Future updateUserData(String name, String sugars, int strength) async {
    return await brewCollection.document(uid).set({
      'name': name,
      'sugars': sugars,
      'strength': strength,
    });
  }

  // get brew list form document list
  List<Brew> _brewListFromDocumentList(List<Document> documents) {
    return documents.map((doc) {
      return Brew(
          name: doc['name'] ?? '',
          sugars: doc['sugars'] ?? '0',
          strength: doc['strength'] ?? 0);
    }).toList();
  }

  // userData from document
  UserData _userDataFromDocument(Document? doc) {
    return UserData(
      uid: uid,
      name: doc?['name'],
      sugars: doc?['sugars'],
      strength: doc?['strength'],
    );
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.stream.map(_brewListFromDocumentList);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).stream.map(_userDataFromDocument);
  }
}
