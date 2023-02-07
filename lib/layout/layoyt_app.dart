import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/blocApp/app_bloc.dart';
import 'package:move/main.dart';

class LayoutApp extends StatelessWidget {
  LayoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return state.screens[state.currentIndex];
        },
      ),
      bottomNavigationBar: Material(
        elevation: 8,
        color: Color(0XFF1E1E29),
        child: Align(
          alignment: Alignment.bottomCenter,
          heightFactor: 1,
          child: SizedBox(
            width: MediaQuery.of(context).size.height,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: kBottomNavigationBarHeight +
                      MediaQuery.of(context).padding.bottom),
              child: Material(
                // Splashes.
                clipBehavior: Clip.antiAliasWithSaveLayer,
                type: MaterialType.transparency,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom),
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
