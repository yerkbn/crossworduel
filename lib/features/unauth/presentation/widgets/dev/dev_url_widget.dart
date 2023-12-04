import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crossworduel/config/network/custom_dio.dart';
import 'package:crossworduel/config/network/network_config.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';

class DevUrlWidget extends StatefulWidget {
  const DevUrlWidget({super.key});

  @override
  State<DevUrlWidget> createState() => _DevUrlWidgetState();
}

class _DevUrlWidgetState extends State<DevUrlWidget> {
  String _apiUrl = "";
  String _socketUrl = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                _apiUrl = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'API URL',
              fillColor: Colors.black,
            ),
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                _socketUrl = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Socket',
              fillColor: Colors.black,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomButton.h2(
            title: "Configure URL",
            onPressed: () {
              setState(() {
                if (_apiUrl.isNotEmpty) {
                  globalSL<CustomUnauthDio>().backendUrl = _apiUrl;
                  globalSL<CustomAuthDio>().backendUrl = _apiUrl;
                  globalSL<CustomUnauthDio>().dio.options.baseUrl = _apiUrl;
                  globalSL<CustomAuthDio>().dio.options.baseUrl = _apiUrl;
                }
                if (_socketUrl.isNotEmpty) {
                  globalSL<NetworkConfig>().globalBattleSocket = _socketUrl;
                  _socketUrl;
                }
              });
            },
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
