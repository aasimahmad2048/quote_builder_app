import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/ui_constants/app_button.dart';

import '../../../data/models/temp_model.dart';
import '../../ui_constants/app_textForm_field.dart';
import 'client_provider.dart';

class EditClientScreen extends ConsumerStatefulWidget {
  final ClientModel client;
  const EditClientScreen({super.key, required this.client});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditClientScreenState();
}

class _EditClientScreenState extends ConsumerState<EditClientScreen> {
  final formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController typeController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.client.name);
    emailController = TextEditingController(text: widget.client.email);
    phoneController = TextEditingController(text: widget.client.phone);
    addressController = TextEditingController(text: widget.client.address);
    typeController = TextEditingController(text: widget.client.type);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    typeController.dispose();
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
        title: const Text('Edit Client'),
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
                              title: 'Contact Information',
                              icon: Icons.person,
                              children: [_buildContactFields()],
                            ),
                            const SizedBox(height: 24),
                            _buildSection(
                              title: 'Additional Details',
                              icon: Icons.location_city,
                              children: [_buildAdditionalFields()],
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
                  'Edit ${widget.client.name}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Update client details',
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

  Widget _buildContactFields() {
    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: [
        AppTextFormField(
          controller: nameController,
          labelText: 'Client Name *',
          hintText: 'Enter client name',
          prefixIcon: Icons.person_outline,
          validator: (v) => v!.isEmpty ? 'Please enter a client name' : null,
        ),
        AppTextFormField(
          controller: emailController,
          labelText: 'Email *',
          hintText: 'Enter email address',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Please enter an email';
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v))
              return 'Invalid email';
            return null;
          },
        ),
        AppTextFormField(
          controller: phoneController,
          labelText: 'Phone',
          hintText: 'Enter phone number',
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildAdditionalFields() {
    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: [
        AppTextFormField(
          controller: addressController,
          labelText: 'Address',
          hintText: 'Enter client address',
          prefixIcon: Icons.location_on_outlined,
          maxLines: 3,
        ),
        AppTextFormField(
          controller: typeController,
          labelText: 'Client Type',
          hintText: 'e.g., Individual, Company',
          prefixIcon: Icons.category_outlined,
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
              onPressed: _saveClient,
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

  void _saveClient() {
    if (formKey.currentState?.validate() ?? false) {
      final updatedClient = ClientModel(
        id: widget.client.id,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
        type: typeController.text,
      );
      ref.read(clientProvider.notifier).addOrUpdateClient(updatedClient);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Client updated successfully!')),
      );
    }
  }
}
