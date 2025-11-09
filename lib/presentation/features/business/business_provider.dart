import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import '../../../data/models/business_model.dart';

// Business Provider
class BusinessNotifier extends StateNotifier<List<BusinessModel>> {
  final Box<BusinessModel> box;

  BusinessNotifier(this.box) : super(box.values.toList());

  /// Add or update a business
  Future<void> addOrUpdateBusiness(BusinessModel business) async {
    await box.put(business.id, business);
    state = box.values.toList();
  }

  /// Delete a business by id
  Future<void> deleteBusiness(String id) async {
    await box.delete(id);
    state = box.values.toList();
  }

  /// Update a specific field of a business
  Future<void> updateBusinessField(
    String id,
    String field,
    dynamic newValue,
  ) async {
    final business = box.get(id);
    if (business != null) {
      final updatedBusiness = BusinessModel(
        id: business.id,
        name: field == 'name' ? newValue : business.name,
        address: field == 'address' ? newValue : business.address,
        phone: field == 'phone' ? newValue : business.phone,
        email: field == 'email' ? newValue : business.email,
        website: field == 'website' ? newValue : business.website,
        taxId: field == 'taxId' ? newValue : business.taxId,
        bankName: field == 'bankName' ? newValue : business.bankName,
        bankAccount: field == 'bankAccount' ? newValue : business.bankAccount,
        swiftCode: field == 'swiftCode' ? newValue : business.swiftCode,
        currency: field == 'currency' ? newValue : business.currency,
      );
      await box.put(id, updatedBusiness);
      state = box.values.toList();
    }
  }

  /// Get a business by id
  BusinessModel? getBusinessById(String id) {
    return box.get(id);
  }

  /// Get all businesses
  List<BusinessModel> get businesses => state;

  /// Clear all businesses
  Future<void> clearBusinesses() async {
    await box.clear();
    state = [];
  }

  /// Load businesses from Hive
  Future<void> loadBusinesses() async {
    state = box.values.toList();
  }

  /// Get the default business (first in the list)
  BusinessModel? get defaultBusiness => state.isNotEmpty ? state.first : null;
}

final businessProvider =
    StateNotifierProvider<BusinessNotifier, List<BusinessModel>>(
      (ref) => BusinessNotifier(Hive.box<BusinessModel>('businessBox')),
    );
