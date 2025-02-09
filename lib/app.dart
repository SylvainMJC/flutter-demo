import 'package:epsi_shop/bo/product.dart';
import 'package:epsi_shop/ui/pages/cart_page.dart';
import 'package:epsi_shop/ui/pages/detail_page.dart';
import 'package:epsi_shop/ui/pages/list_products_page.dart';
import 'package:epsi_shop/ui/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final router = GoRouter(routes: [
    GoRoute(
      path: "/",
      builder: (_, __) => ListProductsPage(),
      routes: [
        GoRoute(
          name: "detail",
          path: "detail/:idProduct",
          builder: (_, state) {
            int idProduct = int.parse(state.pathParameters["idProduct"] ?? "0");
            return DetailPage(idProduct: idProduct);
          },
        ),
        GoRoute(
          name: "cart",
          path: "cart",
          builder: (_, __) => CartPage(),
        ),
      ],
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'EPSI Shop : Sylvain Conan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
    );
  }
}
