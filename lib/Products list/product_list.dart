import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductListPage extends StatelessWidget {
  final String baseUrl = "https://api.routelift.com/api/test";

  const ProductListPage({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final dynamic decodedResponse = json.decode(response.body);

      if (decodedResponse['success'] == true &&
          decodedResponse['data'] is List) {
        return List<Map<String, dynamic>>.from(decodedResponse['data']);
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }

  void _showProductDetails(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(product['productName']),
          content: Text(product['description'] ?? 'No description available'),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkout(Map<String, dynamic> product) async {
    final checkoutUrl = '$baseUrl/checkout';
    final checkoutData = {
      "productName": product['productName'],
      "price": product['productPrice'],
      "quantity": 1, // You may adjust the quantity as needed
    };

    try {
      final response = await http.post(
        Uri.parse(checkoutUrl),
        body: jsonEncode(checkoutData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Handle successful checkout response
        debugPrint('Checkout successful!');
      } else {
        // Handle checkout failure
        debugPrint('Checkout failed. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      debugPrint('Error during checkout: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Images'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> products = snapshot.data ?? [];

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index]['productName']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: \$${products[index]['productPrice']}'),
                      Text('Calories: ${products[index]['calories']}'),
                      Text(
                          'Time to Prepare: ${products[index]['timeToPrepare']} minutes'),
                      Text('Rating: ${products[index]['rating']}'),
                    ],
                  ),
                  leading: Image.network(
                    products[index]['image'],
                    width: 100.0,
                    height: 300.0,
                    fit: BoxFit.contain,
                  ),
                  onTap: () {
                    _showProductDetails(context, products[index]);
                  },
                  onLongPress: () {
                    _checkout(products[index]);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
