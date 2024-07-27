import 'package:get/get.dart';
import '../Api services/living_room_lightsapi.dart';

class LivingRoomLightsController extends GetxController {
  final _isOn = false.obs;

  bool get isOn => _isOn.value;

  final LivingRoomLightsService livingRoomService; // Injected dependency

  LivingRoomLightsController({required this.livingRoomService});

  void toggleSwitch() async {
    final newState = !_isOn.value;
    try {
      await livingRoomService.setLivingRoomLightsStatus(newState);
      _isOn.value =
          newState; // Update state only if the API call was successful
    } catch (e) {
      // Handle the error, maybe revert the state or show a message
      print("Failed to update LED state: $e");
      // Optionally show a user-friendly message or revert the state
    }
  }
}
