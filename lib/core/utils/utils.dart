import 'package:horsehouse/core/utils/enums.dart';

import 'app_assets.dart';

Map<IconTextFieldState, String?> iconTextFieldPath = {
  IconTextFieldState.empty: null,
  IconTextFieldState.email: AppAssets.emailSvg,
  IconTextFieldState.obscure: AppAssets.eyeCloseSvg,
  IconTextFieldState.notObscure: AppAssets.eyeOpenSvg,
  IconTextFieldState.search: AppAssets.searchSvg,
  IconTextFieldState.failure: AppAssets.failureSvg,
  IconTextFieldState.clear: AppAssets.closeSquareSvg,
  IconTextFieldState.calender: AppAssets.calendar,
  IconTextFieldState.clock: AppAssets.clock,
  IconTextFieldState.lock: AppAssets.lockSvg,
  IconTextFieldState.country: AppAssets.country,
  IconTextFieldState.person: AppAssets.profileSvg,
};


