import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/core/routes/route_names.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/features/quote/quote_provider.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/ui_constants/app_button.dart';

class ManageQuotesScreen extends ConsumerWidget {
  const ManageQuotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotesState = ref.watch(quoteProvider);
    final quotesNotifier = ref.read(quoteProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
        title: const Text("Manage Quotations"),
      ),
      body: quotesState.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No quotations yet!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Create your first quotation to see it here.",
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 200,
                    child: AppButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, RouteNames.createQuote),
                      child: const Text("Create New Quote"),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: quotesState.length,
              itemBuilder: (context, index) {
                final quote = quotesState[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.quoteDetail,
                        arguments: quote.id,
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 40,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  quote.title,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '#${quote.quoteNumber} • ${quote.client.name}',
                                  style: TextStyle(color: Colors.grey.shade600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      '₹${quote.totalAmount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green.shade800,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      DateFormat(
                                        'dd MMM yyyy',
                                      ).format(quote.date),
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'delete') {
                                quotesNotifier.deleteQuote(quote.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Quote "${quote.title}" deleted.',
                                    ),
                                  ),
                                );
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ),
                                      title: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: quotesState.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () =>
                  Navigator.pushNamed(context, RouteNames.createQuote),
              label: const Text("New Quote"),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }
}
