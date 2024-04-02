import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khodecamp/versions/pages/home_page.dart';
import 'package:upgrader/upgrader.dart';

import 'versions/bloc/app_version/app_version_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppVersionCubit, AppVersionState>(
      listener: (context, state) async {
        if (state is AppVersionLoaded) {
          if (state.data.priority == 2) {
            await Upgrader.clearSavedSettings();
          }
        }
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder<AppVersionCubit, AppVersionState>(
          builder: (context, state) {
            if (state is AppVersionLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AppVersionLoaded) {
              return UpgradeAlert(
                showLater: false,
                showIgnore: state.data.priority == 1,
                dialogStyle: switch (Platform.operatingSystem) {
                  'android' => UpgradeDialogStyle.material,
                  _ => UpgradeDialogStyle.cupertino,
                },
                upgrader: Upgrader(
                  durationUntilAlertAgain: const Duration(seconds: 0),
                  debugLogging: true,
                  minAppVersion: state.data.minAppVersion,
                  storeController: UpgraderStoreController(
                    onAndroid: () => UpgraderAppcastStore(
                      appcastURL: state.data.appCastUrl,
                    ),
                    oniOS: () => UpgraderAppcastStore(
                      appcastURL: state.data.appCastUrl,
                    ),
                  ),
                ),
                child: HomePage(version: state.data.version),
              );
            }
            return const HomePage();
          },
        ),
      ),
    );
  }
}
