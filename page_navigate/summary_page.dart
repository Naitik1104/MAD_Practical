import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  final String productName;
  final String type;
  final double cost;

  const SummaryPage({
    super.key, // ✅ FIX
    required this.productName,
    required this.type,
    required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Summary")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Product: $productName"),
            Text("Type: $type"),
            Text("Cost: ₹${cost.toInt()}"),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("Confirm"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
