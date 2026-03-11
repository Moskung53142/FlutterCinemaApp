class UserSessionData {
  static String name = "";
  static String lastname = "";
  static String email = "";
  static String password = "";

  static void logout() {
    name = "";
    lastname = "";
    email = "";
    password = "";
  }
}

class UserList {
  final String name;
  final String lastname;
  final String email;
  final String password;

  UserList({
    required this.name,
    required this.lastname,
    required this.email,
    required this.password
  });
}

final List<UserList> userListData = [
  UserList(
    name: "mos", 
    lastname: "kung", 
    email: "moskung@gmail.com", 
    password: "hahaha",
  ),
];
