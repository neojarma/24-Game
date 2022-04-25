import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../core/values/assets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(extraMiniIcon),
          const SizedBox(height: 15),
          const SpinKitThreeBounce(
            size: 20,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
