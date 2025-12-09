{{#use_local_storage}}
import 'package:hive_flutter/hive_flutter.dart';

/// Hive Service untuk manage local storage
class HiveService {
  static const String newsBoxName = 'news_box';
  
  /// Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();
  }
  
  /// Open box
  static Future<Box<T>> openBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }
    return Hive.box<T>(boxName);
  }
  
  /// Get box
  static Box<T> getBox<T>(String boxName) {
    return Hive.box<T>(boxName);
  }
  
  /// Close box
  static Future<void> closeBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).close();
    }
  }
  
  /// Delete box
  static Future<void> deleteBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).deleteFromDisk();
    } else {
      await Hive.deleteBoxFromDisk(boxName);
    }
  }
  
  /// Clear all boxes
  static Future<void> clearAll() async {
    await Hive.deleteFromDisk();
  }
}
{{/use_local_storage}}
