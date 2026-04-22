///dependencies:
///  flutter:
///    sdk: flutter
///  firebase_core: ^2.24.0
///  cloud_firestore: ^4.13.0

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ✅ Firebase init
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InventoryPage(),
    );
  }
}

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final CollectionReference inventory =
      FirebaseFirestore.instance.collection('inventory');

  /// 🔹 Add Product
  void addProduct() {
    if (nameController.text.isNotEmpty &&
        priceController.text.isNotEmpty) {
      inventory.add({
        'name': nameController.text,
        'price': double.parse(priceController.text),
        'timestamp': FieldValue.serverTimestamp(),
      });

      nameController.clear();
      priceController.clear();
    }
  }

  /// 🔹 Delete Product
  void deleteProduct(String id) {
    inventory.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firebase Inventory Manager")),

      body: Column(
        children: [
          /// 🔹 Input Section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Product Name",
                  ),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Price",
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: addProduct,
                  child: const Text("Add Product"),
                ),
              ],
            ),
          ),

          /// 🔹 Product List (Realtime)
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: inventory
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];

                    return ListTile(
                      title: Text(doc['name']),
                      subtitle: Text("₹${doc['price']}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteProduct(doc.id),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
