import 'package:flutter/widgets.dart';
import 'package:abctechapp/model/assist.dart';
import 'package:abctechapp/provider/assist_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AssistServiceInterface {
  Future<List<Assist>> getAssists();
  Future<AssistServiceInterface> init(AssistProviderInterface provider);
}

class AssistService extends GetxService implements AssistServiceInterface {
  late AssistProviderInterface assistProvider;

  @override
  Future<List<Assist>> getAssists() async {
    Response response = await assistProvider.getAssists();
    if (response.hasError) {
      return Future.error(ErrorDescription("Erro na conexão"));
    }
    try {
      List<Assist> listResult =
          response.body.map<Assist>((item) => Assist.fromMap(item)).toList();

      return Future.sync(() => listResult);
    } catch (e) {
      e.printInfo();
      return Future.error(ErrorDescription("Erro não esperado"));
    }
  }

  @override
  Future<AssistServiceInterface> init(AssistProviderInterface provider) async {
    assistProvider = provider;
    return this;
  }
}
