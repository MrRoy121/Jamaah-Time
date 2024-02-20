import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
    } catch (error) {
      print('Error deleting product: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final product = snapshot.data!.docs[index];
              final imageUrl = product['imageUrl']; // Get the image URL
              return ListTile(
                leading: imageUrl != null
                    ? Container(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
                    : Container(width: 100, height: 100), // Display empty container if no image URL
                title: Text(product['name']),
                subtitle: Text('\$${product['price']}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteProduct(product.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
