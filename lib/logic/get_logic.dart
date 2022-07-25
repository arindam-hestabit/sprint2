import 'package:get/get.dart';

class TitleController extends GetxController {
  RxInt _data = 0.obs;

  RxInt get data => _data;

  void inc() {
    _data++;
  }
}
