import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';

import '../../../data/models/terms_model.dart';

class TermsProvider extends StateNotifier<List<TermsModel>> {
  final Box<TermsModel> box;

  TermsProvider(super.state, this.box);

  // add or update a term
  Future<void> addOrUpdateTerm(TermsModel term) async {
    await box.put(term.id, term);
    state = box.values.toList();
  }

  // delete a term by id
  Future<void> deleteTerm(String id) async {
    await box.delete(id);
    state = box.values.toList();
  }

  // update a specific field of a term
  Future<void> updateTermField(
    String id,
    String field,
    dynamic newValue,
  ) async {
    final term = box.get(id);
    if (term != null) {
      final updatedTerm = TermsModel(
        id: term.id,
        title: field == 'title' ? newValue : term.title,
        description: field == 'description' ? newValue : term.description,
      );
      await box.put(id, updatedTerm);
      state = box.values.toList();
    }
  }

  // get a term by id
  TermsModel? getTermById(String id) {
    return box.get(id);
  }

  // get all terms
  List<TermsModel> get terms => state;

  // clear all terms
  Future<void> clearTerms() async {
    await box.clear();
    state = [];
  }

  // load terms from Hive
  Future<List<TermsModel>>
   loadTerms() async {
    state = box.values.toList();
    return state;

  }
}

final termsProvider = StateNotifierProvider<TermsProvider, List<TermsModel>>(
  (ref) => TermsProvider(
    Hive.box<TermsModel>('termsBox').values.toList(),
    Hive.box<TermsModel>('termsBox'),
  ),
);
