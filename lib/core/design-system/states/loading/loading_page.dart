import 'package:crossworduel/core/design-system/loading/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          const CustomLoading(
            progresHeight: 42,
            color: Colors.black,
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: Column(
                children: [
                  const CustomLoading(),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "0.0.1",
                    style: TextStyle(color: Colors.white24, fontSize: 12.h),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
