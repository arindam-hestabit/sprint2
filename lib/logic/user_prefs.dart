import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint2/models/user_model.dart';

class UserPreferences {
  Future<void> saveData(HestaBitUser user) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('name', user.name);
    prefs.setString('phone', user.phone);
    prefs.setString('email', user.email);
    prefs.setString('dept', user.dept);
    prefs.setInt('id', user.id);
  }

  Future<HestaBitUser> getData() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('name') != null) {
      return HestaBitUser(
          name: prefs.getString('name')!,
          id: prefs.getInt('id')!,
          phone: prefs.getString('phone')!,
          email: prefs.getString('email')!,
          dept: prefs.getString('dept')!);
    } else {
      throw Exception('No user found!');
    }
  }

  Future<dynamic> removeData() async {
    final prefs = await SharedPreferences.getInstance();
  }
}
