// switch_controller.dart

import 'package:get/get.dart';
import '../Api services/window_control.dart';

class WindowController extends GetxController {
  final _isOn = false.obs;

  bool get isOn => _isOn.value;

  final WindowService windowService; // Injected dependency

  WindowController({required this.windowService});

  void toggleSwitch() {
    _isOn.value = !_isOn.value;
    windowService.setWindowStatus(_isOn.value ? 'open' : 'close');
  }
}
