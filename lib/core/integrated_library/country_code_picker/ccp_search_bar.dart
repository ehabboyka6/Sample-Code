import 'package:fl_country_code_picker/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:horsehouse/core/utils/app_constants.dart';
import 'package:horsehouse/core/utils/app_string.dart';
import 'package:horsehouse/core/widget/custom_text_form_field.dart';

import '../../global/localization/app_localization.dart';
import '../../utils/enums.dart';

/// {@template ccp_search_bar}
/// The default modal search bar widget that can be customized by supplying
/// the [decoration] parameter.
/// {@endtemplate}
class CcpSearchBar extends StatelessWidget {
  /// {@macro search_bar}
  const CcpSearchBar({
    Key? key,
    this.onChanged,
    this.decoration,
    this.style,
  }) : super(key: key);

  /// Callback function on query changed.
  final void Function(String)? onChanged;

  /// {@macro search_bar_decoration}
  final InputDecoration? decoration;

  /// {@macro search_bar_text_style}
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CustomTextFormField(
        labelText: tr(AppString.country),
        prefixIconTextFieldState:IconTextFieldState.search ,
        onChanged: onChanged,
        // decoration: decoration ?? kInputDecoration,
        keyboardType: TextInputType.text,
        // style: style,
      ),
    );
  }
}
