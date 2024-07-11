import 'package:get/get.dart';

class Identity {
  String id;
  RxBool isChecked;
  RxDouble progressValue;

  Identity({
    required this.id,
    bool isChecked = false,
    double progressValue = 0.0,
  })  : isChecked = isChecked.obs,
        progressValue = progressValue.obs;
}