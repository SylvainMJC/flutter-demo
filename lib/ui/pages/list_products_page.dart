import 'package:epsi_shop/ui/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../bo/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../providers/cart_provider.dart';

class ListProductsPage extends StatelessWidget {
  ListProductsPage({super.key});

  Future<List<Product>> getProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> listMapProducts = jsonDecode(response.body);
      return listMapProducts.map((e) => Product.fromMap(e)).toList();
    } else {
      throw Exception('Échec du chargement des produits');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: "EPSI Shop"),
      body: FutureBuilder<List<Product>>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final listProducts = snapshot.data!;
            return ListView.builder(
              itemCount: listProducts.length,
              itemBuilder: (context, index) {
                final product = listProducts[index];
                return InkWell(
                  onTap: () => context.go("/detail/${product.id}"),
                  child: ListTile(
                    leading: Hero(
                      tag: product.image,
                      child: Image.network(
                        product.image,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    title: Text(product.title),
                    subtitle: Text(product.displayPrice()),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("Aucun produit disponible"));
          }
        },
      ),
    );
  }
}
