import 'package:abctechapp/controller/assist_controller.dart';
import 'package:abctechapp/model/assist.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class HomePage extends GetView<AssistController> {
  const HomePage({Key? key}) : super(key: key);
  Widget renderAssist(List<Assist> list) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(list[index].name),
              selectedColor: Colors.blueAccent,
              selected: controller.isSelected(index),
              onTap: () {
                controller.selectAssist(index);
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupo D - Lista de serviços e assistencias'),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: const [
                  Expanded(
                      child: Text("Os serviços disponiveis são: ",
                          textAlign: TextAlign.center))
                ],
              ),
              controller.obx((state) => renderAssist(state ?? []),
                  onLoading: const Text("Carregando"),
                  onEmpty: const Text('Nenhum'),
                  onError: (error) => Text(error.toString()))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => controller.getAssistList(),
          child: const Icon(Icons.refresh)),
    );
  }
}
