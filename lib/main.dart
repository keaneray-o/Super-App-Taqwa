import 'package:bitaqwa/pages/home_pages.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        // '/' ini adalah nama route dari home page
        //'/zakat' nama route dari halaman zakat page
        '/': (context) => HomePage(),
      },
    );
  }
}
