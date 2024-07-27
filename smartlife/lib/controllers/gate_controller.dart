// switch_controller.dart

import 'package:get/get.dart';

import '../Api services/gate_controlapi.dart';


class SwitchController extends GetxController {
  final _isOn = false.obs;

  bool get isOn => _isOn.value;

  final GateService gateService; // Injected dependency

  SwitchController({required this.gateService});

  void toggleSwitch() {
    _isOn.value = !_isOn.value;
    gateService.setGateStatus(_isOn.value ? 'open' : 'close');
  }
}
