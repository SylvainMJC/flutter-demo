import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../bo/product.dart';
import 'detail_page.dart';

class ListProductsPage extends StatelessWidget {
  ListProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
      ),
      body: ListView.builder(
        itemCount: listProducts.length,
        itemBuilder: (context, index) {
          final product = listProducts[index];
          return InkWell(
            child: ListTile(
              leading: Image.asset(
                product.image,
                width: 50,
                height: 50,
              ),
              title: Text(product.name),
              subtitle: Text(product.displayPrice()),
              onTap: () => context.go("/detail/${product.id}"),
            ),
          );
        },
      ),
    );
  }
}
