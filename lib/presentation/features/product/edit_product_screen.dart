import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/product_model.dart';
import 'product_provider.dart';
import '../../ui_constants/app_button.dart';
import '../../ui_constants/app_textForm_field.dart';

class EditProductScreen extends ConsumerStatefulWidget {
  final ProductModel product;
  const EditProductScreen({super.key, required this.product});

  @override
  ConsumerState<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends ConsumerState<EditProductScreen> {
  final formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController quantityController;
  late TextEditingController taxController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.name);
    descriptionController = TextEditingController(
      text: widget.product.description,
    );
    priceController = TextEditingController(
      text: widget.product.price.toString(),
    );
    quantityController = TextEditingController(
      text: widget.product.quantity.toString(),
    );
    taxController = TextEditingController(
      text: widget.product.taxPercent?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    taxController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
        title: const Text('Edit Product'),
        backgroundColor: const Color.fromARGB(255, 179, 58, 58),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: isWideScreen ? 48 : 16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    _buildProgressHeader(),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            _buildSection(
                              title: 'Product Information',
                              icon: Icons.shopping_bag,
                              children: [_buildProductInfoFields()],
                            ),
                            const SizedBox(height: 24),
                            _buildSection(
                              title: 'Pricing & Stock',
                              icon: Icons.inventory,
                              children: [_buildPricingFields()],
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                    _buildActionButtons(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgressHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 179, 58, 58).withOpacity(0.05),
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 179, 58, 58),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit ${widget.product.name}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Update product details',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      179,
                      58,
                      58,
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: const Color.fromARGB(255, 179, 58, 58),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildProductInfoFields() {
    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: [
        AppTextFormField(
          controller: nameController,
          labelText: 'Product Name *',
          hintText: 'Enter product name',
          prefixIcon: Icons.label,
          validator: (v) => v!.isEmpty ? 'Please enter a product name' : null,
        ),
        AppTextFormField(
          controller: descriptionController,
          labelText: 'Description',
          hintText: 'Enter product description',
          prefixIcon: Icons.description,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildPricingFields() {
    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: [
        AppTextFormField(
          controller: priceController,
          labelText: 'Price *',
          hintText: 'Enter price',
          prefixIcon: Icons.sell,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Please enter a price';
            if (double.tryParse(v) == null)
              return 'Please enter a valid number';
            return null;
          },
        ),
        AppTextFormField(
          controller: quantityController,
          labelText: 'Quantity *',
          hintText: 'Enter quantity',
          prefixIcon: Icons.production_quantity_limits,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Please enter a quantity';
            if (int.tryParse(v) == null) return 'Please enter a valid integer';
            return null;
          },
        ),
        AppTextFormField(
          controller: taxController,
          labelText: 'Tax % (Optional)',
          hintText: 'Enter tax percentage',
          prefixIcon: Icons.percent,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v != null && v.isNotEmpty) {
              if (double.tryParse(v) == null)
                return 'Please enter a valid number';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: BorderSide(color: Colors.grey.shade400),
              ),
              child: const Text('Cancel', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              onPressed: _saveProduct,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveProduct() {
    if (formKey.currentState?.validate() ?? false) {
      final updatedProduct = ProductModel(
        id: widget.product.id,
        name: nameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: int.parse(quantityController.text),
        taxPercent: taxController.text.isNotEmpty
            ? double.parse(taxController.text)
            : null,
      );

      ref.read(productProvider.notifier).addOrUpdateProduct(updatedProduct);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product updated successfully!')),
      );
    }
  }
}
