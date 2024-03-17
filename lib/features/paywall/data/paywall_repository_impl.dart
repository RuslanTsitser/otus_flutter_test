import 'package:flutter_application_1/features/paywall/domain/paywall_product.dart';
import 'package:flutter_application_1/features/paywall/domain/paywall_repository.dart';

class PaywallRepositoryImpl implements PaywallRepository {
  // TODO: add dependency to service like Apphud, RevenueCat, etc.

  @override
  Future<List<PaywallProduct>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      const PaywallProduct(
        title: 'Premium',
        price: '\$9.99',
      ),
      const PaywallProduct(
        title: 'Gold',
        price: '\$4.99',
      ),
      const PaywallProduct(
        title: 'Silver',
        price: '\$1.99',
      ),
    ];
  }
}
