import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/data/models/quote_model.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/features/quote/create_quote_provider.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/features/quote/quote_provider.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/features/terms/terms_provider.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/ui_constants/app_button.dart';
import '../../../core/routes/route_names.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/temp_model.dart';
import '../../../data/models/terms_model.dart';
import '../client/client_provider.dart';
import '../product/product_provider.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/ui_constants/app_textForm_field.dart';

class CreateQuoteScreen extends ConsumerStatefulWidget {
  const CreateQuoteScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateQuoteScreenState();
}

class _CreateQuoteScreenState extends ConsumerState<CreateQuoteScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController quoteNumber = TextEditingController();
  final TextEditingController quoteTitle = TextEditingController();
  var currentTime = DateTime.now();

  @override
  void dispose() {
    quoteNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createQuotationProvider);
    final notifier = ref.read(createQuotationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,

        title: const Text("New Quotation"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quote Number Section
              _buildSectionHeader("Quotation Details"),
              _buildQuoteNumberSection(),
              _buildQuoteTitleSection(),
              const SizedBox(height: 24),

              // Date Section
              _buildSectionHeader("Dates"),
              _buildDateSection(state, notifier),

              const SizedBox(height: 24),

              // Client Section
              _buildSectionHeader("Client"),
              _buildClientSection(state, notifier),

              const SizedBox(height: 24),

              // Products Section
              _buildProductSection(state, notifier),

              const SizedBox(height: 24),

              // Terms Section
              _buildSectionHeader("Terms & Conditions"),
              _buildTermsSection(state, notifier),

              const SizedBox(height: 24),

              // Summary Section
              _buildSectionHeader("Summary"),
              _buildSummarySection(state, notifier),

              const SizedBox(height: 32),

              // Generate Button
              _buildGenerateButton(state, notifier),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildQuoteNumberSection() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Quotation Number",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            AppTextFormField(
              hintText: "Enter Quotation Number",
              controller: quoteNumber,
              labelText: 'Quotation Number',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteTitleSection() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Quotation Title",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            AppTextFormField(
              hintText: "Enter Quotation Title",
              labelText: 'Quotation Title',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Quotation Title cannot be empty';
                }
                return null;
              },
              controller: quoteTitle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSection(
    CreateQuotationState state,
    CreateQuotationNotifier notifier,
  ) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDateRow(
              label: "Issued Date",
              date: state.issuedDate,
              onTap: () => _showDatePicker("issue", notifier),
            ),
            const SizedBox(height: 12),
            _buildDateRow(
              label: "Due Date",
              date: state.dueDate,
              onTap: () => _showDatePicker("due", notifier),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRow({
    required String label,
    required String date,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date, style: const TextStyle(color: Colors.blue)),
                  Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClientSection(
    CreateQuotationState state,
    CreateQuotationNotifier notifier,
  ) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Select Client",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: () async {
                    final newClient = await Navigator.pushNamed(
                      context,
                      RouteNames.createClient,
                    );
                    if (newClient != null && newClient is ClientModel) {
                      notifier.setClient(newClient);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 16, color: Colors.blue),
                        SizedBox(width: 4),
                        Text("New", style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final clients = await ref
                    .read(clientProvider.notifier)
                    .getClients();
                showGenericBottomSheet<ClientModel>(
                  context: context,
                  items: clients,
                  itemBuilder: (client) => ListTile(
                    title: Text(client.name),
                    subtitle: Text(client.email),
                  ),
                ).then((value) {
                  if (value != null) notifier.setClient(value);
                });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.client?.name ?? "Select Client",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: state.client == null
                                  ? Colors.grey
                                  : Colors.black87,
                            ),
                          ),
                          if (state.client?.address != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                state.client!.address!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductSection(
    CreateQuotationState state,
    CreateQuotationNotifier notifier,
  ) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Product Items",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    _buildActionChip(
                      text: "Add",
                      icon: Icons.add,
                      onTap: () => _showProductSelection(state, notifier),
                    ),
                    const SizedBox(width: 8),
                    _buildActionChip(
                      text: "New",
                      icon: Icons.create_new_folder,
                      onTap: () async {
                        final newProduct =
                            await Navigator.pushNamed(
                                  context,
                                  RouteNames.createProduct,
                                )
                                as ProductModel?;
                        if (newProduct != null) {
                          final productWithDetails = await _showQuantityDialog(
                            context,
                            newProduct,
                          );
                          if (productWithDetails != null) {
                            notifier.addOrUpdateProduct(productWithDetails);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (state.products.isEmpty)
              _buildEmptyState(
                icon: Icons.inventory_2_outlined,
                text: "No products added",
                subtitle:
                    "Tap 'Add' to select existing products or 'New' to create one",
              )
            else
              Column(
                children: [
                  ...state.products.asMap().entries.map(
                    (entry) =>
                        _buildProductItem(entry.value, entry.key, notifier),
                  ),
                  const SizedBox(height: 8),
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 8),
                  _buildProductTotals(notifier),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChip({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.green),
            const SizedBox(width: 4),
            Text(text, style: TextStyle(color: Colors.green.shade700)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(
    ProductModel product,
    int index,
    CreateQuotationNotifier notifier,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () async {
            final updatedProduct = await _showQuantityDialog(context, product);
            if (updatedProduct != null) {
              notifier.updateProduct(index, updatedProduct);
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "₹${product.price.toStringAsFixed(2)} × ${product.quantity}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      if (product.taxPercent != null && product.taxPercent! > 0)
                        Text(
                          "Tax: ${product.taxPercent}%",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  "₹${_calculateTotal(product).toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => notifier.removeProduct(index),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductTotals(CreateQuotationNotifier notifier) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Subtotal:", style: TextStyle(fontWeight: FontWeight.w500)),
        Text(
          "₹${notifier.calculateSubtotal().toStringAsFixed(2)}",
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildTermsSection(
    CreateQuotationState state,
    CreateQuotationNotifier notifier,
  ) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                final termsList = await ref
                    .read(termsProvider.notifier)
                    .loadTerms();
                showGenericBottomSheet<TermsModel>(
                  context: context,
                  items: termsList,
                  itemBuilder: (terms) => ListTile(
                    title: Text(terms.title),
                    subtitle: Text(terms.description),
                  ),
                ).then((value) {
                  if (value != null) notifier.setTerms([value]);
                });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.terms.isNotEmpty
                                ? state.terms.first.title
                                : "Select Terms & Conditions",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: state.terms.isEmpty
                                  ? Colors.grey
                                  : Colors.black87,
                            ),
                          ),
                          if (state.terms.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                state.terms.first.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
            if (state.terms.isNotEmpty) ...[
              const SizedBox(height: 12),
              ...state.terms.asMap().entries.map(
                (entry) => _buildTermsItem(entry.value, entry.key, notifier),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTermsItem(
    TermsModel terms,
    int index,
    CreateQuotationNotifier notifier,
  ) {
    return Material(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    terms.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(terms.description, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () {
                final currentTerms = List<TermsModel>.from(
                  notifier.state.terms,
                );
                if (index >= 0 && index < currentTerms.length) {
                  currentTerms.removeAt(index);
                  notifier.setTerms(currentTerms);
                }
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection(
    CreateQuotationState state,
    CreateQuotationNotifier notifier,
  ) {
    final subtotal = notifier.calculateSubtotal();
    final tax = notifier.calculateTotalTax();
    final grandTotal = notifier.calculateGrandTotal();

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummaryRow("Subtotal", subtotal),
            _buildSummaryRow("Tax", tax),
            const Divider(),
            _buildSummaryRow("Grand Total", grandTotal, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            "₹${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? Colors.green.shade700 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateButton(
    CreateQuotationState state,
    CreateQuotationNotifier notifier,
  ) {
    return SizedBox(
      width: double.infinity,
      child: AppButton(
        onPressed: () {
          if (!formKey.currentState!.validate()) {
            return;
          }
          if (state.client == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please select a client.')),
            );
            return;
          }
          if (state.products.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please add at least one product.')),
            );
            return;
          }
          if (state.issuedDate == "DD MMM YYYY" ||
              state.dueDate == "DD MMM YYYY") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select an issued and due date.'),
                backgroundColor: Colors.redAccent,
              ),
            );
            return;
          }

          if (state.terms.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select terms and conditions.'),
              ),
            );
            return;
          }

          notifier.setQuoteNumber(quoteNumber.text);

          final newQuote = QuoteModel(
            title: quoteTitle.text,
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            quoteNumber: state.quoteNumber,
            date: DateFormat("dd MMM yyyy").parse(state.issuedDate),
            expiryDate: DateFormat("dd MMM yyyy").parse(state.dueDate),
            client: state.client!,
            products: state.products,
            terms: state.terms.first,
            discount: 0.0,
            tax: notifier.calculateTotalTax(),
            totalAmount: notifier.calculateGrandTotal(),
          );

          ref.read(quoteProvider.notifier).addOrUpdateQuote(newQuote);
          notifier.resetState();

          Navigator.pushNamed(
            context,
            RouteNames.quoteDetail,
            arguments: newQuote.id,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Quotation created successfully!')),
          );
        },
        child: const Text(
          "Generate Quotation",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String text,
    String? subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Text(text, style: TextStyle(color: Colors.grey.shade600)),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  void _showDatePicker(String dateType, CreateQuotationNotifier notifier) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2018, 3, 5),
      maxTime: DateTime(2050, 1, 1),
      currentTime: currentTime,
      locale: LocaleType.en,
      onConfirm: (date) {
        if (date != null) {
          final formattedDate = DateFormat("dd MMM yyyy").format(date);
          if (dateType == "issue") {
            notifier.setIssuedDate(formattedDate);
          } else {
            notifier.setDueDate(formattedDate);
          }
        }
      },
    );
  }

  void _showProductSelection(
    CreateQuotationState state,
    CreateQuotationNotifier notifier,
  ) async {
    final productsList = await ref.read(productProvider.notifier).getProducts();
    showGenericBottomSheet<ProductModel>(
      context: context,
      items: productsList,
      itemBuilder: (product) => ListTile(
        title: Text(product.name),
        subtitle: Text("₹${product.price.toStringAsFixed(2)}"),
      ),
    ).then((selectedProduct) async {
      if (selectedProduct != null) {
        final existingProductIndex = state.products.indexWhere(
          (p) => p.id == selectedProduct.id,
        );

        ProductModel productToEdit = selectedProduct;
        if (existingProductIndex != -1) {
          productToEdit = state.products[existingProductIndex];
        }

        final updatedProduct = await _showQuantityDialog(
          context,
          productToEdit,
        );
        if (updatedProduct != null) {
          notifier.addOrUpdateProduct(updatedProduct);
        }
      }
    });
  }

  // Keep your existing helper methods (_calculateTotal, _showQuantityDialog, showGenericBottomSheet)
  double _calculateTotal(ProductModel product) {
    final double price = product.price;
    final int quantity = product.quantity;
    final double taxPercent = product.taxPercent ?? 0.0;

    final subtotal = price * quantity;
    final total = subtotal + (subtotal * taxPercent / 100);
    return total;
  }

  Future<ProductModel?> _showQuantityDialog(
    BuildContext context,
    ProductModel product,
  ) async {
    final TextEditingController qtyController = TextEditingController(
      text: product.quantity.toString(),
    );
    final TextEditingController taxController = TextEditingController(
      text: (product.taxPercent ?? 0.0).toStringAsFixed(2),
    );

    return await showDialog<ProductModel?>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Product Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  child: AppTextFormField(
                    controller: qtyController,
                    keyboardType: TextInputType.number,
                    hintText: "Enter Quantity",
                    labelText: 'Quantity',
                    validator: (v) {
                      if (v == null || v.isEmpty)
                        return 'Quantity cannot be empty';
                      if (int.tryParse(v) == null) return 'Invalid quantity';
                      if (int.parse(v) <= 0) return 'Quantity must be positive';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          int currentQty =
                              int.tryParse(qtyController.text) ?? 0;
                          if (currentQty > 1) {
                            qtyController.text = (currentQty - 1).toString();
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          int currentQty =
                              int.tryParse(qtyController.text) ?? 0;
                          qtyController.text = (currentQty + 1).toString();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  child: AppTextFormField(
                    controller: taxController,
                    keyboardType: TextInputType.number,
                    hintText: "Enter Tax (%)",
                    labelText: 'Tax (%)',
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Tax cannot be empty';
                      if (double.tryParse(v) == null)
                        return 'Invalid tax percentage';
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final int? newQuantity = int.tryParse(qtyController.text);
              final double? newTaxPercent = double.tryParse(taxController.text);

              if (newQuantity != null &&
                  newQuantity > 0 &&
                  newTaxPercent != null) {
                Navigator.pop(
                  context,
                  product.copyWith(
                    quantity: newQuantity,
                    taxPercent: newTaxPercent,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter valid quantity and tax.'),
                  ),
                );
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<T?> showGenericBottomSheet<T>({
    required BuildContext context,
    required List<T> items,
    required Widget Function(T item) itemBuilder,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () => Navigator.pop(context, items[index]),
            child: itemBuilder(items[index]),
          ),
          separatorBuilder: (context, index) => const Divider(height: 0),
        ),
      ),
    );
  }
}
