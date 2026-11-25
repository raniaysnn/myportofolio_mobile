import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/my_web.dart';

/// Halaman detail sebuah proyek yang dipilih dari daftar.
class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Gambar hanya ditampilkan jika URL gambar proyek tidak kosong.
          if (project.projectImageUrl.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                project.projectImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 160,
                  color: MyWeb.raised,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.broken_image_outlined,
                    color: MyWeb.muted,
                    size: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            project.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: MyWeb.text,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Chip(
                label: Text(project.category),
                backgroundColor: MyWeb.raised,
                side: const BorderSide(color: MyWeb.line),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.star, color: MyWeb.amber, size: 18),
              const SizedBox(width: 4),
              Text(
                '${project.starCount}',
                style: const TextStyle(color: MyWeb.muted),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'DESCRIPTION',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w500,
              color: MyWeb.muted,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            project.description,
            style: const TextStyle(fontSize: 15, color: MyWeb.text),
          ),
        ],
      ),
    );
  }
}
