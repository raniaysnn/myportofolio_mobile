import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/my_web.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506621945";
  final String nama = "Rania Yasin";
  final String kelas = "PBP D";

  final List<ItemHomepage> items = [
    ItemHomepage("Lihat Proyek", Icons.folder_open, MyWeb.red),
    ItemHomepage("Lihat Experience", Icons.work_history, MyWeb.blue), //
    ItemHomepage("Lihat Skills", Icons.bolt, MyWeb.amber), //
    ItemHomepage("Tambah Proyek", Icons.add_circle, MyWeb.orange),
    ItemHomepage("Tambah Experience", Icons.post_add, MyWeb.redText),
    ItemHomepage("Logout", Icons.logout, MyWeb.raised),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur visual dasar halaman (AppBar, Body, SnackBar).
    return Scaffold(
      // AppBar menampilkan bar bagian atas halaman aplikasi.
      appBar: AppBar(
        title: const Text(
          'MyPortofolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // Drawer menu untuk berpindah antarhalaman.
      drawer: const LeftDrawer(),
      // Body halaman utama dengan padding di sekelilingnya.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Tiga InfoCard berbagi lebar secara rata; jarak antarkartu 12px.
            Row(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InfoCard(title: 'NPM', content: npm),
                ),
                Expanded(
                  child: InfoCard(title: 'Name', content: nama),
                ),
                Expanded(
                  child: InfoCard(title: 'Class', content: kelas),
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            // Bagian tengah: pesan sambutan dan kisi tombol menu portofolio.
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Selamat datang di MyPortfolio Mobile!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  // GridView menampilkan kartu tombol dalam tata letak kisi 3 kolom.
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    // shrinkWrap agar ukuran kisi menyesuaikan tinggi konten anak.
                    shrinkWrap: true,
                    children: items.map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  // Kartu informasi yang menampilkan judul (title) dan isi (content).
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          EdgeInsets.zero, // jarak antarkartu diatur oleh Row, bukan oleh Card
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // rata kiri, seperti di web
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                letterSpacing:
                    1.2, // jarak antarhuruf, mirip letter-spacing di CSS
                fontWeight: FontWeight.w500,
                color: MyWeb.muted,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              content,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: MyWeb.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}
