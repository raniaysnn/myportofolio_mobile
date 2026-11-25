import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

Widget _buildLogin(ApiClient client, AuthState auth) {
  return MultiProvider(
    providers: [
      Provider.value(value: client),
      ChangeNotifierProvider.value(value: auth),
    ],
    child: const MaterialApp(home: LoginScreen()),
  );
}

void main() {
  testWidgets('LoginScreen menampilkan pesan validasi saat field kosong', (
    tester,
  ) async {
    final client = ApiClient(
      client: MockClient((request) async => http.Response('', 500)),
    );
    await tester.pumpWidget(_buildLogin(client, AuthState(client)));

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    expect(find.text('Username cannot be empty!'), findsOneWidget);
    expect(find.text('Password cannot be empty!'), findsOneWidget);
  });

  testWidgets('LoginScreen menyimpan token ke AuthState saat login berhasil', (
    tester,
  ) async {
    final client = ApiClient(
      client: MockClient(
        (request) async => http.Response('{"token": "tok123"}', 200),
      ),
    );
    final auth = AuthState(client);
    await tester.pumpWidget(_buildLogin(client, auth));

    await tester.enterText(find.byType(TextFormField).at(0), 'owner');
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(auth.isLoggedIn, isTrue);
    expect(auth.token, 'tok123');
  });
}
