import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const Navbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 80.0),
          child: IconButton(
            onPressed: () => context.go("/cart"),
            icon: Badge(
              label: Text(
                context.watch<CartProvider>().getAll().length.toString(),
              ),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
