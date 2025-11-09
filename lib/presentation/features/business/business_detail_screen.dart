import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/data/models/business_model.dart';
import 'business_provider.dart';

class BusinessDetailScreen extends ConsumerStatefulWidget {
  const BusinessDetailScreen({super.key});

  @override
  ConsumerState<BusinessDetailScreen> createState() =>
      _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends ConsumerState<BusinessDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final businessId = ModalRoute.of(context)?.settings.arguments as String?;

    if (businessId == null) {
      return _buildErrorScreen("No Business ID provided");
    }

    final business = ref
        .watch(businessProvider.notifier)
        .getBusinessById(businessId);

    return Scaffold(
      appBar: AppBar(
        title: Text(business?.name ?? 'Business Details'),
        backgroundColor: const Color.fromARGB(255, 179, 58, 58),
        foregroundColor: Colors.white,
        actions: [
          if (business != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _navigateToEditBusiness(business),
              tooltip: 'Edit Business',
            ),
        ],
      ),
      body: business == null
          ? _buildErrorScreen("Business not found")
          : _buildBusinessDetails(business),
    );
  }

  Widget _buildErrorScreen(String message) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Details'),
        backgroundColor: const Color.fromARGB(255, 179, 58, 58),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.business_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 179, 58, 58),
                foregroundColor: Colors.white,
              ),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessDetails(BusinessModel business) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Business Header Card
          _buildBusinessHeader(business),

          const SizedBox(height: 20),

          // Contact Information
          _buildInfoCard(
            title: 'Contact Information',
            icon: Icons.contact_phone,
            children: [
              _buildDetailItem(
                icon: Icons.business,
                label: 'Business Name',
                value: business.name,
                isImportant: true,
              ),
              _buildDetailItem(
                icon: Icons.location_on,
                label: 'Address',
                value: business.address,
                isImportant: true,
              ),
              _buildDetailItem(
                icon: Icons.phone,
                label: 'Phone',
                value: business.phone,
                isImportant: true,
              ),
              _buildDetailItem(
                icon: Icons.email,
                label: 'Email',
                value: business.email,
                isImportant: true,
              ),
              _buildDetailItem(
                icon: Icons.web,
                label: 'Website',
                value: business.website,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Financial Details
          _buildInfoCard(
            title: 'Financial Details',
            icon: Icons.account_balance_wallet,
            children: [
              _buildDetailItem(
                icon: Icons.receipt_long,
                label: 'Tax ID',
                value: business.taxId,
              ),
              _buildDetailItem(
                icon: Icons.account_balance,
                label: 'Bank Name',
                value: business.bankName,
              ),
              _buildDetailItem(
                icon: Icons.credit_card,
                label: 'Bank Account',
                value: business.bankAccount,
              ),
              _buildDetailItem(
                icon: Icons.qr_code,
                label: 'SWIFT Code',
                value: business.swiftCode,
              ),
              _buildDetailItem(
                icon: Icons.currency_exchange,
                label: 'Currency',
                value: business.currency,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Additional Information
          _buildInfoCard(
            title: 'Additional Information',
            icon: Icons.info_outline,
            children: [],
          ),

          const SizedBox(height: 24),

          // Action Buttons
          _buildActionButtons(business),
        ],
      ),
    );
  }

  Widget _buildBusinessHeader(BusinessModel business) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 179, 58, 58).withOpacity(0.8),
              const Color.fromARGB(255, 179, 58, 58).withOpacity(0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              radius: 30,
              child: Icon(Icons.business, size: 32, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              business.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            if (business.email.isNotEmpty)
              Text(
                business.email,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Business Profile',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
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
            Row(
              children: [
                Icon(
                  icon,
                  color: const Color.fromARGB(255, 179, 58, 58),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String? value,
    bool isImportant = false,
  }) {
    final displayValue = value?.isNotEmpty == true ? value! : 'Not provided';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isImportant
                  ? const Color.fromARGB(255, 179, 58, 58).withOpacity(0.1)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: isImportant
                  ? const Color.fromARGB(255, 179, 58, 58)
                  : Colors.grey.shade600,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  displayValue,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isImportant
                        ? FontWeight.w500
                        : FontWeight.normal,
                    color: isImportant ? Colors.black87 : Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BusinessModel business) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _navigateToEditBusiness(business),
            icon: const Icon(Icons.edit),
            label: const Text('Edit Business'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: BorderSide(color: const Color.fromARGB(255, 179, 58, 58)),
              foregroundColor: const Color.fromARGB(255, 179, 58, 58),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _shareBusinessDetails(business),
            icon: const Icon(Icons.share),
            label: const Text('Share'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              backgroundColor: const Color.fromARGB(255, 179, 58, 58),
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToEditBusiness(BusinessModel business) {
    // Navigate to edit business screen
    // Navigator.pushNamed(context, RouteNames.editBusiness, arguments: business);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit ${business.name}'),
        backgroundColor: const Color.fromARGB(255, 179, 58, 58),
      ),
    );
  }

  void _shareBusinessDetails(BusinessModel business) {
    // Implement share functionality
    final shareText =
        '''
${business.name}
${business.address}

Phone: ${business.phone}
Email: ${business.email}
${business.website?.isNotEmpty == true ? 'Website: ${business.website}' : ''}
''';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Share ${business.name} details'),
        backgroundColor: Colors.green,
      ),
    );

    // For actual sharing, you would use:
    // Share.share(shareText);
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
