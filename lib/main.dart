import 'package:abctechapp/pages/home_bind.dart';
import 'package:abctechapp/pages/home_page.dart';
import 'package:abctechapp/pages/order_bind.dart';
import 'package:abctechapp/pages/order_page.dart';
import 'package:abctechapp/provider/assist_provider.dart';
import 'package:abctechapp/services/assist_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  initServices();
  runApp(const MyApp());
}

void initServices() async {
  await Get.putAsync(() => AssistService().init(AssistProvider()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ABC Tech App - Grupo D',
      theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: const TextTheme(
              headline4: TextStyle(color: Color.fromARGB(255, 6, 102, 78)))),
      getPages: [
        GetPage(
            name: "/services",
            page: () => const HomePage(),
            binding: HomeBind()),
        GetPage(name: "/", page: () => const OrderPage(), binding: OrderBind())
      ],
    );
  }
}
