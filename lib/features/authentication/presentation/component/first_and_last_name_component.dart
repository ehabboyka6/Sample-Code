import 'package:flutter/material.dart';
import 'package:horsehouse/core/utils/app_string.dart';
import 'package:horsehouse/core/utils/enums.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/custom_text_form_field.dart';
import '../controllers/sign_in_provider.dart';
import '../controllers/sign_up_provider.dart';
import '../utils/constants.dart';

class FirstAndLastNameComponent extends StatelessWidget {

  const FirstAndLastNameComponent(
      {Key? key,})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, provider, child) {

        return Column(
          children: [
            ///first name
            CustomTextFormField(prefixIconTextFieldState: IconTextFieldState.person,
              controller: provider.firstTextEditingController,
              labelText: tr(AppString.firstName),
              maxLength: nameMaxDigits,
              onFocusChange: provider.onFirstNameFocusChange,
              validator: (value) => provider.validateFirstName(value!),
              onChanged: (value) {
                provider.validateForm();
              },
            ),
            SizedBox(
              height: AppSizes.ph12,
            ),
            ///last name
            CustomTextFormField(
              prefixIconTextFieldState: IconTextFieldState.person,
              controller: provider.lastTextEditingController,
              labelText: tr(AppString.lastName),
              maxLength: nameMaxDigits,
              onFocusChange: provider.onLastNameFocusChange,
              validator: (value) => provider.validateLastName(value!),
              onChanged: (value) {
                provider.validateForm();
              },            ),
          ],
        );
      },
    );
  }
}
