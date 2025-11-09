import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import '../../../data/models/quote_model.dart';

class QuoteNotifier extends StateNotifier<List<QuoteModel>> {
  final Box<QuoteModel> box;

  QuoteNotifier(this.box) : super(box.values.toList());

  Future<void> addOrUpdateQuote(QuoteModel quote) async {
    await box.put(quote.id, quote);
    state = box.values.toList();
  }

  Future<void> deleteQuote(String id) async {
    await box.delete(id);
    state = box.values.toList();
  }

  QuoteModel? getQuoteById(String id) {
    return box.get(id);
  }

  List<QuoteModel> get quotes => state;

  Future<void> clearQuotes() async {
    await box.clear();
    state = [];
  }

  Future<void> loadQuotes() async {
    state = box.values.toList();
  }
}

final quoteProvider = StateNotifierProvider<QuoteNotifier, List<QuoteModel>>(
  (ref) => QuoteNotifier(Hive.box<QuoteModel>('quoteBox')),
);
