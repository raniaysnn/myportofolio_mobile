# MyPortofolio Mobile

Aplikasi mobile Flutter untuk portofolio pribadi Rania Yasin (PBP D), versi mobile dari website portofolio Django dengan desain di web tersebut.

## Cara menjalankan
1. Pasang Flutter SDK.
2. `git clone https://github.com/raniaysnn/myportofolio_mobile.git`
3. `cd myportofolio_mobile`
4. `flutter pub get`
5. `flutter run -d chrome`

## Progres mingguan
- **Tugas 7: Minggu ini aku hanya memodifikasi dan menambahkan tombol menu sesuai yang ada di Website portofolioku karena kurang lebih sisanya sudah dikerjakan di Tutorial 8, then aku lebih memperdalam ulang Tutorial 8 dulu sebelum lanjut mengerjakan Tugas 7 ini, tetapi masih kagok saat memahaminya but well im still doin it.**
- **Tugas 8: Minggu ini aku menambahkan form Add Experience yang fieldnya ngikutin model Experience di web portofolioku, yang bisa dibuka dari kartu Tambah Experience dan dari drawer. Sisanya pakai pola yang sama seperti form Add Project di Tutorial 9.**


### Tugas 7

1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!
- Di Flutter, semua tampilan adalah widget, dan widget disusun bertingkat seperti pohon. Satu widget membungkus widget lain.
- Parent mengatur child-nya: posisi, ukuran, dan batasannya. Contohnya Padding memberi jarak ke child, dan Column menyusun children-nya ke bawah.
- Data dan tema mengalir dari atas ke bawah. Itu sebabnya Theme.of(context) di ItemCard bisa mengambil tema yang diatur jauh di atas, di MaterialApp.
- Contoh dari proyekku: MaterialApp → MyHomePage → Scaffold → Column → Row → InfoCard → Card → Text.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!
- MaterialApp: Root app -> mengatur tema dan halaman pertama
- Scaffold: Kerangka hakaman -> tempat AppBar dan body
- AppBar: Bar di bagian atas halaman -> berisi judul aplikasi
- Text: Menampilkan teks -> gayanya diatur lewat TextStyle
- Padding: Memberi jarak kosong di sekeliling child-nya
- Column: Menyusun children secara vertikal (atas ke bawah)
- Row: Menyusun children secara horizontal (kiri ke kanan)
- Expanded: Membuat child di dalam Row/Column mengambil sisa ruang -> dipakai agar 3 InfoCard sama lebar
- SizedBox: Kotak berukuran tetap -> dipakai sebagai jarak antarwidget
- Center: Meletakkan child di tengah ruang yang tersedia
- Container: Kotak serbaguna untuk padding, ukuran, dan dekorasi
- Card: Kartu dengan latar, sudut membulat, dan garis tepi -> dasar dari InfoCard
- GridView: Menyusun children dalam bentuk kisi -> dipakai untuk tombol menu 3 kolom (GridView.count)
- Material: Memberi warna latar dan bentuk pada tombol, sekaligus permukaan untuk efek riak InkWell
- InkWell: Membuat area bisa diklik (onTap) dan menampilkan efek riak saat ditekan
- Icon: Menampilkan ikon dari Material Icons
- SnackBar: Pesan singkat di bawah layar -> ditampilkan lewat ScaffoldMessenger saat tombol ditekan
- MyHomePage (buatan sendiri): Halaman utama berisi data diri, InfoCard, dan ItemCard -> berupa StatelessWidget
- InfoCard (buatan sendiri): Kartu berisi label dan nilai (NPM, nama, kelas)
- ItemCard (buatan sendiri): Tombol menu berwarna dengan ikon dan teks -> memunculkan SnackBar saat ditekan

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!
- Karena dia jadi patokan untuk appnya nanti bakal kaya gimana, semacam base atau temanya (theme), menentukan halaman pertama (home) dan mengatur navigasi (antarhalaman), Menyediakan "fasilitas" yang dibutuhkan widget Material di bawahnya, misalnya ScaffoldMessenger untuk SnackBar, arah teks, dan bahasa.
- Kenapa jadi root: widget seperti Scaffold, AppBar, dan SnackBar butuh fasilitas itu dari atasnya. Kalau MaterialApp tidak ada di paling atas, widget-widget itu error.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?
- StatelessWidget itu kalau untuk tampilan aja dan tidak ada fitur dynamic, tidak punya data yang berubah sendiri. Tampilannya hanya bergantung pada data dari luar. Contoh: InfoCard dan ItemCard. Sedangkan,
- StatefulWidget itu ada fitur yang bisa bertambah/berkurang etc, bukan hanya halaman/tampilan saja tapi punya state, yaitu data yang bisa berubah selama aplikasi berjalan. Saat setState() dipanggil, widgetnya digambar ulang. Contoh: counter di template awal (_counter++).
- Kapan dipakai: utamakan Stateless. Pakai Stateful hanya kalau ada data yang berubah karena interaksi pengguna, misalnya counter, checkbox, atau form.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?
- BuildContext adalah posisi atau "alamat" sebuah widget di dalam widget tree. Setiap widget punya context-nya sendiri.
- Penting karena lewat context, widget bisa mencari data atau objek yang disediakan widget di atasnya (ancestor) tanpa harus dioper satu per satu lewat constructor.
- Di dalam build(BuildContext context), context diterima sebagai parameter lalu dipakai dengan pola Something.of(context). Contoh di proyek ini:
    - Theme.of(context) di MyHomePage -> mengambil warna tema yang diatur di MaterialApp.
    - ScaffoldMessenger.of(context) di ItemCard -> mencari ScaffoldMessenger terdekat untuk menampilkan SnackBar.
    - MediaQuery.of(context) (dipakai di Tutorial 8) -> mengambil ukuran layar.
