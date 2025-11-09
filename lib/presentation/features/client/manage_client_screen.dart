import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/data/models/temp_model.dart';
import '../../../core/routes/route_names.dart';
import 'client_provider.dart';

class ManageClientScreen extends ConsumerStatefulWidget {
  const ManageClientScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ManageClientScreenState();
}

class _ManageClientScreenState extends ConsumerState<ManageClientScreen> {
  @override
  Widget build(BuildContext context) {
    final clientList = ref.watch(clientProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Clients'),
        backgroundColor: const Color.fromARGB(255, 179, 58, 58),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: clientList.isEmpty
          ? _buildEmptyState(context)
          : _buildClientList(clientList),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.createClient);
        },
        backgroundColor: const Color.fromARGB(255, 179, 58, 58),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No Clients Yet',
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
              'Tap the + button to add your first client',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientList(List<ClientModel> clients) {
    return Column(
      children: [
        _buildSummaryHeader(clients),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: clients.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final client = clients[index];
              return _buildClientCard(context, client);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryHeader(List<ClientModel> clients) {
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
                'Total Clients',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 4),
              Text(
                '${clients.length} client${clients.length == 1 ? '' : 's'}',
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
              Icons.people,
              color: const Color.fromARGB(255, 179, 58, 58),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientCard(BuildContext context, ClientModel client) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteNames.clientDetail,
            arguments: client.id,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromARGB(
                  255,
                  179,
                  58,
                  58,
                ).withOpacity(0.1),
                foregroundColor: const Color.fromARGB(255, 179, 58, 58),
                child: const Icon(Icons.person_outline),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      client.email,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              _buildActionButtons(context, client),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, ClientModel client) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'edit') {
          Navigator.pushNamed(
            context,
            RouteNames.editClient,
            arguments: client,
          );
        } else if (value == 'delete') {
          _showDeleteDialog(context, client);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'edit',
          child: ListTile(
            leading: Icon(Icons.edit_outlined),
            title: Text('Edit'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete_outline, color: Colors.red),
            title: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, ClientModel client) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Client"),
        content: Text("Are you sure you want to delete ${client.name}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(clientProvider.notifier).deleteClient(client.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${client.name} deleted.')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
