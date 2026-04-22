import 'package:flutter/material.dart';
import 'summary_page.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key}); // ✅ FIX

  @override
  State<InventoryPage> createState() => _InventoryPageState(); // ✅ FIX
}

class _InventoryPageState extends State<InventoryPage> {
  String selectedType = "Electronics";
  double cost = 50;

  final nameController = TextEditingController();
  List<String> types = ["Electronics", "Clothing", "Food"];

  void goToSummary() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryPage(
          productName: nameController.text,
          type: selectedType,
          cost: cost,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inventory Manager")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Product Name"),
            ),
            const SizedBox(height: 15),
            DropdownButton<String>(
              value: selectedType,
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },
              items: types.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),
            const SizedBox(height: 15),
            Text("Cost: ₹${cost.toInt()}"),
            Slider(
              value: cost,
              min: 0,
              max: 1000,
              divisions: 100,
              onChanged: (value) {
                setState(() {
                  cost = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: goToSummary,
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
