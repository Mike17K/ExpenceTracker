import 'package:expenses_tracker/constands/routes.dart';
import 'package:expenses_tracker/models/Category.dart';
import 'package:expenses_tracker/services/crud/local_service.dart';
import 'package:flutter/material.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final LocalDatabaseService localDatabaseService = LocalDatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expenses Tracker'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, addCategoryRoute);
                },
                icon: const Icon(Icons.add)),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: TextButton(
                    child: const Text('Clear Database'),
                    onPressed: () async {
                      await localDatabaseService.clearDatabase();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                  future: localDatabaseService.getAllCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final categories = snapshot.data as List<Category>;
                      return MyListViewWithWrap(
                        categories
                            .map((category) => MyListItem(
                                category.name,
                                const Icon(
                                  Icons.category,
                                  color: Colors.orange,
                                )))
                            .toList(),

                        //   [
                        //   MyListItem('Gass', const Icon(Icons.local_gas_station)),
                        //   MyListItem(
                        //       'Petrol', const Icon(Icons.gas_meter_outlined)),
                        // ]
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  }),
            ],
          ),
        ));
  }
}

class MyListItem extends StatelessWidget {
  final String title;
  final Icon image;

  MyListItem(this.title, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/${title.toLowerCase()}");
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    shape: BoxShape.circle,
                  ),
                  child: image,
                ),
                SizedBox(height: 8.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyListViewWithWrap extends StatelessWidget {
  final List<Widget> items;

  MyListViewWithWrap(this.items);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 150,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            Wrap(
                spacing: 8.0, // Horizontal spacing between items
                runSpacing: 8.0, // Vertical spacing between rows
                children: [...items]),
          ],
        ),
      ),
    );
  }
}
