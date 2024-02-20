import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final TextEditingController _categoryController = TextEditingController();

  void _addCategoryToFirebase(String categoryName) {
    FirebaseFirestore.instance.collection('categories').add({
      'name': categoryName,
    });
    _categoryController.clear();
  }

  void _deleteCategoryFromFirebase(String categoryId) {
    FirebaseFirestore.instance.collection('categories').doc(categoryId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Categories'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Category Name',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addCategoryToFirebase(_categoryController.text);
            },
            child: Text('Add Category'),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('categories').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot category = snapshot.data!.docs[index];
                      return ListTile(
                        title: Text(category['name']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteCategoryFromFirebase(category.id);
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}