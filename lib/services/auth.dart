import 'package:ez_notes/models/user.dart';
import 'package:ez_notes/services/database.dart';
import 'package:firedart/auth/user_gateway.dart';
import 'package:firedart/firedart.dart';
import 'package:ez_notes/services/firebase_options.dart';

class InstFirebase {
  // instanciate firebase
  static init() {
    FirebaseAuth.initialize(
      DefaultFirebaseOptions.web.apiKey,
      VolatileStore(),
    );
    Firestore.initialize(DefaultFirebaseOptions.web.projectId);
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  CustomUser? _userFromFirebaseUser(User? user) {
    return user != null ? CustomUser(uid: user.id) : null;
  }

  // auth change user stream
  Stream<bool> get boolSignInState {
    return _auth.signInState;
  }

  // get user id
  String get userId {
    return _auth.userId;
  }

  // sign-in anonymously
  Future signInAnon() async {
    try {
      User? user = await _auth.signInAnonymously();
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign-in with email & pwd
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      User? result = await _auth.signIn(email, password);
      return _userFromFirebaseUser(result);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & pwd
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      User? result = await _auth.signUp(email, password);

      // create a new document for the user with the uid
      await DatabaseService(uid: result.id)
          .updateUserData('0', 'Entrez un nouveau nom', 100);

      // return the user object
      return _userFromFirebaseUser(result);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign-out
  void signOut() {
    try {
      _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
