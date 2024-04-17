import 'package:flutter/material.dart';
import 'package:horsehouse/core/global/localization/app_localization.dart';
import 'package:horsehouse/core/services/navigation_services.dart';
import 'package:horsehouse/core/services/status_bar_manager.dart';
import 'package:horsehouse/core/utils/app_fonsts.dart';
import 'package:horsehouse/core/utils/app_sizes.dart';
import 'package:horsehouse/core/utils/app_string.dart';
import 'package:horsehouse/core/utils/enums.dart';
import 'package:horsehouse/core/widget/custom_text.dart';
import 'package:horsehouse/core/widget/custom_text_form_field.dart';

class SearchScreen extends StatefulWidget {
  final String? searchText;

  const SearchScreen({
    Key? key,
    this.searchText,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  void initState() {
    searchTextEditingController.text = widget.searchText ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarManager.setLikeBackgroundColor(context: context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///search box
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16, vertical: AppSizes.ph16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ///search Text Form Field
                    Expanded(
                      child: SizedBox(height: AppSizes.ph50,
                        child: CustomTextFormField(
                          suffixIconTextFieldState: searchTextEditingController.text.isNotEmpty
                              ? IconTextFieldState.clear
                              : IconTextFieldState.empty,
                          suffixOnPressed: () {
                            setState(() {
                              searchTextEditingController.clear();
                            });
                          },
                          focusFromStart: true,
                          prefixIconTextFieldState: IconTextFieldState.search,
                          controller: searchTextEditingController,
                          hintText: tr(AppString.search),
                          onFieldSubmitted: (value) {
                            NavigationService.goBack(result: searchTextEditingController.text);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppSizes.pw8,
                    ),

                    ///cancel
                    GestureDetector(
                      onTap: () {
                        NavigationService.goBack(result: '');
                      },
                      child: CustomText.greenColor(tr(AppString.cancel),
                          textStyle: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontWeight: AppFonts.medium, fontSize: AppSizes.sp16)),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
