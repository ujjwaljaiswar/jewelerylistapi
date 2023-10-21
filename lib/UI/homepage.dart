import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchJewelryData() async {
  final response = await http.get(Uri.parse('https://fakestoreapi.com/products/category/jewelery'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load jewelry data');
  }
}
class JewelryListWidget extends StatefulWidget {
  @override
  _JewelryListWidgetState createState() => _JewelryListWidgetState();
}

class _JewelryListWidgetState extends State<JewelryListWidget> {
  List<dynamic> jewelryData = [];

  @override
  void initState() {
    super.initState();
    fetchJewelryData().then((data) {
      setState(() {
        jewelryData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jewelry List'),
      ),
      body: ListView.builder(
        itemCount: jewelryData.length,
        itemBuilder: (context, index) {
          final product = jewelryData[index];
          return ListTile(
            title: Text(product['title']),
            subtitle: Text('Price: \$${product['price']}'),
          );
        },
      ),
    );
  }
}
