import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/paywall/domain/paywall_product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });
  final PaywallProduct product;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ProductCardPainter(product),
      child: ListTile(
        title: Text(product.title),
        subtitle: Text(product.price),
      ),
    );
  }
}

class ProductCardPainter extends CustomPainter {
  const ProductCardPainter(this.product);
  final PaywallProduct product;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
