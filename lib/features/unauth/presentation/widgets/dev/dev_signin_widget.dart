import 'package:crossworduel/core/design-system/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/signin/signin_bloc.dart';

class DevSigninWidget extends StatefulWidget {
  final SigninBloc signinBloc;
  const DevSigninWidget({
    super.key,
    required this.signinBloc,
  });

  @override
  State<DevSigninWidget> createState() => _DevSigninWidgetState();
}

class _DevSigninWidgetState extends State<DevSigninWidget> {
  static const String dev = "DEV";

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
          SizedBox(
            height: 10.h,
          ),
          BlocBuilder<SigninBloc, SigninState>(
              bloc: widget.signinBloc,
              builder: (_, SigninState state) {
                final bool isLoading =
                    state is LoadingSigninState && state.from == dev;
                return CustomButton.h2(
                  isLoading: isLoading,
                  title: "Sign in",
                  onPressed: () {
                    widget.signinBloc.add(const LoadingSigninEvent(from: dev));
                    widget.signinBloc.add(ActivateSigninEvent(from: dev));
                  },
                  color: Colors.black,
                );
              }),
        ],
      ),
    );
  }
}
