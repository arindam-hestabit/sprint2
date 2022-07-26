// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';
import 'package:sprint2/models/user_model.dart';

class UserController extends GetxController {
  Rxn<HestaBitUser> _bitUser = Rxn<HestaBitUser>();

  set setUser(HestaBitUser inp) => _bitUser.value = inp;

  void resetUser() => _bitUser = Rxn<HestaBitUser>();

  Rxn<HestaBitUser> get getUser => _bitUser;
}
