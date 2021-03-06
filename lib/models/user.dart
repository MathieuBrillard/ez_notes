class CustomUser {
  final String uid;
  late String email;
  late String name;
  late bool isEmailVerif;

  CustomUser({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String email;

  UserData({required this.uid, required this.name, required this.email});
}
