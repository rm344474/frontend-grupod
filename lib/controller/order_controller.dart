import 'package:abctechapp/model/assist.dart';
import 'package:abctechapp/model/order.dart';
import 'package:abctechapp/model/order_create.dart';
import 'package:abctechapp/model/order_location.dart';
import 'package:abctechapp/services/geolocation_service.dart';
import 'package:abctechapp/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

enum OrderState { creating, started, finished }

class OrderController extends GetxController with StateMixin<OrderCreate> {
  final GeolocationServiceInterface geolocationService;
  final OrderServiceInterface orderService;
  final selectedAssistances = <Assist>[].obs;
  final formKey = GlobalKey<FormState>();
  final operatorIdController = TextEditingController();
  final screenState = OrderState.creating.obs;
  late Order _order;

  OrderController(this.geolocationService, this.orderService);

  @override
  void onInit() {
    super.onInit();
    geolocationService.start();
    change(null, status: RxStatus.success());
  }

  Future<Position> _getLocation() async {
    Position position = await geolocationService.getPosition();
    return Future.sync(() => position);
  }

  OrderLocation orderLocationFromPosition(Position position) {
    return OrderLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        dateTime: DateTime.now());
  }

  List<int> getServicesIds() {
    return selectedAssistances.map((e) => e.id).toList();
  }

  finishStartOrder() {
    switch (screenState.value) {
      case OrderState.creating:
        change(null, status: RxStatus.loading());
        _getLocation().then((value) {
          _order = Order(
              operatorId: int.parse(operatorIdController.text),
              services: getServicesIds(),
              start: orderLocationFromPosition(value),
              end: null);
          screenState.value = OrderState.started;
          change(null, status: RxStatus.success());
        });

        break;
      case OrderState.started:
        change(null, status: RxStatus.loading());
        _getLocation().then((value) {
          _order.end = orderLocationFromPosition(value);
          _createOrder();
        });

        break;
      default:
    }
  }

  _createOrder() {
    screenState.value = OrderState.finished;
    orderService.createOrder(_order).then((value) {
      if (value.success) {
        Get.snackbar("Sucesso", "Ordem de serviço criada com sucesso",
            backgroundColor: Colors.greenAccent);
      }
      clearForm();
    }).catchError((error) {
      Get.snackbar("Error", error.toString(),
          backgroundColor: Colors.redAccent);
      clearForm();
    });
  }

  editServices() {
    if (screenState.value != OrderState.creating) {
      return null;
    }
    Get.toNamed("/services", arguments: selectedAssistances);
  }

  void clearForm() {
    screenState.value = OrderState.creating;
    operatorIdController.text = "";
    selectedAssistances.clear();
    change(null, status: RxStatus.success());
  }
}
