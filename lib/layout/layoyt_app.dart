import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/blocApp/app_bloc.dart';
import 'package:move/core/utils/global/color_constance.dart';
import 'package:move/core/utils/size_config.dart';
import 'package:move/layout/components/item_navigation_bar_component.dart';
import 'package:move/main.dart';

class LayoutApp extends StatelessWidget {
  LayoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return state.screens[state.currentIndex];
        },
      ),
      bottomNavigationBar: Material(
        elevation: 8,
        color: ColorConstance.colorbottomNavBar,
        child: Align(
          alignment: Alignment.bottomCenter,
          heightFactor: 1,
          child: SizedBox(
            width: SizeConfig.screenHeight,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: kBottomNavigationBarHeight +
                      SizeConfig.mediaQueryData.padding.bottom),
              child: Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                type: MaterialType.transparency,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.mediaQueryData.padding.bottom,
                  ),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeBottom: true,
                    child: DefaultTextStyle.merge(
                      overflow: TextOverflow.ellipsis,
                      child: BlocBuilder<AppBloc, AppState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              itemNavigationBar(
                                tap: state.currentIndex == 0,
                                icon: Icons.movie,
                                onTap: () {
                                  context
                                      .read<AppBloc>()
                                      .add(const BottomNavigationBarEvent(0));
                                  // AppBloc()..add(event)
                                },
                              ),
                              itemNavigationBar(
                                tap: state.currentIndex == 1,
                                icon: Icons.tv,
                                onTap: () {
                                  context
                                      .read<AppBloc>()
                                      .add(const BottomNavigationBarEvent(1));
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
