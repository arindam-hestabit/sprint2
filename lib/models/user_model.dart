class HestaBitUser {
  int id;
  String name, phone, email, dept;
  String location = "Noida, India";

  HestaBitUser({
    required this.name,
    required this.id,
    required this.phone,
    required this.email,
    required this.dept,
  });
}

class HestaBitFriend {
  String? id;
  String name, phone, email, dept;
  String location = "Noida, India";
  bool _isFav = false;

  HestaBitFriend({
    required this.name,
    required this.phone,
    required this.email,
    required this.dept,
    this.id,
  });

  bool get isFav => _isFav;

  set favMe(bool value) => _isFav = value;

  factory HestaBitFriend.fromJson(Map json) {
    final f = HestaBitFriend(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      dept: json['dept'],
    );

    f.favMe = json['isfav'];

    return f;
  }
}
