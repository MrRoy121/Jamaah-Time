import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jamaah_time/User%20panel/e-shoping/productDetailsPage.dart';
import 'package:jamaah_time/User%20panel/e-shoping/productItem.dart';

class UserShopping extends StatefulWidget {
  const UserShopping({Key? key}) : super(key: key);

  @override
  State<UserShopping> createState() => _UserShoppingState();
}

class _UserShoppingState extends State<UserShopping> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<DocumentSnapshot>? products;

  Future<void> getProducts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('products').get();
      setState(() {
        products = querySnapshot.docs;
      });
    } catch (e) {
      print('Error getting products: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'Assets/logo.png',
          width: 10,
          height: 10,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                "Jama'ah Time",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Alhamdulillah – All praise is for Allah.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (products != null)
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products!.length,
                  itemBuilder: (context, index) {
                    final product = products![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              imageUrl: product['imageUrl'],
                              name: product['name'],
                              price: product['price'].toString(),
                              description: product['description'],
                              category: product['category'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ProductItem(
                          imageUrl: product['imageUrl'],
                          name: product['name'],
                          price: product['price'].toString(),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
