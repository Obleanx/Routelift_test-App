import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:routelift_app/components/bottom_navbar.dart';
import 'package:routelift_app/components/nav_bar.dart';
import 'package:routelift_app/screens/product_details_screen.dart';

class HomePage extends StatelessWidget {
  // the API Base URL given to me
  final String baseUrl = "https://api.routelift.com/api/test";

//the fuction to fetch the Data(products image) from the internet
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
      "quantity": 1,
      // You may adjust the quantity as needed should incase there are more products in the popular category.. this function allows that
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

  // text styles constants so i dont have to be styling text all the time
  static const TextStyle customTextStyle = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle categoryTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle popularNowTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle priceTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xff0000000),
  );

//the home screen  starting from the very top of the app screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Map<String, dynamic>> products = snapshot.data ?? [];

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  TopNavigationBar(),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildText('Good Food.'),
                      _buildText('Fast Delivery.'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildCategoryRow(),
                  const SizedBox(height: 20),
                  _buildText(
                    'Popular now',
                    fontSize: 20,
                    textStyle: popularNowTextStyle,
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: products.map((product) {
                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(4, 9),
                              ),
                            ],
                          ),
                          child: _buildRecipeContainer(
                            context,
                            product['productName'] ?? 'Product',
                            product['image'] ?? 'lib/images/default_image.png',
                            product['productPrice'] != null
                                ? '\$${product['productPrice']}'
                                : 'Price not available',
                            product['description'] ??
                                'No description available',
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const BottomNavBar(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

//the container class that build and displays the Product images
  Widget _buildRecipeContainer(BuildContext context, String title,
      String imagePath, String price, String description) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          _navigateToProductDetails(context, imagePath, description);
        },
        child: Container(
          height: 360,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.network(
                  imagePath,
                  height: 110,
                  width: 110,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  description,
                  style: categoryTextStyle,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      price,
                      style: priceTextStyle,
                    ),
                  ),
                  const SizedBox(width: 85),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: priceTextStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//the call back functions that help to navigate to the product description screen for checking out
  void _navigateToProductDetails(
      BuildContext context, String imagePath, String description) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          imagePath: imagePath,
          description: description,
        ),
      ),
    );
  }

  Widget _buildText(String text,
      {double? fontSize, FontWeight? fontWeight, TextStyle? textStyle}) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Text(
        text,
        style: textStyle ?? customTextStyle,
      ),
    );
  }

//category rows class
  Widget _buildCategoryRow() {
    return Container(
      margin: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          // Handle container tap
        },
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    _buildCategoryItem('lib/images/fries.jpeg', 'Main'),
                    const SizedBox(width: 10),
                    _buildCategoryItem('lib/images/nodus.jpeg', 'Soups'),
                    const SizedBox(width: 10),
                    _buildCategoryItem('lib/images/salad.jpeg', 'Salads'),
                    const SizedBox(width: 10),
                    _buildCategoryItem('lib/images/drinks.jpeg', 'Drinks'),
                    const SizedBox(width: 10),
                    _buildCategoryItem(
                        'lib/images/chops.jpeg', 'Chips / Fries'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

//the category item methods
  Widget _buildCategoryItem(String imagePath, String category) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(category, style: categoryTextStyle),
        ),
      ],
    );
  }
}
