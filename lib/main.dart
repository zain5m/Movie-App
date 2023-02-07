import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/blocApp/app_bloc.dart';
import 'package:move/core/services/services_locator.dart';
import 'package:move/core/utils/global/constent.dart';
import 'package:move/layout/layoyt_app.dart';

void main() {
  ServicesLocator().init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AppBloc>(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: colorScaffoldBG,
        appBarTheme: AppBarTheme(
          color: colorAppBar,
        ),
      ),
      home: LayoutApp(),
    );
  }
}

Widget itemNavigationBar({
  required IconData icon,
  required bool tap,
  required Function() onTap,
}) {
  return InkResponse(
    onTap: onTap,
    child: Container(
      height: 35,
      width: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0XFF181823),
        boxShadow: tap
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 15,
                  offset: Offset(-8, -5),
                ),
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  offset: Offset(5, 6),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  offset: Offset(-3, -3),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(3, 3),
                ),
              ],
      ),
      child: Icon(
        icon,
        size: 25,
        shadows: tap
            ? [
                Shadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(15, 5),
                ),
                Shadow(
                  color: Color(0XFF181823),
                  blurRadius: 50,
                  offset: Offset(-10, -4),
                ),
              ]
            : null,
      ),
    ),
  );
}
