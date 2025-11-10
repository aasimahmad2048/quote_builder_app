import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/core/routes/route_names.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/features/business/business_provider.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/features/client/client_provider.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/features/product/product_provider.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/features/quote/quote_provider.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/features/terms/terms_provider.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/ui_constants/app_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businessCount = ref.watch(businessProvider).length;
    final clientCount = ref.watch(clientProvider).length;
    final productCount = ref.watch(productProvider).length;
    final termsCount = ref.watch(termsProvider).length;
    final quoteCount = ref.watch(quoteProvider).length;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        automaticallyImplyLeading: false,
        title: const Text('Quotation Builder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Settings functionality coming soon!"),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 3),
                ),
              );

              // Navigator.pushNamed(context, RouteNames.appSettings);
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.errorScreen);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard(
              title: 'Create New Quotation',
              icon: Icons.add_box,
              color: Colors.blue,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.createQuote);
              },
            ),
            const SizedBox(height: 20),
            _buildSectionHeader('Management'),
            _buildCard(
              title: 'Manage Quotations',
              icon: Icons.receipt_long,
              color: Colors.deepPurple,
              count: quoteCount,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.manageQuotes);
              },
            ),
            _buildCard(
              title: 'Manage Clients',
              icon: Icons.people,
              color: Colors.green,
              count: clientCount,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.manageClients);
              },
            ),
            _buildCard(
              title: 'Manage Products',
              icon: Icons.shopping_bag,
              color: Colors.orange,
              count: productCount,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.manageProducts);
              },
            ),
            _buildCard(
              title: 'Manage Terms & Conditions',
              icon: Icons.description,
              color: Colors.teal,
              count: termsCount,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.manageTerms);
              },
            ),
            _buildCard(
              title: 'Manage Business Info',
              icon: Icons.business,
              color: Colors.redAccent,
              count: businessCount,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.manageBusiness);
              },
            ),
            const SizedBox(height: 20),
            _buildSectionHeader('Tools'),
            _buildCard(
              title: 'Discover Features',
              icon: Icons.explore,
              color: Colors.indigo,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Discover Features functionality coming soon!",
                    ),

                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 3),
                  ),
                );

                // Navigator.pushNamed(context, RouteNames.appSettings);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    int? count,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (count != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    count.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
