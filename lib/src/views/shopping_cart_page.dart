import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/app_bar.dart';
import '../providers/cart_provider.dart';
import 'order_registry_page.dart';

class ShoppingCartPage extends StatelessWidget {
  static const routeName = '/shopping-cart';

  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: MyAppBar(title: 'JustShoes'),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.fromLTRB(25, 20, 25, 10),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10,),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.headlineSmall?.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderRegistryPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF246EB9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                    child: Text('ORDER NOW', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) {
                final item = cart.items.values.toList()[i];
                return CartItemWidget(
                  id: item.id,
                  productId: cart.items.keys.toList()[i],
                  name: item.name,
                  brand: item.brand,
                  imageUrl: item.imageUrl,
                  quantity: item.quantity,
                  price: item.price,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final String id;
  final String productId;
  final String name;
  final String brand;
  final String imageUrl;
  final int quantity;
  final double price;

  CartItemWidget({
    required this.id,
    required this.productId,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Card(
      margin: EdgeInsets.fromLTRB(25, 0, 25, 10),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(brand),
              Text('Total: \$${(price * quantity).toStringAsFixed(2)}'),
            ],
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      cart.updateItemQuantity(productId, quantity + 1);
                    },
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text('$quantity x', style: TextStyle(fontSize: 14, color: Colors.black)),
                  SizedBox(width: 10,),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (quantity > 1) {
                        cart.updateItemQuantity(productId, quantity - 1);
                      }
                    },
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(width: 30,),
                  IconButton(
                    icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                    onPressed: () {
                      cart.removeItem(productId);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
