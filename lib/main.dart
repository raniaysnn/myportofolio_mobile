import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/my_web.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp(apiClient: ApiClient()));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.apiClient, super.key});

  final ApiClient apiClient;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MultiProvider menyisipkan ApiClient dan AuthState ke seluruh widget tree
    // sehingga bisa diakses lewat context.read / context.watch.
    return MultiProvider(
      providers: [
        Provider.value(value: apiClient),
        ChangeNotifierProvider(create: (_) => AuthState(apiClient)),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
