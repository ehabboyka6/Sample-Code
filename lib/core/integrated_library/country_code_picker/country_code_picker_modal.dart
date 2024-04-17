import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:fl_country_code_picker/src/widgets/widgets.dart' as li;
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:horsehouse/core/global/theme/theme_color/theme_color_light.dart';
import 'package:horsehouse/core/utils/app_fonsts.dart';
import 'package:horsehouse/core/widget/images/custom_png_image.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../component/header_modal_bottom_sheet_default.dart';
import '../../services/navigation_services.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_sizes.dart';
import '../../widget/images/custom_svg_image.dart';
import 'ccp_search_bar.dart';

/// {@template country_code_picker_modal}
/// Widget that can be used on showing a modal as bottom sheet that
/// contains all of the [CountryCode]s.
///
/// After pressing the [CountryCode]'s [ListTile], the widget pops
/// and returns the selected [CountryCode] which can be manipulated.
/// {@endtemplate}
class CountryCodePickerModal extends StatefulWidget {
  /// {@macro country_code_picker_modal}
  const CountryCodePickerModal(
      {required this.localize,
      required this.favoritesIcon,
      required this.showSearchBar,
      required this.showDialCode,
      this.title,
      this.focusedCountry,
      this.searchBarDecoration,
      this.favorites = const [],
      this.filteredCountries = const [],
      this.countryTextStyle,
      this.dialCodeTextStyle,
      Key? key,
      this.horizontalTitleGap,
      this.searchBarTextStyle,
      this.selectedCode})
      : super(key: key);

  final String? selectedCode;

  /// {@macro favorites}
  final List<String> favorites;

  /// {@macro filtered_countries}
  final List<String> filteredCountries;

  /// {@macro favorite_icon}
  final Icon? favoritesIcon;

  /// {@macro show_search_bar}
  final bool showSearchBar;

  /// {@macro show_dial_code}
  final bool showDialCode;

  /// If not null, automatically scrolls the list view to this country.
  final String? focusedCountry;

  /// {@macro title}
  final Widget? title;

  /// {@macro search_bar_decoration}
  final InputDecoration? searchBarDecoration;

  /// {@macro localize}
  final bool localize;

  /// {@macro country_text_style}
  final TextStyle? countryTextStyle;

  /// {@macro dial_code_text_style}
  final TextStyle? dialCodeTextStyle;

  /// {@macro search_bar_text_style}
  final TextStyle? searchBarTextStyle;

  /// space between flag and country name
  final double? horizontalTitleGap;

  @override
  State<CountryCodePickerModal> createState() => _CountryCodePickerModalState();
}

class _CountryCodePickerModalState extends State<CountryCodePickerModal> {
  late final List<CountryCode> baseList;
  final availableCountryCodes = <CountryCode>[];
  late ItemScrollController itemScrollController;

  @override
  void initState() {
    super.initState();
    itemScrollController = ItemScrollController();
    _initCountries();
  }

  Future<void> _initCountries() async {
    final allCountryCodes = codes.map(CountryCode.fromMap).toList();

    final favoriteList = <CountryCode>[
      if (widget.favorites.isNotEmpty)
        ...allCountryCodes.where((c) => widget.favorites.contains(c.code))
    ];

    final filteredList = [
      ...widget.filteredCountries.isNotEmpty
          ? allCountryCodes.where(
              (c) => widget.filteredCountries.contains(c.code),
            )
          : allCountryCodes,
    ]..removeWhere((c) => widget.favorites.contains(c.code));

    baseList = [...favoriteList, ...filteredList];
    availableCountryCodes.addAll(baseList);

    await Future<void>.delayed(Duration.zero);
    if (!itemScrollController.isAttached) return;

    if (widget.focusedCountry != null) {
      final index = availableCountryCodes.indexWhere(
        (c) => c.code == widget.focusedCountry,
      );

      await itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 600),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderModalBottomSheetDefault(),
        // widget.title ?? const CcpDefaultModalTitle(),
        if (widget.showSearchBar)
          CcpSearchBar(
            decoration: widget.searchBarDecoration,
            style: widget.searchBarTextStyle,
            onChanged: (query) {
              availableCountryCodes
                ..clear()
                ..addAll(
                  List<CountryCode>.from(
                    baseList.where(
                      (c) {
                        final country =
                            widget.localize ? c.localize(context) : c;

                        return country.code
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                            country.dialCode
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                            country.name
                                .toLowerCase()
                                .contains(query.toLowerCase());
                      },
                    ),
                  ),
                );
              setState(() {});
            },
          ),
        Expanded(
          child: ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            itemCount: availableCountryCodes.length,
            itemBuilder: (context, index) {
              final code = availableCountryCodes[index];
              final name =
                  widget.localize ? code.localize(context).name : code.name;

              final textTheme = Theme.of(context).textTheme;

              return InkWell(
                onTap: () => Navigator.pop(context, code),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSizes.ph18, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          code.flagImage(),
                          SizedBox(
                            width: AppSizes.pw18,
                          ),
                          Text(
                            name,
                            style: widget.countryTextStyle ??
                                textTheme.bodyLarge!.copyWith(
                                    color: widget.selectedCode != null &&
                                            widget.selectedCode == code.code
                                        ? ThemeColorLight.greenColor
                                        : null,
                                    fontSize: AppSizes.sp16,
                                    fontWeight: AppFonts.medium),
                          ),
                        ],
                      ),
                      li.CcpDefaultListItemTrailing(
                        code: code,
                        icon: widget.favoritesIcon,
                        favorites: widget.favorites,
                        showDialCode: widget.showDialCode,
                        dialCodeTextStyle: widget.dialCodeTextStyle ??
                            textTheme.bodyLarge!.copyWith(
                                color: widget.selectedCode != null &&
                                    widget.selectedCode == code.code
                                    ? ThemeColorLight.greenColor
                                    : null,
                                fontSize: AppSizes.sp16,
                                fontWeight: AppFonts.medium),
                      ),
                    ],
                  ),
                ),
              );

              //  return ListTile(
              //   onTap: () => Navigator.pop(context, code),
              //   leading: code.flagImage(),
              //   horizontalTitleGap: widget.horizontalTitleGap,
              //   title: Text(
              //     name,
              //     style: widget.countryTextStyle ?? textTheme.bodyLarge!.copyWith(fontSize: AppSizes.h5,fontWeight: AppFonts.medium),
              //   ),
              //   trailing: li.CcpDefaultListItemTrailing(
              //     code: code,
              //     icon: widget.favoritesIcon,
              //     favorites: widget.favorites,
              //     showDialCode: widget.showDialCode,
              //     dialCodeTextStyle:
              //     widget.dialCodeTextStyle ?? textTheme.bodyLarge!.copyWith(fontSize: AppSizes.h5,fontWeight: AppFonts.medium),
              //   ),
              // );
            },
          ),
        ),
      ],
    );
  }
}
