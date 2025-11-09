import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/business_model.dart';
import 'business_provider.dart';
import '../../ui_constants/app_button.dart';
import '../../ui_constants/app_textForm_field.dart';

class CreateBusinessScreen extends ConsumerStatefulWidget {
  const CreateBusinessScreen({super.key});

  @override
  ConsumerState<CreateBusinessScreen> createState() =>
      _CreateBusinessScreenState();
}

class _CreateBusinessScreenState extends ConsumerState<CreateBusinessScreen> {
  final formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Controllers
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
  final taxIdController = TextEditingController();
  final bankNameController = TextEditingController();
  final bankAccountController = TextEditingController();
  final swiftCodeController = TextEditingController();
  final currencyController = TextEditingController();

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
        title: const Text('Create Business Profile'),
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

                    // Submit Button
                    _buildSubmitButton(),
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
            child: const Icon(Icons.business, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Business Profile',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Fill in your business details to get started',
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

  Widget _buildSubmitButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              onPressed: _saveBusiness,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Create Business Profile',
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

  void _saveBusiness() {
    if (!formKey.currentState!.validate()) {
      // Scroll to the first error
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      return;
    }

    final newBusiness = BusinessModel(
      id: const Uuid().v4(),
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

    ref.read(businessProvider.notifier).addOrUpdateBusiness(newBusiness);

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${newBusiness.name} created successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
