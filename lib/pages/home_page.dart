import 'package:abctechapp/controller/assist_controller.dart';
import 'package:abctechapp/model/assist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class HomePage extends GetView<AssistController> {
  const HomePage({super.key});

  Widget renderAssist(List<Assist> assist) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: assist.length,
        itemBuilder: ((context, index) =>
            ListTile(title: Text(assist[index].name))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de serviços'),
      ),
      body: Container(
          constraints: const BoxConstraints(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: const [
                  Expanded(
                      child: Text('Os serviços disponiveis são: ',
                          textAlign: TextAlign.center))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                    onPressed: controller.getAssistList,
                    child: const Text('Recarregar'),
                  ))
                ],
              ),
              controller.obx((state) => renderAssist(state ?? []),
                  onEmpty: const Text('Nenhum'),
                  onError: (error) => Text(error.toString()))
            ],
          )),
    );
    throw UnimplementedError();
  }
}
