import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/temp_model.dart';
import '../../../data/models/terms_model.dart';

/// State for Create Quotation
class CreateQuotationState {
  final ClientModel? client;
  final List<ProductModel> products;
  final String issuedDate;
  final String dueDate;
  final List<TermsModel> terms;
  final String quoteNumber;

  CreateQuotationState({
    this.client,
    this.quoteNumber = '',
    this.products = const [],
    this.issuedDate = "DD MMM YYYY",
    this.dueDate = "DD MMM YYYY",
    this.terms = const [],
  });

  CreateQuotationState copyWith({
    ClientModel? client,
    String? quoteNumber,

    List<ProductModel>? products,
    String? issuedDate,
    String? dueDate,
    List<TermsModel>? terms,
  }) {
    return CreateQuotationState(
      client: client ?? this.client,
      quoteNumber: quoteNumber ?? this.quoteNumber,

      products: products ?? this.products,
      issuedDate: issuedDate ?? this.issuedDate,
      dueDate: dueDate ?? this.dueDate,
      terms: terms ?? this.terms,
    );
  }
}

/// StateNotifier for managing quotation
class CreateQuotationNotifier extends StateNotifier<CreateQuotationState> {
  CreateQuotationNotifier() : super(CreateQuotationState());

  void setClient(ClientModel client) {
    state = state.copyWith(client: client);
  }

  void setQuoteNumber(String number) {
    state = state.copyWith(quoteNumber: number);
  }

  void addOrUpdateTerm(TermsModel term) {
    final List<TermsModel> currentTerms = List.from(state.terms);
    final int existingIndex = currentTerms.indexWhere((t) => t.id == term.id);

    if (existingIndex != -1) {
      currentTerms[existingIndex] = term; // Update existing term
    } else {
      currentTerms.add(term); // Add new term
    }
    state = state.copyWith(terms: currentTerms);
  }



  /// Adds a new product or updates an existing one in the quote.
  void addOrUpdateProduct(ProductModel product) {
    final List<ProductModel> currentProducts = List.from(state.products);
    final int existingIndex = currentProducts.indexWhere(
      (p) => p.id == product.id,
    );

    if (existingIndex != -1) {
      currentProducts[existingIndex] = product; // Update existing product
    } else {
      currentProducts.add(product); // Add new product
    }
    state = state.copyWith(products: currentProducts);
  }

  void removeProduct(int index) {
    final newList = [...state.products]..removeAt(index);
    state = state.copyWith(products: newList);
  }

  /// Updates a product at a specific index with a new ProductModel.
  void updateProduct(int index, ProductModel updatedProduct) {
    final List<ProductModel> newList = List.from(state.products);
    if (index >= 0 && index < newList.length) {
      newList[index] = updatedProduct;
      state = state.copyWith(products: newList);
    }
  }

  void setIssuedDate(String date) {
    state = state.copyWith(issuedDate: date);
  }

  void setDueDate(String date) {
    state = state.copyWith(dueDate: date);
  }

  void setTerms(List<TermsModel> terms) {
    state = state.copyWith(terms: terms);
  }

   
  void resetState() {
    state = CreateQuotationState();
  }

  double calculateSubtotal() {
    return state.products.fold(
      0.0,
      (sum, product) => sum + (product.price * product.quantity),
    );
  }

  double calculateTotalTax() {
    return state.products.fold(0.0, (sum, product) {
      final subtotal = product.price * product.quantity;
      return sum + (subtotal * (product.taxPercent ?? 0.0) / 100);
    });
  }

  double calculateGrandTotal({double discount = 0.0}) {
    final subtotal = calculateSubtotal();
    final totalTax = calculateTotalTax();
    return (subtotal + totalTax) - discount;
  }

  Future getTerms() async {
    
  }

  // Future getTerms() async {
  //   // Dummy data for terms and conditions
  //   await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
  //   return [
  //     TermsModel(
  //       id: '1',
  //       title: 'Standard Terms',
  //       description: 'Payment due within 30 days. Late fees may apply.',
  //     ),
  //     TermsModel(
  //       id: '2',
  //       title: 'Project-Specific Terms',
  //       description: '50% upfront, 25% at milestone 1, 25% upon completion.',
  //     ),
  //     TermsModel(
  //       id: '3',
  //       title: 'Wholesale Agreement',
  //       description: 'Minimum order quantity of 100 units. Net 60 payment terms.',
  //     ),
  //   ];

  // }
  // Future<List<TermsModel>> getTerms() async {
  //   // Dummy data for terms and conditions
  //   await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
  //   return [
  //     TermsModel(
  //       id: '1',
  //       title: 'Standard Terms',
  //       description: 'Payment due within 30 days. Late fees may apply.',
  //     ),
  //     TermsModel(
  //       id: '2',
  //       title: 'Project-Specific Terms',
  //       description: '50% upfront, 25% at milestone 1, 25% upon completion.',
  //     ),
  //     TermsModel(
  //       id: '3',
  //       title: 'Wholesale Agreement',
  //       description: 'Minimum order quantity of 100 units. Net 60 payment terms.',
  //     ),
  //   ];
  // }
}

/// Riverpod provider
final createQuotationProvider =
    StateNotifierProvider<CreateQuotationNotifier, CreateQuotationState>(
      (ref) => CreateQuotationNotifier(),
    );
