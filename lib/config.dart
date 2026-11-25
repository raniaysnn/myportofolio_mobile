/// Base URL dari backend Django REST Framework.
///
/// Default `http://10.0.2.2:8000` (alamat mesin lokal yang bisa diakses dari
/// emulator Android). Override dengan
/// `--dart-define=API_BASE_URL=http://localhost:8000` saat menjalankan di
/// Chrome/Web, atau dengan URL backend yang sudah di-deploy.
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:8000',
);
