import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/product_model.dart';
import 'product_provider.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final product = ref
        .watch(productProvider.notifier)
        .getProductById(widget.productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product?.name ?? 'Product Detail'),
        backgroundColor: const Color.fromARGB(255, 179, 58, 58),
        foregroundColor: Colors.white,
      ),
      body: product == null
          ? const Center(child: Text("Product not found"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildInfoCard(
                    title: 'Product Information',
                    children: [
                      _buildDetailItem(
                        Icons.shopping_bag,
                        'Name',
                        product.name,
                      ),
                      _buildDetailItem(
                        Icons.description,
                        'Description',
                        product.description,
                      ),
                      _buildDetailItem(
                        Icons.sell,
                        'Price',
                        '₹${product.price.toStringAsFixed(2)}',
                      ),
                      _buildDetailItem(
                        Icons.inventory,
                        'Quantity',
                        product.quantity.toString(),
                      ),
                      _buildDetailItem(
                        Icons.percent,
                        'Tax',
                        product.taxPercent != null
                            ? '${product.taxPercent}%'
                            : 'N/A',
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            ...children,
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
}
