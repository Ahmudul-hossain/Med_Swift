import 'package:flutter/material.dart';
import 'menu_drawer.dart';
import 'blood_page.dart';
import 'donor_registration_page.dart';
import 'search_by_area_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  bool isDonor = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == true) setState(() => isDonor = true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 55, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF9999), Color(0xFFFF8080)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (ctx) => GestureDetector(
                        onTap: () => Scaffold.of(ctx).openDrawer(),
                        child: const Icon(Icons.menu_rounded, color: Colors.white, size: 28),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/profile'),
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white24,
                        child: Icon(Icons.person_rounded, color: Colors.white, size: 22),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text('Welcome to', style: TextStyle(fontSize: 16, color: Colors.white70)),
                const Text('MedSwift', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text('Do you want to become a donor?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),

                  Center(
                    child: isDonor
                        ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF8080),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text('You are a Donor!',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                        ],
                      ),
                    )
                        : GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const DonorRegistrationPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Yes, I am!',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),
                  const Text('What do you need?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),

                  _serviceCard(
                    icon: Icons.local_hospital_rounded,
                    label: 'Search Hospitals',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchByAreaPage())),
                  ),
                  const SizedBox(height: 16),
                  _serviceCard(
                    icon: Icons.water_drop_rounded,
                    label: 'Find Blood',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BloodPage())),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceCard({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF0F0),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD6D6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFFFF8080), size: 26),
            ),
            const SizedBox(width: 14),
            Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}