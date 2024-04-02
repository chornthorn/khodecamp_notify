import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khodecamp/shared/mobile_version.dart';
import 'package:khodecamp/versions/models/app_version_res.dart';
import 'package:khodecamp/versions/repository/app_version_repository.dart';

part 'app_version_state.dart';

class AppVersionCubit extends Cubit<AppVersionState> {
  AppVersionCubit() : super(AppVersionInitial());

  Future<void> check() async {
    emit(AppVersionLoading());
    try {
      // query mobile version by using package info plus
      final queryVersion = await checkVersion();
      final platform = Platform.operatingSystem;

      final result = await checkAppVersion(queryVersion.$1, platform);

      emit(AppVersionLoaded(result));
    } catch (e) {
      emit(AppVersionError(e.toString()));
    }
  }
}
