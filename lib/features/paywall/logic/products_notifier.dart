import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/paywall/domain/paywall_product.dart';
import 'package:flutter_application_1/features/paywall/domain/paywall_repository.dart';

class ProductsNotifier extends ChangeNotifier {
  final PaywallRepository _paywallRepository;

  ProductsNotifier(this._paywallRepository);

  List<PaywallProduct> _products = [];
  List<PaywallProduct> get products => _products;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> fetchProducts() async {
    _loading = true;
    notifyListeners();
    _products = await _paywallRepository.getProducts();
    _loading = false;
    notifyListeners();
  }
}
