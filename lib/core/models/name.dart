import 'package:horsehouse/core/global/localization/app_localization.dart';
import 'package:horsehouse/core/services/dependency_injection_services.dart';

class Name {
  final String en;
  final String ar;

  Name({
    this.en = '',
    this.ar = '',
  });

  String get localizedName => toMap()[sl<BaseAppLocalizations>().getLanguageCode()];

  factory Name.fromMap(Map<String, dynamic> data) {
    return Name(
      ar: data['ar'],
      en: data['en'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ar': ar,
      'en': en,
    };
  }
}
