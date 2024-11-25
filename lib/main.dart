import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latihanresponsi/dataModel.dart';
import 'package:latihanresponsi/loginPage.dart';
import 'package:latihanresponsi/readAndWrite.dart';

Future<void> initiateLocalDB() async {
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(DataModelAdapter());
    await Hive.openBox<DataModel>("data");
    print("Hive database initialized successfully.");
  } catch (e) {
    print("Error initializing Hive database: $e");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Memastikan inisialisasi Flutter
  await initiateLocalDB(); // Inisialisasi Hive sebelum runApp
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive Login App',
      home: const LoginPageFul(),
    );
  }
}
