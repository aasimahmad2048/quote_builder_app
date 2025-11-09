import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/core/routes/route_names.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/data/models/temp_model.dart';
import 'client_provider.dart';

class ClientDetailScreen extends ConsumerWidget {
  final String clientId;
  const ClientDetailScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(clientProvider.notifier).getClientById(clientId);

    return Scaffold(
      appBar: AppBar(
        title: Text(client?.name ?? 'Client Detail'),
        backgroundColor: const Color.fromARGB(255, 179, 58, 58),
        foregroundColor: Colors.white,
        actions: [
          if (client != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.editClient,
                  arguments: client,
                );
              },
            ),
        ],
      ),
      body: client == null
          ? const Center(child: Text("Client not found"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildInfoCard(
                    title: 'Contact Information',
                    children: [
                      _buildDetailItem(Icons.person, 'Name', client.name),
                      _buildDetailItem(Icons.email, 'Email', client.email),
                      _buildDetailItem(Icons.phone, 'Phone', client.phone),
                      _buildDetailItem(
                        Icons.location_on,
                        'Address',
                        client.address,
                      ),
                      _buildDetailItem(
                        Icons.category,
                        'Type',
                        client.type.isNotEmpty ? client.type : 'N/A',
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
