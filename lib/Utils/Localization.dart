

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en', ''), // English
    Locale('ar', ''), // Arabic
    Locale('fr', ''), // French
  ];

  // Define keys for each language
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'signUp': 'Sign Up',
      'logIn': 'Log In',
      'forgotPassword': 'Forgot Password?',
      'home': 'Home',
      'settings': 'Settings',
      'profile': 'Profile',
      'messages' 'Messages'
      'notifications': 'Notifications',
      'selectLanguage': 'Select Language',
      'french': 'French',
      'arabic': 'Arabic',
    },
    'ar': {
      'signUp': 'تسجيل',
      'logIn': 'دخول',
      'forgotPassword': 'نسيت كلمة المرور؟',
      'home': 'الرئيسية',
      'settings': 'الإعدادات',
      'profile': 'الملف الشخصي',
      'messages': 'الرسائل',
      'notifications': 'الإشعارات',
      'selectLanguage': 'اختيار اللغة',
      'french': 'الفرنسية',
      'arabic': 'العربية',
    },
    'fr': {
      'signUp': 'S\'inscrire',
      'logIn': 'Se connecter',
      'forgotPassword': 'Mot de passe oublié ?',
      'home': 'Accueil',
      'settings': 'Paramètres',
      'profile': 'Profil',
      'messages': 'Messages',
      'notifications': 'Notifications',
      'selectLanguage': 'Sélectionner la langue',
      'french': 'Français',
      'arabic': 'Arabe',
    },
  };

  String get signUp => _localizedValues[locale.languageCode]!['signUp']!;
  String get logIn => _localizedValues[locale.languageCode]!['logIn']!;
  String get forgotPassword => _localizedValues[locale.languageCode]!['forgotPassword']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;
  String get messages => _localizedValues[locale.languageCode]!['messages']!;
  String get notifications => _localizedValues[locale.languageCode]!['notifications']!;
  String get selectLanguage => _localizedValues[locale.languageCode]!['selectLanguage']!;
  String get french => _localizedValues[locale.languageCode]!['french']!;
  String get arabic => _localizedValues[locale.languageCode]!['arabic']!;

}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
