
class AppUser {

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.points,


  });

  String uid;
  final String email;
  final String name;
  final int points;




  static AppUser fromJson(Map<String, dynamic> userData) {
    return AppUser(
      uid: userData['uid'] ,
      email: userData['email'],
      name: userData['name'],
      points: userData['points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': this.uid,
      'email': this.email,
      'name' : this.name,
      'points': this.points,
    };
  }
}
