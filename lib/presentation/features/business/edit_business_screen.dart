import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/business_model.dart';
import '../../ui_constants/app_button.dart';
import '../../ui_constants/app_textForm_field.dart';
import 'business_provider.dart';

class EditBusinessScreen extends ConsumerStatefulWidget {
  final BusinessModel business;
  const EditBusinessScreen({super.key, required this.business});

  @override
  ConsumerState<EditBusinessScreen> createState() => _EditBusinessScreenState();
}

class _EditBusinessScreenState extends ConsumerState<EditBusinessScreen> {
  final formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  late final TextEditingController nameController;
  late final TextEditingController addressController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController websiteController;
  late final TextEditingController taxIdController;
  late final TextEditingController bankNameController;
  late final TextEditingController bankAccountController;
  late final TextEditingController swiftCodeController;
  late final TextEditingController currencyController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing business data
    nameController = TextEditingController(text: widget.business.name);
    addressController = TextEditingController(text: widget.business.address);
    phoneController = TextEditingController(text: widget.business.phone);
    emailController = TextEditingController(text: widget.business.email);
    websiteController = TextEditingController(
      text: widget.business.website ?? '',
    );
    taxIdController = TextEditingController(text: widget.business.taxId ?? '');
    bankNameController = TextEditingController(
      text: widget.business.bankName ?? '',
    );
    bankAccountController = TextEditingController(
      text: widget.business.bankAccount ?? '',
    );
    swiftCodeController = TextEditingController(
      text: widget.business.swiftCode ?? '',
    );
    currencyController = TextEditingController(
      text: widget.business.currency ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    emailController.dispose();
    websiteController.dispose();
    taxIdController.dispose();
    bankNameController.dispose();
    bankAccountController.dispose();
    swiftCodeController.dispose();
    currencyController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Business Profile'),
        backgroundColor: const Color.fromARGB(255, 179, 58, 58),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _showDeleteDialog,
            tooltip: 'Delete Business',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isWideScreen ? 48 : 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Progress Header
                _buildProgressHeader(),

                // Form Content
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // Business Information Section
                        _buildSection(
                          context: context,
                          title: 'Business Information',
                          icon: Icons.business,
                          children: [_buildBusinessInfoFields()],
                        ),

                        const SizedBox(height: 24),

                        // Contact Details Section
                        _buildSection(
                          context: context,
                          title: 'Contact Details',
                          icon: Icons.contact_page,
                          children: [_buildContactFields()],
                        ),

                        const SizedBox(height: 24),

                        // Financial Information Section
                        _buildSection(
                          context: context,
                          title: 'Financial Information',
                          icon: Icons.account_balance_wallet,
                          children: [_buildFinancialFields()],
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),

                // Action Buttons
                _buildActionButtons(),
              ],
            ),
          ),
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
                  'Edit ${widget.business.name}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Update your business information',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Editing',
              style: TextStyle(
                fontSize: 12,
                color: Colors.orange.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
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
            // Section Header
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

            // Section Content
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessInfoFields() {
    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: [
        AppTextFormField(
          controller: nameController,
          labelText: 'Business Name *',
          hintText: 'Enter your business name',
          prefixIcon: Icons.business_center,
          validator: (v) => v!.isEmpty ? 'Business name is required' : null,
        ),
        AppTextFormField(
          controller: addressController,
          labelText: 'Business Address *',
          hintText: 'Enter your business address',
          prefixIcon: Icons.location_on,
          maxLines: 3,
          validator: (v) => v!.isEmpty ? 'Business address is required' : null,
        ),
      ],
    );
  }

  Widget _buildContactFields() {
    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: [
        AppTextFormField(
          controller: phoneController,
          labelText: 'Phone Number *',
          hintText: 'Enter phone number',
          prefixIcon: Icons.phone,
          keyboardType: TextInputType.phone,
          validator: (v) => v!.isEmpty ? 'Phone number is required' : null,
        ),
        AppTextFormField(
          controller: emailController,
          labelText: 'Email Address *',
          hintText: 'Enter email address',
          prefixIcon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          validator: (v) {
            if (v == null || v.isEmpty) {
              return 'Email address is required';
            }
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
        AppTextFormField(
          controller: websiteController,
          labelText: 'Website',
          hintText: 'https://example.com',
          prefixIcon: Icons.web,
          keyboardType: TextInputType.url,
        ),
      ],
    );
  }

  Widget _buildFinancialFields() {
    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: [
        AppTextFormField(
          controller: taxIdController,
          labelText: 'Tax Identification Number',
          hintText: 'Enter tax ID number',
          prefixIcon: Icons.receipt_long,
        ),
        AppTextFormField(
          controller: bankNameController,
          labelText: 'Bank Name',
          hintText: 'Enter your bank name',
          prefixIcon: Icons.account_balance,
        ),
        AppTextFormField(
          controller: bankAccountController,
          labelText: 'Bank Account Number',
          hintText: 'Enter account number',
          prefixIcon: Icons.credit_card,
          keyboardType: TextInputType.number,
        ),
        AppTextFormField(
          controller: swiftCodeController,
          labelText: 'SWIFT/BIC Code',
          hintText: 'Enter SWIFT code',
          prefixIcon: Icons.qr_code,
        ),
        AppTextFormField(
          controller: currencyController,
          labelText: 'Primary Currency',
          hintText: 'e.g., USD, EUR, INR',
          prefixIcon: Icons.currency_exchange,
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
          // Cancel Button
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

          // Update Button
          Expanded(
            child: AppButton(
              onPressed: _updateBusiness,
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

  void _updateBusiness() {
    if (!formKey.currentState!.validate()) {
      // Scroll to the first error
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      return;
    }

    final updatedBusiness = BusinessModel(
      id: widget.business.id,
      name: nameController.text.trim(),
      address: addressController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      website: websiteController.text.trim().isNotEmpty
          ? websiteController.text.trim()
          : null,
      taxId: taxIdController.text.trim().isNotEmpty
          ? taxIdController.text.trim()
          : null,
      bankName: bankNameController.text.trim().isNotEmpty
          ? bankNameController.text.trim()
          : null,
      bankAccount: bankAccountController.text.trim().isNotEmpty
          ? bankAccountController.text.trim()
          : null,
      swiftCode: swiftCodeController.text.trim().isNotEmpty
          ? swiftCodeController.text.trim()
          : null,
      currency: currencyController.text.trim().isNotEmpty
          ? currencyController.text.trim()
          : null,
       
    );

    ref.read(businessProvider.notifier).addOrUpdateBusiness(updatedBusiness);

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${updatedBusiness.name} updated successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            SizedBox(width: 8),
            Text('Delete Business?'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to delete "${widget.business.name}"?',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text(
              'This action cannot be undone. All associated data will be lost.',
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
              ref
                  .read(businessProvider.notifier)
                  .deleteBusiness(widget.business.id);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to previous screen

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '"${widget.business.name}" deleted successfully',
                  ),
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
