import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  String? _imageUrl;
  File? _imageFile;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Specify the file type as image
      allowMultiple: false, // Allow only single file selection
    );

    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> _submitProduct() async {
    if (_imageFile == null ||
        _productNameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _selectedCategory == null) {
      return;
    }

    try {
      final Reference ref = _storage.ref().child('product_images/${DateTime.now()}.jpg');
      await ref.putFile(_imageFile!);
      final imageUrl = await ref.getDownloadURL();

      await _firestore.collection('products').add({
        'name': _productNameController.text,
        'price': double.parse(_priceController.text),
        'description': _descriptionController.text,
        'imageUrl': imageUrl,
        'category': _selectedCategory,
      });

      // Show Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product added successfully'),
        ),
      );

      // Clear input fields and image
      _productNameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedCategory = null;
        _imageUrl = null;
        _imageFile = null;
      });
    } catch (error) {
      print('Error adding product: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: null,
            ),
            SizedBox(height: 12.0),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('categories').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                List<DropdownMenuItem<String>> categoryItems = [];
                for (var category in snapshot.data!.docs) {
                  categoryItems.add(DropdownMenuItem(
                    child: Text(category['name']),
                    value: category['name'],
                  ));
                }
                return DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: categoryItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Category'),
                );
              },
            ),
            SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 12.0),
            _imageFile != null ? Image.file(_imageFile!) : SizedBox(), // Only show image if it's selected
            SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: _submitProduct,
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
