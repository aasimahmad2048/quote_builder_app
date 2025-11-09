import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/terms_model.dart';
import '../../ui_constants/app_button.dart';
import '../../ui_constants/app_textForm_field.dart';
import 'terms_provider.dart';

class EditTermsScreen extends ConsumerStatefulWidget {
  final TermsModel term;
  const EditTermsScreen({super.key, required this.term});

  @override
  ConsumerState<EditTermsScreen> createState() => _EditTermsScreenState();
}

class _EditTermsScreenState extends ConsumerState<EditTermsScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.term.title);
    descriptionController = TextEditingController(
      text: widget.term.description,
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit T&C Template'),
        backgroundColor: const Color.fromARGB(255, 179, 58, 58),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AppTextFormField(
                          prefixIcon: Icons.title,
                          labelText: 'Title *',
                          hintText: 'e.g., Payment Terms, Warranty',
                          validator: (v) =>
                              v!.isEmpty ? 'Please enter a title' : null,
                          controller: titleController,
                        ),
                        const SizedBox(height: 16),
                        AppTextFormField(
                          prefixIcon: Icons.description,
                          controller: descriptionController,
                          labelText: 'Description *',
                          hintText: 'Enter the full terms and conditions text...',
                          maxLines: 8,
                          validator: (v) => v!.isEmpty
                              ? 'Please enter a description'
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 16),
                  child: AppButton(
                    onPressed: _updateTerm,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateTerm() {
    if (formKey.currentState?.validate() ?? false) {
      final updatedTerm = TermsModel(
        id: widget.term.id,
        title: titleController.text,
        description: descriptionController.text,
      );
      ref.read(termsProvider.notifier).addOrUpdateTerm(updatedTerm);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Term updated successfully!')),
      );
    }
  }
}
