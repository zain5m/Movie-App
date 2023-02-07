import 'package:flutter/material.dart';
import 'package:move/core/utils/size_config.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: SizedBox(
        height: getProportionateScreenHeight(24),
        width: getProportionateScreenWidth(24),
        child: const CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
