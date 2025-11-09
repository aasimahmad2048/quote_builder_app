import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../data/models/quote_model.dart';
import '../quote/quote_provider.dart';

class QuoteDetailScreen extends ConsumerWidget {
  final String quoteId;
  const QuoteDetailScreen({super.key, required this.quoteId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quote = ref.watch(quoteProvider.notifier).getQuoteById(quoteId);

    if (quote == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quote Details')),
        body: const Center(child: Text('Quote not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(quote.title.isNotEmpty ? quote.title : 'Quote Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(quote),
            const SizedBox(height: 20),
            _buildClientInfo(quote),
            const SizedBox(height: 20),
            _buildProductList(quote),
            const SizedBox(height: 20),
            _buildSummary(quote),
            const SizedBox(height: 20),
            _buildTermsAndConditions(quote),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(QuoteModel quote) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quote #${quote.quoteNumber}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Issued: ${DateFormat('dd MMM yyyy').format(quote.date)}',
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        Text(
          'Due: ${DateFormat('dd MMM yyyy').format(quote.expiryDate)}',
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildClientInfo(QuoteModel quote) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Billed To',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            _buildDetailItem(Icons.person, 'Name', quote.client.name),
            _buildDetailItem(Icons.email, 'Email', quote.client.email),
            _buildDetailItem(Icons.phone, 'Phone', quote.client.phone),
            _buildDetailItem(
              Icons.location_on,
              'Address',
              quote.client.address,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(QuoteModel quote) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: quote.products.length,
              itemBuilder: (context, index) {
                final product = quote.products[index];
                final itemTotal =
                    (product.price * product.quantity) *
                    (1 + (product.taxPercent ?? 0.0) / 100);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.name),
                            Text(
                              '${product.quantity} x ₹${product.price.toStringAsFixed(2)} '
                              '${product.taxPercent != null && product.taxPercent! > 0 ? '(${product.taxPercent!.toStringAsFixed(0)}% Tax)' : ''}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '₹${itemTotal.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary(QuoteModel quote) {
    double subtotal = quote.products.fold(
      0.0,
      (sum, product) => sum + (product.price * product.quantity),
    );
    double totalTax = quote.products.fold(0.0, (sum, product) {
      final itemSubtotal = product.price * product.quantity;
      return sum + (itemSubtotal * (product.taxPercent ?? 0.0) / 100);
    });
    double grandTotal = (subtotal + totalTax) - quote.discount;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            _buildSummaryRow('Subtotal', subtotal),
            _buildSummaryRow('Tax', totalTax),
            if (quote.discount > 0)
              _buildSummaryRow('Discount', -quote.discount, isDiscount: true),
            const Divider(),
            _buildSummaryRow('Grand Total', grandTotal, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions(QuoteModel quote) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Terms and Conditions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            Text(
              quote.terms.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Text(quote.terms.description, style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    double amount, {
    bool isTotal = false,
    bool isDiscount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 16,
            ),
          ),
          Text(
            '${isDiscount ? '-' : ''}₹${amount.abs().toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 16,
              color: isDiscount
                  ? Colors.red
                  : (isTotal ? Colors.green.shade700 : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
