import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/data/models/product_model.dart';

import '../../../core/routes/route_names.dart';
import 'product_provider.dart';

class ManageProductScreen extends ConsumerStatefulWidget {
  const ManageProductScreen({super.key});

  @override
  ConsumerState<ManageProductScreen> createState() =>
      _ManageProductScreenState();
}

class _ManageProductScreenState extends ConsumerState<ManageProductScreen> {
  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        backgroundColor: const Color.fromARGB(255, 179, 58, 58),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: productList.isEmpty
          ? _buildEmptyState()
          : _buildProductList(productList),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.createProduct);
        },
        backgroundColor: const Color.fromARGB(255, 179, 58, 58),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No Products Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add your first product',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(List<ProductModel> products) {
    return Column(
      children: [
        // Summary Header
        _buildSummaryHeader(products),

        // Products List
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(product, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryHeader(List<ProductModel> products) {
    final totalProducts = products.length;
    final totalValue = products.fold<double>(
      0,
      (sum, product) => sum + (product.price * (product.quantity ?? 1)),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem(
            icon: Icons.inventory_2,
            value: totalProducts.toString(),
            label: 'Total Products',
          ),
          _buildSummaryItem(
            icon: Icons.attach_money,
            value: '₹${totalValue.toStringAsFixed(2)}',
            label: 'Total Value',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, size: 24, color: const Color.fromARGB(255, 179, 58, 58)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildProductCard(ProductModel product, int index) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteNames.productDetail,
            arguments: product.id,
          );
        },
        onLongPress: () => _showDeleteDialog(product),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Product Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    179,
                    58,
                    58,
                  ).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: const Color.fromARGB(255, 179, 58, 58),
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                    if (product.description?.isNotEmpty == true) ...[
                      const SizedBox(height: 4),
                      Text(
                        product.description!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (product.quantity != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Qty: ${product.quantity}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Action Buttons
              _buildActionButtons(product),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(ProductModel product) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Update Button
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteNames.editProduct,
              arguments: product,
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit, size: 16, color: Colors.blue.shade700),
                const SizedBox(width: 4),
                Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Delete Button
        InkWell(
          onTap: () => _showDeleteDialog(product),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.red.shade100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.delete_outline,
                  size: 16,
                  color: Colors.red.shade700,
                ),
                const SizedBox(width: 4),
                Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.red.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(ProductModel product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            SizedBox(width: 8),
            Text('Delete Product'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to delete "${product.name}"?',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Price: ₹${product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 4),
            const Text(
              'This action cannot be undone.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(productProvider.notifier).deleteProduct(product.id);
              Navigator.pop(context);

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"${product.name}" deleted successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
