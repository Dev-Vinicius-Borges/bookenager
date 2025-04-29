import 'package:bookio/Server/session/config.dart';
import 'package:bookio/pages/AccountPage.dart';
import 'package:bookio/pages/BooksPage.dart';
import 'package:bookio/pages/HomePage.dart';
import 'package:bookio/pages/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: "https://nrwnieamlrlyjptobczx.supabase.co",
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5yd25pZWFtbHJseWpwdG9iY3p4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg5NTUxODMsImV4cCI6MjA1NDUzMTE4M30.V0EolkKsFsymhkC_Uba8HV_g5uFdVqU7dn7VKhVm_L0"
  );

  final status = await Permission.camera.request();
  if (!status.isGranted) {
    print('Erro');
  }

  runApp(
    ChangeNotifierProvider(
        create: (context) => GerenciadorDeSessao()..loadSession(),
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