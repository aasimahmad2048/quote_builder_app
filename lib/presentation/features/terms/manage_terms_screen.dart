import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/data/models/terms_model.dart';
import '../../../core/routes/route_names.dart';
import 'terms_provider.dart';

class ManageTermsScreen extends ConsumerStatefulWidget {
  const ManageTermsScreen({super.key});

  @override
  ConsumerState<ManageTermsScreen> createState() => _ManageTermsScreenState();
}

class _ManageTermsScreenState extends ConsumerState<ManageTermsScreen> {
  @override
  Widget build(BuildContext context) {
    final termsList = ref.watch(termsProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
        title: const Text('Manage Terms & Conditions'),
        backgroundColor: const Color.fromARGB(255, 179, 58, 58),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: termsList.isEmpty ? _buildEmptyState() : _buildTermsList(termsList),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.createTerm);
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
            Icons.description_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No Terms & Conditions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Create your first terms and conditions template to use in quotations',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsList(List<TermsModel> terms) {
    return Column(
      children: [
        // Summary Header
        _buildSummaryHeader(terms),

        // Terms List
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: terms.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final term = terms[index];
              return _buildTermCard(term, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryHeader(List<TermsModel> terms) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms & Conditions',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 4),
              Text(
                '${terms.length} template${terms.length == 1 ? '' : 's'}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 179, 58, 58),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 179, 58, 58).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.description,
              color: const Color.fromARGB(255, 179, 58, 58),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermCard(TermsModel term, int index) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          _showTermDetails(term);
        },
        onLongPress: () => _showDeleteDialog(term),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Term Icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        179,
                        58,
                        58,
                      ).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.description,
                      color: const Color.fromARGB(255, 179, 58, 58),
                      size: 20,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Term Title
                  Expanded(
                    child: Text(
                      term.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Action Buttons
                  _buildActionButtons(term),
                ],
              ),

              const SizedBox(height: 8),

              // Term Description
              Text(
                term.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              // Created Date (if available)
              // if (term.createdAt != null) ...[
              //   Divider(color: Colors.grey.shade300, height: 1),
              //   const SizedBox(height: 8),
              //   Text(
              //     'Created: ${_formatDate(term.createdAt!)}',
              //     style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              //   ),
              // ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(TermsModel term) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Edit Button
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.editTerm, arguments: term);
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit, size: 14, color: Colors.blue.shade700),
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
          onTap: () => _showDeleteDialog(term),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red.shade100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.delete_outline,
                  size: 14,
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

  void _showTermDetails(TermsModel term) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.description,
              color: const Color.fromARGB(255, 179, 58, 58),
            ),
            const SizedBox(width: 8),
            Text(
              term.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                term.description,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
              // if (term.createdAt != null) ...[
              //   const SizedBox(height: 16),
              //   Divider(color: Colors.grey.shade300),
              //   Text(
              //     'Created: ${_formatDate(term.createdAt!)}',
              //     style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              //   ),
              // ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                RouteNames.editTerm,
                arguments: term,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 179, 58, 58),
              foregroundColor: Colors.white,
            ),
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(TermsModel term) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            SizedBox(width: 8),
            Text('Delete Term'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to delete "${term.title}"?',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              term.description,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            const Text(
              'This term will be removed from all quotations using it.',
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
              ref.read(termsProvider.notifier).deleteTerm(term.id);
              Navigator.pop(context);

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"${term.title}" deleted successfully'),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
