import 'package:expenses_tracker/services/crud/local_service.dart';
import 'package:flutter/material.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({super.key});

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  LocalDatabaseService localDatabaseService = LocalDatabaseService();

  // Step 1: Declare a TextEditing Controller
  final TextEditingController _categoryNameController = TextEditingController();

  @override
  void dispose() {
    // Step 3: Dispose of the controller when the widget is disposed
    _categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Category Name'),
            const SizedBox(height: 20),

            // Step 2: Assign the controller to the TextField
            TextField(
              controller: _categoryNameController,
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // You can access the entered text using _categoryNameController.text
                await localDatabaseService
                    .insertCategoryByName(_categoryNameController.text);
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
