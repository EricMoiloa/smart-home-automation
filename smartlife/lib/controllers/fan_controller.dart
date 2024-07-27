import 'package:get/get.dart';
import '../Api services/fan_control.dart';



class FanController extends GetxController {
  final _isOn = false.obs;

  bool get isOn => _isOn.value;

  final FanService fanService; // Injected dependency

  FanController({required this.fanService});

  void toggleSwitch() {
    _isOn.value = !_isOn.value;
    fanService.setFanStatus(_isOn.value ? 'on' : 'off');
  }
}
