import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/menu.dart';
import 'package:myportofolio_mobile/my_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rania Yasin - Portofolio',
      debugShowCheckedModeBanner:
          false, // hilangkan pita "DEBUG" di pojok kanan atas
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: MyWeb.bg, // latar semua halaman
        colorScheme: ColorScheme.fromSeed(
          seedColor: MyWeb.red,
          brightness: Brightness.dark,
          primary: MyWeb.red,
          surface: MyWeb.surface,
          onSurface: MyWeb.text, // warna teks di atas surface
        ),
        cardTheme: CardThemeData(
          // aturan gaya untuk semua Card di aplikasi.
          color: MyWeb.surface,
          elevation: 0, // web tidak pakai bayangan tebal
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24), // --radius: 24px
            side: const BorderSide(color: MyWeb.line),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}
