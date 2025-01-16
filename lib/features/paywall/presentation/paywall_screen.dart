import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/paywall/logic/products_notifier.dart';
import 'package:flutter_application_1/features/paywall/presentation/components/product_card.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsNotifier = context.watch<ProductsNotifier>();
    return Scaffold(
      floatingActionButton: MyButton(),
      appBar: AppBar(
        title: const Text('Paywall Screen'),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: () async {}, // => productsNotifier.fetchProducts(),
              ),
              // SliverToBoxAdapter(
              //   child: MyImage(),
              // ),
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

class MyImage extends StatelessWidget {
  const MyImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
        'https://www.foodandwine.com/thmb/DI29Houjc_ccAtFKly0BbVsusHc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/crispy-comte-cheesburgers-FT-RECIPE0921-6166c6552b7148e8a8561f7765ddf20b.jpg');
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: const Key('refresh_button'),
      backgroundColor: Colors.red,
      onPressed: () {
        launchUrl(Uri.parse('https://www.google.com'));
      },
      child: const Icon(Icons.refresh),
    );
  }
}
