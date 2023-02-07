import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/blocApp/app_bloc.dart';
import 'package:move/core/services/services_locator.dart';
import 'package:move/core/utils/global/color_constance.dart';
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
        scaffoldBackgroundColor: ColorConstance.colorScaffoldBG,
        appBarTheme: AppBarTheme(
          color: ColorConstance.colorAppBar,
        ),
      ),
      home: LayoutApp(),
    );
  }
}
