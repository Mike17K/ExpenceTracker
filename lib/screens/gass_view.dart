import 'dart:math';

import 'package:flutter/material.dart';

class GassView extends StatefulWidget {
  const GassView({super.key});

  @override
  State<GassView> createState() => _GassViewState();
}

class _GassViewState extends State<GassView> {
  int addPayment = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gass'),
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
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
