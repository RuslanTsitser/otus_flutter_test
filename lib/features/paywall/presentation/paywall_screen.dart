import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/paywall/logic/products_notifier.dart';
import 'package:provider/provider.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsNotifier = context.watch<ProductsNotifier>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paywall Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 48),
            const Text(
              'Unlock premium content',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (productsNotifier.products.isEmpty)
              ElevatedButton(
                key: const Key('fetch_products_button'),
                onPressed: () => productsNotifier.fetchProducts(),
                child: productsNotifier.loading ? const CircularProgressIndicator() : const Text('Fetch products'),
              )
            else
              ...productsNotifier.products.map(
                (product) => ListTile(
                  title: Text(product.title),
                  trailing: Text(product.price),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
