import 'package:expenses_tracker/constands/routes.dart';
import 'package:expenses_tracker/screens/gass_view.dart';
import 'package:expenses_tracker/screens/petrol_view.dart';
import 'package:expenses_tracker/screens/user_view.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:teamtrackpro/services/cloud/cloud_service.dart';
// import 'package:teamtrackpro/services/cloud/firebase/firestore_service.dart';
// import 'package:teamtrackpro/services/crud/local_service.dart';

Future<void> initializeDatabases() async {
  // await dotenv.load(fileName: '.env');

  // await FirestoreService.initializeApp();
  // CloudService cloudService = CloudService();
  // try {
  //   await cloudService.init();
  // } catch (e) {
  //   exit(0);
  // }
}

void main() async {
  
  await initializeDatabases();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'TeamTrackPro',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute: userPage,
    routes: {
      // public routes

      // // private routes
      userPage: (context) => const UserView(),

      petrolPage: (context) => const PetrolView(),
      // petrolDetailPage: (context) => const PetrolDetailView(),

      gassPage: (context) => const GassView(),
      // gassDetailPage: (context) => const GassDetailView(),
    },
  ));
}
