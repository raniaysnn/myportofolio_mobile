import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/menu.dart';
import 'package:myportofolio_mobile/my_web.dart';
import 'package:myportofolio_mobile/project_form.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    // Pilih warna teks yang kontras dengan latar: putih untuk latar gelap,
    // gelap untuk latar terang (amber, oranye), seperti tombol di web.
    final bool isDarkBg =
        ThemeData.estimateBrightnessForColor(item.color) == Brightness.dark;
    final Color foreground = isDarkBg ? Colors.white : MyWeb.bg;
    return Material(
      color: item.color,
      // Sudut 24px dan garis tepi tipis, mengikuti kartu di web.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: MyWeb.line),
      ),
      clipBehavior: Clip
          .antiAlias, // efek riak InkWell ikut terpotong sesuai sudut membulat
      child: InkWell(
        // Aksi ketika kartu ditekan oleh pengguna.
        onTap: () {
          // Menampilkan SnackBar dengan pesan interaktif.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!"),
              ),
            );

          // Navigate ke halaman yang sesuai
          if (item.name == "Tambah Proyek") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProjectFormPage()),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: foreground, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: foreground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
