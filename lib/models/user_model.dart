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
  String name, phone, email, dept;
  String location = "Noida, India";

  HestaBitFriend({
    required this.name,
    required this.phone,
    required this.email,
    required this.dept,
  });
}
