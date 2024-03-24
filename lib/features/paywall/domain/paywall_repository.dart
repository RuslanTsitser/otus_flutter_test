import 'paywall_product.dart';

abstract class PaywallRepository {
  Future<List<PaywallProduct>> getProducts([int? count]);
}
