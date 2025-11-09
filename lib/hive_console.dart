import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearAllHiveData() async {
  await Hive.close();
  await Hive.deleteFromDisk();
  print("All Hive data cleared successfully!");
}

Future<void> clearSharedPrefData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  print("All Shared Preferences data cleared successfully!");
}

void main() async {  
  await clearAllHiveData();
}
