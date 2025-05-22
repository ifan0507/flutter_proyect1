import 'package:flutter/material.dart';
import 'package:flutter_proyect1/login_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: const Text('Profil'),
              onTap: () {
                Navigator.pop(context); // tutup drawer
                // TODO: Navigasi ke halaman Profil
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.orange),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigasi ke halaman Pengaturan
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics, color: Colors.green),
              title: const Text('Laporan'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigasi ke halaman Laporan
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                _showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _buildDashboardCard(
              icon: Icons.person,
              label: 'Profil',
              color: Colors.blue,
              onTap: () {
                // TODO: Navigasi ke halaman Profil
              },
            ),
            _buildDashboardCard(
              icon: Icons.settings,
              label: 'Pengaturan',
              color: Colors.orange,
              onTap: () {
                // TODO: Navigasi ke halaman Pengaturan
              },
            ),
            _buildDashboardCard(
              icon: Icons.analytics,
              label: 'Laporan',
              color: Colors.green,
              onTap: () {
                // TODO: Navigasi ke halaman Laporan
              },
            ),
            _buildDashboardCard(
              icon: Icons.info,
              label: 'Info',
              color: Colors.purple,
              onTap: () {
                // Kamu bisa tambah fungsi lain di sini
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 6,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi Logout"),
        content: const Text("Apakah Anda yakin ingin logout?"),
        actions: [
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
