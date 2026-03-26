// lib/providers/app_provider.dart
import 'package:flutter/material.dart';

// نموذج بيانات المستخدم
class UserData {
  String? name;
  String? email;
  String? bio;
  List<String> skills;
  String? userType; // 'worker' or 'company'

  UserData({
    this.name,
    this.email,
    this.bio,
    this.skills = const [],
    this.userType,
  });
}

// الـ Provider الرئيسي للتطبيق
class AppProvider extends ChangeNotifier {
  // البيانات العامة
  UserData? _currentUser;
  bool _isLoading = false;

  // Getters (لقراءة البيانات)
  UserData? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  // تعيين بيانات المستخدم (يُستخدم بعد تسجيل الدخول)
  void setUser(UserData user) {
    _currentUser = user;
    notifyListeners(); // إعلام جميع الصفحات بالتغيير
  }

  // تحديث اسم المستخدم
  void updateUserName(String name) {
    if (_currentUser != null) {
      _currentUser!.name = name;
      notifyListeners();
    }
  }

  // تحديث السيرة الذاتية
  void updateBio(String bio) {
    if (_currentUser != null) {
      _currentUser!.bio = bio;
      notifyListeners();
    }
  }

  // تحديث المهارات
  void updateSkills(List<String> skills) {
    if (_currentUser != null) {
      _currentUser!.skills = skills;
      notifyListeners();
    }
  }

  // تحديث نوع المستخدم
  void updateUserType(String userType) {
    if (_currentUser != null) {
      _currentUser!.userType = userType;
      notifyListeners();
    }
  }

  // تغيير حالة التحميل
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // تسجيل الخروج (مسح البيانات)
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
