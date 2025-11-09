
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'terms_provider.dart';

class TermsDetailScreen extends ConsumerStatefulWidget {
  final String termId;
  const TermsDetailScreen({super.key, required this.termId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TermsDetailScreenState();
}

class _TermsDetailScreenState extends ConsumerState<TermsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final term = ref.watch(termsProvider.notifier).getTermById(widget.termId);

    return Scaffold(
      appBar: AppBar(title: const Text('Term Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: term == null
            ? const Center(child: Text("Term not found"))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title: ${term.title}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Description: ${term.description}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
      ),
    );
  }
}
