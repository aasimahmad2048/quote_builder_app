import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/data/models/business_model.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/data/models/product_model.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/data/models/quote_model.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/data/models/temp_model.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/data/models/terms_model.dart';
import 'package:uuid/uuid.dart';

class DummyDataSeeder {
  static const _uuid = Uuid();

  /// Seeds all data models if their respective boxes are empty.
  static Future<void> seedAll() async {
    await _seedBusinessData();
    await _seedClientData();
    await _seedProductData();
    await _seedTermsData();
  }

  static Future<void> _seedBusinessData() async {
    final businessBox = Hive.box<BusinessModel>('businessBox');
    if (businessBox.isEmpty) {
      final dummyBusiness = BusinessModel(
        id: _uuid.v4(),
        name: 'Meru Technosoft Pvt. Ltd.',
        address: '123 Tech Park, Silicon Valley, CA 94043',
        phone: '+1 (555) 123-4567',
        email: 'contact@merutech.com',
        website: 'https://www.merutech.com',
        taxId: 'GSTIN123456789',
        bankName: 'Global Tech Bank',
        bankAccount: '9876543210',
        swiftCode: 'GTBIUS33',
        currency: 'USD',
      );
      await businessBox.put(dummyBusiness.id, dummyBusiness);
      debugPrint("Seeded dummy business data.");
    }
  }

  static Future<void> _seedClientData() async {
    final clientBox = Hive.box<ClientModel>('ClientBox');
    if (clientBox.isEmpty) {
      final clients = [
        ClientModel(
          id: _uuid.v4(),
          name: 'Innovate Corp',
          email: 'contact@innovate.com',
          phone: '555-0101',
          address: '456 Innovation Drive, Tech City',
          type: 'Corporate',
        ),
        ClientModel(
          id: _uuid.v4(),
          name: 'Alice Johnson',
          email: 'alice.j@example.com',
          phone: '555-0102',
          address: '789 Maple Street, Suburbia',
          type: 'Individual',
        ),
      ];
      await clientBox.putAll({for (var c in clients) c.id: c});
      debugPrint("Seeded dummy client data.");
    }
  }

  static Future<void> _seedProductData() async {
    final productBox = Hive.box<ProductModel>('productBox');
    if (productBox.isEmpty) {
      final products = [
        ProductModel(
          id: _uuid.v4(),
          name: 'Web App Development',
          description: 'Full-stack web application development service.',
          price: 5000.00,
          quantity: 1,
          taxPercent: 18.0,
        ),
        ProductModel(
          id: _uuid.v4(),
          name: 'Mobile App UI/UX Design',
          description: 'Complete UI/UX design for iOS and Android.',
          price: 2500.00,
          quantity: 1,
          taxPercent: 18.0,
        ),
        ProductModel(
          id: _uuid.v4(),
          name: 'Cloud Hosting (1 Year)',
          description: 'Managed cloud hosting service for one year.',
          price: 1200.00,
          quantity: 1,
          taxPercent: 0.0,
        ),
      ];
      await productBox.putAll({for (var p in products) p.id: p});
      debugPrint("Seeded dummy product data.");
    }
  }

  static Future<void> _seedTermsData() async {
    final termsBox = Hive.box<TermsModel>('termsBox');
    if (termsBox.isEmpty) {
      final terms = [
        TermsModel(
          id: _uuid.v4(),
          title: 'Net 30',
          description: 'Payment is due within 30 days of the invoice date.',
        ),
        TermsModel(
          id: _uuid.v4(),
          title: '50% Upfront',
          description:
              '50% of the total amount is due upon signing the agreement. The remaining 50% is due upon project completion.',
        ),
      ];
      await termsBox.putAll({for (var t in terms) t.id: t});
      debugPrint("Seeded dummy terms & conditions data.");
    }
  }
}

/// This main function can be run from the terminal to seed the database.
/// `dart run lib/dump_data.dart`
Future<void> main() async {
  await Hive.initFlutter();

  // Register all adapters
  Hive.registerAdapter(BusinessModelAdapter());
  Hive.registerAdapter(ClientModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(TermsModelAdapter());
  Hive.registerAdapter(QuoteModelAdapter());

  // Open all boxes
  await Hive.openBox<BusinessModel>('businessBox');
  await Hive.openBox<ClientModel>('ClientBox');
  await Hive.openBox<ProductModel>('productBox');
  await Hive.openBox<TermsModel>('termsBox');
  await Hive.openBox<QuoteModel>('quoteBox');

  print('Seeding database with dummy data...');
  await DummyDataSeeder.seedAll();
  print('Seeding complete!');
 
}
