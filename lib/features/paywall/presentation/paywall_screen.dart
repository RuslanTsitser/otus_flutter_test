import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/paywall/logic/products_notifier.dart';
import 'package:flutter_application_1/features/paywall/presentation/components/product_card.dart';
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
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: () => productsNotifier.fetchProducts(),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                const SizedBox(height: 48),
                const Text(
                  'Unlock premium content',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
              ])),
              if (productsNotifier.products.isEmpty)
                SliverToBoxAdapter(
                  child: ElevatedButton(
                    key: const Key('fetch_products_button'),
                    onPressed: () => productsNotifier.fetchProducts(),
                    child: productsNotifier.loading
                        ? const SizedBox.square(
                            dimension: 24,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Fetch products'),
                  ),
                ),
              if (constraints.maxWidth > 600)
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = productsNotifier.products[index];
                      return ProductCard(product: product);
                    },
                    childCount: productsNotifier.products.length,
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = productsNotifier.products[index];
                      return ProductCard(product: product);
                    },
                    childCount: productsNotifier.products.length,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
