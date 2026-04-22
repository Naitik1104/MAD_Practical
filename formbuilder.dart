/*dependencies:
  flutter:
    sdk: flutter
  flutter_form_builder: ^9.2.1*/

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Form Data"),
          content: Text(data.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Builder Example")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              /// 🔹 Text Field
              FormBuilderTextField(
                name: "name",
                decoration: const InputDecoration(labelText: "Name"),
                validator: (val) =>
                    val == null || val.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 15),

              /// 🔹 Email Field
              FormBuilderTextField(
                name: "email",
                decoration: const InputDecoration(labelText: "Email"),
              ),

              const SizedBox(height: 15),

              /// 🔹 Dropdown
              FormBuilderDropdown(
                name: "category",
                decoration:
                    const InputDecoration(labelText: "Product Category"),
                items: ["Electronics", "Clothing", "Food"]
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
              ),

              const SizedBox(height: 15),

              /// 🔹 Radio Buttons
              FormBuilderRadioGroup(
                name: "availability",
                decoration:
                    const InputDecoration(labelText: "Availability"),
                options: const [
                  FormBuilderFieldOption(value: "In Stock"),
                  FormBuilderFieldOption(value: "Out of Stock"),
                ],
              ),

              const SizedBox(height: 15),

              /// 🔹 Slider
              FormBuilderSlider(
                name: "price",
                min: 0,
                max: 1000,
                initialValue: 100,
                divisions: 10,
                decoration: const InputDecoration(labelText: "Price"),
              ),

              const SizedBox(height: 15),

              /// 🔹 Switch
              FormBuilderSwitch(
                name: "isFeatured",
                title: const Text("Featured Product"),
                initialValue: false,
              ),

              const SizedBox(height: 15),

              /// 🔹 Checkbox
              FormBuilderCheckbox(
                name: "terms",
                title: const Text("Accept Terms"),
                validator: (val) =>
                    val == true ? null : "You must accept terms",
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: _submit,
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