- Karena context menunjuk posisi widget, hasil Something.of(context) bergantung pada di mana widget itu berada di dalam tree.

6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?
- Hot reload (r): itu digunakan saat hanya perlu reload halaman setelah mengedit tampilan dan bukan data dengan tipe yang bisa berubah. memasukkan kode baru ke aplikasi yang sedang jalan, lalu memanggil build() ulang. State tetap, jadi angka counter tidak kembali ke 0.
- Hot restart (R):itu digunakan untuk memulai dari awal/restart sehingga misal data yang dibuat jadi dari awal lagi nantinya. R menjalankan ulang aplikasi dari main(). State hilang. Tetapi tidak perlu compile ulang dari nol.
-  Kapan reload tidak cukup:
  - Mengganti StatefulWidget jadi StatelessWidget (Tutorial 8 Langkah 2) butuh hot restart.
  - Mengubah main() atau nilai awal field/state butuh hot restart.
  - Mengubah pubspec.yaml (menambah package atau asset) butuh full restart: tekan q, lalu flutter run lagi.

### Tugas 8

1. Jelaskan perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.
- Navigator.push(): numpuk halaman baru di atas halaman sekarang -> halaman lama masih ada, jadi bisa back.
- Navigator.pushReplacement(): ganti halaman sekarang dengan halaman baru -> halaman lama dibuang, jadi tidak bisa back ke situ.
- Navigator.pop(): buang halaman paling atas -> balik ke halaman sebelumnya. Dipakai juga buat nutup AlertDialog.
- Kartu Tambah Experience pakai Navigator.push(), jadi dari form bisa balik ke halaman utama pakai tombol back.
- Opsi Home di drawer pakai Navigator.pushReplacement() ke MyHomePage, jadi halaman form diganti dengan halaman utama, bukan ditumpuk.

2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.
- Scaffold jadi kerangka yang sama di tiap halaman (appBar, drawer, body), jadi tiap halaman tinggal ngisi body-nya.
- AppBar di semua halaman gayanya sama, jadi tetap kerasa satu aplikasi.
- Drawer dibuat sekali (LeftDrawer) terus dipakai di halaman utama, Add Project, dan Add Experience. Kalau mau menambahkan menu cukup ubah satu file.
- Contoh warna: merah MyWeb.red diatur jadi primary di ThemeData, terus dipakai lewat Theme.of(context).colorScheme.primary buat AppBar di halaman utama, Add Project, Add Experience, dan tombol Save.

3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.
- Formnya disusun satu kolom (Column) dari atas ke bawah, sama kayak form Add Project, biar urutannya jelas dan gampang diisi di HP.
- Padding: ngasih jarak antar-input dan dari pinggir layar biar tidak dempet.
- SingleChildScrollView: bikin form bisa di-scroll, jadi kalau layarnya kecil atau keyboard muncul, semua input dan tombol Save tetap bisa dijangkau dan tidak overflow.

4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.
- GlobalKey<FormState>: kunci buat ngakses state form dari luar, misalnya dari tombol Save.
- validator: fungsi di tiap field -> return null kalau valid, return pesan error kalau tidak valid.
- validate(): ngejalanin semua validator sekaligus pas Save ditekan. Kalau ada yang salah, error muncul di kolomnya dan dialog tidak muncul.
- Contoh yang ditolak: URL thumbnail "bukan-url". Walaupun keyboardnya sudah keyboard URL, user tetap bisa ngetik apa aja, jadi tetap harus dicek pakai validator. Judul yang isinya spasi doang juga ditolak.

## AI Disclosure: 
- Tools: Claude
- Saya gunakan memperbaiki error flutter run dan folder build yang terkunci, belajar Git dan branch, mencoba mengerjakan ulang Tutorial 8 dan memahami lebih dalam baru mencoba mengerjakan Tugas 7 sendiri lalu meminta saran dan panduan lebih lanjut untuk menerapkan desain web (token warna, tema gelap, warna teks otomatis, InfoCard) secara step-by-step. Lalu membantu mengecek error saat flutter analyze karena penamaan class yang seharusnya UpperCamelCase. Saya juga meminta penjelasan per line kenapa syntaxnya seperti ini dan fungsinya untuk apa.
- Tugas 8: Saya gunakan untuk mengecek apa yang belum dikerjakan dari soal Tugas 8, membuat draf form Add Experience yang fieldnya disesuaikan dengan model Experience di web, menambahkan kartu dan opsi drawer, dan membuat draf jawaban reflektif. Versi pertama dari AI terlalu banyak mengubah kode Tugas 7 dan Tutorial 9, jadi aku minta diulang supaya kode sebelumnya tidak diubah dan formnya mengikuti pola form Add Project.
