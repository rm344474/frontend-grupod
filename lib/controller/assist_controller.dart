import 'package:abctechapp/model/assist.dart';
import 'package:abctechapp/services/assist_service.dart';
import 'package:get/get.dart';

class AssistController extends GetxController with StateMixin<List<Assist>> {
  late AssistService _service;
  List<Assist> allAssists = [];
  List<Assist> selectedAssists = [];
  @override
  void OnInit() {
    super.onInit();
    _service = Get.find<AssistService>();
    selectedAssists = Get.arguments;

    getAssistList();
  }

  void getAssistList() {
    change([], status: RxStatus.loading());
    _service.getAssists().then((value) {
      allAssists = value;
      change(value, status: RxStatus.success());
    }).onError((error, stackTrace) {
      change([], status: RxStatus.error(error.toString()));
    });
  }

  bool isSelected(int index) {
    Assist assistance = allAssists[index];
    int indexFound =
        selectedAssists.indexWhere((element) => element.id == assistance.id);
    return indexFound != -1;
  }

  void selectAssist(int index) {
    if (!isSelected(index)) {
      selectedAssists.add(allAssists[index]);
    } else {
      selectedAssists.remove(allAssists[index]);
    }

    change(allAssists, status: RxStatus.success());
  }
}
