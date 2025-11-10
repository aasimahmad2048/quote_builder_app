import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/terms_model.dart';
import '../../ui_constants/app_button.dart';
import '../../ui_constants/app_textForm_field.dart';
import 'terms_provider.dart';

class CreateTermsScreen extends ConsumerStatefulWidget {
  const CreateTermsScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTermsScreenState();
}

class _CreateTermsScreenState extends ConsumerState<CreateTermsScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

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
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
        title: const Text('Create T&C Template'),
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
                          hintText:
                              'Enter the full terms and conditions text...',
                          maxLines: 8,
                          validator: (v) =>
                              v!.isEmpty ? 'Please enter a description' : null,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 16),
                  child: AppButton(
                    onPressed: _createTerm,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Create Template',
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

  void _createTerm() {
    if (formKey.currentState?.validate() ?? false) {
      final newTerm = TermsModel(
        id: const Uuid().v4(),
        title: titleController.text,
        description: descriptionController.text,
      );
      ref.read(termsProvider.notifier).addOrUpdateTerm(newTerm);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Term created successfully!')),
      );

      // Logic to create term
    }
  }
}
