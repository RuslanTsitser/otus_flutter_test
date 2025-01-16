import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/paywall/data/paywall_repository_impl.dart';
import 'package:flutter_application_1/features/paywall/logic/products_notifier.dart';
import 'package:flutter_application_1/features/paywall/presentation/paywall_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
        enabled: false,
        builder: (context) {
          return ChangeNotifierProvider(
            create: (context) => ProductsNotifier(PaywallRepositoryImpl()),
            child: const MaterialApp(
              home: PaywallScreen(),
            ),
          );
        });
  }
}
