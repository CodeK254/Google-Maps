import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:locations/app/controllers/map_controller.dart';
import 'package:locations/app/views/map.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: "/",
          page: () => LocationMaps(),
          binding: BindingsBuilder(() {
            Get.lazyPut<MapController>(() => MapController());
          })
        ),
      ],
    )
  );
}