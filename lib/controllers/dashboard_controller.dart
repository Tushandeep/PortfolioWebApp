import 'package:get/get.dart';

class DashBoardController extends GetxController {
  final RxInt factor = 0.obs;
  final RxDouble maxScreenHeight = 0.0.obs;
  final RxDouble maxScreenWidth = 0.0.obs;
  final RxDouble currPosOffset = 0.0.obs;
  final RxBool isScrolling = true.obs;
  final RxBool blinking = false.obs;

  final RxBool showSocials = true.obs;
}
