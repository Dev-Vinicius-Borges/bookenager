import 'package:bookio/Server/session/config.dart';
import 'package:bookio/pages/AccountPage.dart';
import 'package:bookio/pages/BooksPage.dart';
import 'package:bookio/pages/HomePage.dart';
import 'package:bookio/pages/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!
  );

  runApp(
    ChangeNotifierProvider(
        create: (context) => SessionManager()..loadSession(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => HomePage(),
        '/cadastro': (context) => RegisterPage(),
        '/home': (context) => BooksPage(),
        '/conta': (context) => AccountPage()
      },
    );
  }
}