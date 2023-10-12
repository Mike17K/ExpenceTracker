import 'dart:math';

import 'package:expenses_tracker/models/Category.dart';
import 'package:expenses_tracker/models/Expense.dart';
import 'package:expenses_tracker/services/crud/local_service.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final LocalDatabaseService localDatabaseService = LocalDatabaseService();
  int addPayment = 0;

  @override
  Widget build(BuildContext context) {
    String categoryName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        actions: [
          IconButton(onPressed:(){
            localDatabaseService.deleteCategoryByName(categoryName);
            Navigator.pop(context);
          } , icon: const Icon(Icons.delete)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Today: ${DateTime.now().toString().substring(0, 10)}', style: const TextStyle(fontSize: 20),),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                ), 
                onPressed: (){
                setState(() {
                  addPayment=max(addPayment-5,0);
                });
              }, icon: const Icon(Icons.remove)),
              Text(
                '$addPayment',
                style: const TextStyle(fontSize: 20),
              ),
              IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                ), 
                onPressed: (){
                setState(() {
                  addPayment+=5;
                });
              }, icon: const Icon(Icons.add)),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              Category? category = await localDatabaseService.getCategoryByName(categoryName);
              if (category == null) return;

              Expense expense = Expense(
                id: 0,
                categoryId: category.id,
                amount: addPayment.toDouble(),
                date: DateTime.now(),
                description: 'test', // TODO: add description field
              );
              await localDatabaseService.insertExpense(expense);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
