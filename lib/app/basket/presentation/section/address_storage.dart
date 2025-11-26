// lib/core/services/address_storage.dart
import 'package:shared_preferences/shared_preferences.dart';

class AddressStorage {
  // Keys
  static const String _kName = 'saved_address_name';
  static const String _kPhone = 'saved_address_phone';
  static const String _kCity = 'saved_address_city';
  static const String _kStreet = 'saved_address_street';
  static const String _kApartment = 'saved_address_apartment';
  static const String _kSaveInfo = 'saved_address_save_info';

  // Save all fields
  static Future<void> saveAddress({
    required String name,
    required String phone,
    required String city,
    required String street,
    required String apartment,
    required bool saveInfo,
  }) async {
    if (!saveInfo) {
      await clearAddress();
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kName, name);
    await prefs.setString(_kPhone, phone);
    await prefs.setString(_kCity, city);
    await prefs.setString(_kStreet, street);
    await prefs.setString(_kApartment, apartment);
    await prefs.setBool(_kSaveInfo, true);
  }

  // Load saved address
  static Future<Map<String, dynamic>> loadSavedAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final saveInfo = prefs.getBool(_kSaveInfo) ?? false;

    if (!saveInfo) {
      return {
        'name': '',
        'phone': '',
        'city': '',
        'street': '',
        'apartment': '',
        'saveInfo': false,
      };
    }

    return {
      'name': prefs.getString(_kName) ?? '',
      'phone': prefs.getString(_kPhone) ?? '',
      'city': prefs.getString(_kCity) ?? '',
      'street': prefs.getString(_kStreet) ?? '',
      'apartment': prefs.getString(_kApartment) ?? '',
      'saveInfo': true,
    };
  }

  // Clear saved data (when user unchecks checkbox)
  static Future<void> clearAddress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kName);
    await prefs.remove(_kPhone);
    await prefs.remove(_kCity);
    await prefs.remove(_kStreet);
    await prefs.remove(_kApartment);
    await prefs.remove(_kSaveInfo);
  }
}