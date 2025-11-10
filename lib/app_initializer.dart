import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/dump_data.dart';
import 'core/storage/splash_prefs.dart';
import 'data/models/business_model.dart';
import 'data/models/product_model.dart';
import 'data/models/quote_model.dart';
import 'data/models/temp_model.dart';
import 'data/models/terms_model.dart';

class AppInitializer {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SplashPrefs.init();
    await Duration(seconds: 3);
    await Hive.initFlutter();
    // Adapters for Hive
    Hive.registerAdapter(BusinessModelAdapter());
    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(TermsModelAdapter());
    Hive.registerAdapter(QuoteModelAdapter());
    Hive.registerAdapter(ClientModelAdapter());

    // Open all Hive boxes
    await Hive.openBox<BusinessModel>('businessBox');
    await Hive.openBox<ProductModel>('productBox');
    await Hive.openBox<TermsModel>('termsBox');
    await Hive.openBox<QuoteModel>('quoteBox');
    await Hive.openBox<ClientModel>('ClientBox');

    SplashPrefs.instance?.isLoggedIn == false
        ? await DummyDataSeeder.seedAll()
        : print("Data Already Seeded"); 
  }
}
