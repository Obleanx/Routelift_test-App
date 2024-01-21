import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routelift_app/screens/maps_page.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String imagePath;
  final String description;

  const ProductDetailsScreen({
    required this.imagePath,
    required this.description,
  });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int counter = 1;
  static const TextStyle popularNowTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
  late double height, width;

  // Method to calculate the total price
  // Method to calculate the product price based on amount/ quantity purchased or clicked
  double calculateTotalPrice() {
    double productPrice;

    if (widget.imagePath.contains('first_image')) {
      productPrice = 19.99;
    } else if (widget.imagePath.contains('second_image')) {
      productPrice = 24.99;
    } else if (widget.imagePath.contains('third_image')) {
      productPrice = 14.99;
    } else {
      productPrice = 14.99;
    }

    return productPrice * counter;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: height * .4,
                decoration: const BoxDecoration(
                  color: Color(0xff292c35),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff292c35),
                ),
                child: Container(
                  height: height * .2,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Positioned(
            top: 45,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.favorite, color: Colors.redAccent),
            ),
          ),
          const Positioned(
            top: 45,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(widget.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.stopwatch,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '30 mins',
                          style: popularNowTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.fire,
                          color: Color(0xffdfc578),
                        ),
                        SizedBox(
                          width: 5,
                          height: 5,
                        ),
                        Text(
                          '275 calouries',
                          style: popularNowTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.star,
                          color: Color(0xffbf932a),
                        ),
                        SizedBox(width: 8, height: 5),
                        Text(
                          '4.9',
                          style: popularNowTextStyle,
                        ), // Replace with actual star count
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text(
                    '${widget.description}',
                    style: popularNowTextStyle,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  // Functionality for decreasing the counter
                  counter++;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.grey[300], // Specify the background color
              ),
              child: Row(
                children: [
                  const Text(
                    '+',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ), // Specify the text color
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '$counter',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Functionality for increasing the counter
                        counter--;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      '-',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                // Navigate to the MapsPage when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapScreen()),
                );
              },
              child: Row(
                children: [
                  const Text(
                    'Checkout ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Displays product prices here based from the calculated method.
                  Text(
                    '\$${calculateTotalPrice().toStringAsFixed(01)}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ), // Displaying total price with 2 decimal places
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
