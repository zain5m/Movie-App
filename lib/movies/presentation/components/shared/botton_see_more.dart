import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move/core/utils/app_string.dart';
import 'package:move/core/utils/global/components.dart';
import 'package:move/core/utils/size_config.dart';

class BottomSeeMore extends StatelessWidget {
  final Widget nextPage;
  final String text;
  const BottomSeeMore({
    Key? key,
    required this.nextPage,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      margin: EdgeInsets.fromLTRB(
        getProportionateScreenWidth(14.0),
        getProportionateScreenHeight(24.0),
        getProportionateScreenWidth(14.0),
        getProportionateScreenHeight(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: SizeConfig.screentext * 19,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: () {
              navigatorTo(context, nextPage);
            },
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
              child: Row(
                children: const [
                  Text(
                    AppString.seeMore,
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
