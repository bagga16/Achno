import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleService extends Translations {
  static final box = GetStorage();
  static const String _localeKey = 'selected_locale';

  static const List<String> supportedLangs = ['en', 'ar', 'fr'];

  static Locale getInitialLocale() {
    final String? langCode = box.read(_localeKey);
    if (langCode != null && supportedLangs.contains(langCode)) {
      return Locale(langCode);
    }
    return const Locale('en');
  }

  static void changeLocale(String langCode) {
    final locale = Locale(langCode);
    Get.updateLocale(locale);
    box.write(_localeKey, langCode);
  }

  @override
  Map<String, Map<String, String>> get keys => {
    'en': _english,
    'ar': _arabic,
    'fr': _french,
  };

  static final Map<String, String> _english = {
    "signUp": "Sign Up",
    "logIn": "Log In",
    "forgotPassword": "Forgot Password?",
    "home": "Home",
    "settings": "Settings",
    "profile": "Profile",
    "postAnnouncement": "Post an Announcement",
    "request": "Request",
    "offer": "Offer",
    "search": "Search",
    "filter": "Filter",
    "messages": "Messages",
    "notifications": "Notifications",
    "accept": "Accept",
    "reject": "Reject",
    "submit": "Submit",
    "back": "Back",
    "save": "Save",
    "city": "City",
    "profession": "Profession",
    "selectLanguage": "Select Language",
    "french": "French",
    "arabic": "Arabic",
    "postTitleOptional": "Post Title (Optional)",
    "postDescription": "Post Description",
    "voiceMessage": "Voice Message",
    "textMessage": "Text Message",
    "uploadImage": "Upload Image",
    "likes": "Likes",
    "responses": "Responses",
    "deletePost": "Delete Post",
    "editPost": "Edit Post",
    "report": "Report",
    "blockUser": "Block User",
    "yourCity": "Your City",
    "currentLocation": "Current Location",
    "changeCity": "Change City",
    "chooseProfession": "Choose Profession"
  };

  static final Map<String, String> _arabic = {
    "signUp": "تسجيل",
    "logIn": "دخول",
    "forgotPassword": "نسيت كلمة المرور؟",
    "home": "الرئيسية",
    "settings": "الإعدادات",
    "profile": "الملف الشخصي",
    "postAnnouncement": "نشر إعلان",
    "request": "طلب",
    "offer": "عرض",
    "search": "بحث",
    "filter": "فلترة",
    "messages": "الرسائل",
    "notifications": "الإشعارات",
    "accept": "قبول",
    "reject": "رفض",
    "submit": "إرسال",
    "back": "رجوع",
    "save": "حفظ",
    "city": "المدينة",
    "profession": "المهنة/حرفة",
    "selectLanguage": "اختيار اللغة",
    "french": "الفرنسية",
    "arabic": "العربية",
    "postTitleOptional": "عنوان الإعلان (اختياري)",
    "postDescription": "وصف الإعلان",
    "voiceMessage": "رسالة صوتية",
    "textMessage": "رسالة نصية",
    "uploadImage": "تحميل صورة",
    "likes": "إعجاب",
    "responses": "الردود",
    "deletePost": "حذف الإعلان",
    "editPost": "تعديل الإعلان",
    "report": "الإبلاغ",
    "blockUser": "حظر المستخدم",
    "yourCity": "مدينتك",
    "currentLocation": "الموقع الحالي",
    "changeCity": "تغيير المدينة",
    "chooseProfession": "اختيار مهنة"
  };

  static final Map<String, String> _french = {
    "signUp": "S'inscrire",
    "logIn": "Se connecter",
    "forgotPassword": "Mot de passe oublié ?",
    "home": "Accueil",
    "settings": "Paramètres",
    "profile": "Profil",
    "postAnnouncement": "Publier une annonce",
    "request": "Demande",
    "offer": "Offre",
    "search": "Rechercher",
    "filter": "Filtrer",
    "messages": "Messages",
    "notifications": "Notifications",
    "accept": "Accepter",
    "reject": "Refuser",
    "submit": "Soumettre",
    "back": "Retour",
    "save": "Sauvegarder",
    "city": "Ville",
    "profession": "Métier",
    "selectLanguage": "Sélectionner la langue",
    "french": "Français",
    "arabic": "Arabe",
    "postTitleOptional": "Titre de l'annonce (Optionnel)",
    "postDescription": "Description de l'annonce",
    "voiceMessage": "Message vocal",
    "textMessage": "Message texte",
    "uploadImage": "Télécharger une image",
    "likes": "J'aime",
    "responses": "Réponses",
    "deletePost": "Supprimer l'annonce",
    "editPost": "Modifier l'annonce",
    "report": "Signaler",
    "blockUser": "Bloquer l'utilisateur",
    "yourCity": "Votre ville",
    "currentLocation": "Localisation actuelle",
    "changeCity": "Changer de ville",
    "chooseProfession": "Choisir un métier"
  };
}
