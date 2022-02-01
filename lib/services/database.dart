import 'package:firedart/firedart.dart';

class DatabaseService {
  // collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');
}
