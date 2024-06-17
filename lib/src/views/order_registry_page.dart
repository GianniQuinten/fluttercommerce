import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../providers/cart_provider.dart';

class OrderRegistryPage extends StatefulWidget {
  const OrderRegistryPage({super.key});

  @override
  _OrderRegistryPageState createState() => _OrderRegistryPageState();
}

class _OrderRegistryPageState extends State<OrderRegistryPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submitOrder(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final cart = Provider.of<CartProvider>(context, listen: false);
      final orderData = {
        'userName': _nameController.text,
        'userAddress': _addressController.text,
        'items': cart.items.values.map((item) => {
          'shoeId': item.shoeId,
          'quantity': item.quantity,
        }).toList(),
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:4000/api/orders'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(orderData),
        );

        if (response.statusCode == 201) {
          cart.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Order submitted successfully')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to submit order')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Registry Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items.values.toList()[index];
                    return ListTile(
                      leading: Image.network(item.imageUrl),
                      title: Text(item.name),
                      subtitle: Text('Quantity: ${item.quantity}'),
                      trailing: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submitOrder(context),
                child: const Text('Submit Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
