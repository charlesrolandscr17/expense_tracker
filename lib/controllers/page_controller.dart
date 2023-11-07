import 'package:get/get.dart';

class MyPageController extends GetxController {
  var page = 0;

  void changePage(int n) {
    page = n;
    update();
  }
}
