import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF9999), Color(0xFFFF8080)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.medical_services_rounded,
                      size: 40, color: Color(0xFFFF8080)),
                ),
                const SizedBox(height: 15),
                const Text('MedSwift',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  _item(context, Icons.home_rounded, 'Home',
                      onTap: () => Navigator.pop(context)),
                  _item(context, Icons.person_rounded, 'Profile', onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile');
                  }),
                  _item(context, Icons.local_hospital_rounded, 'Hospitals',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/search-by-area');
                      }),
                  _item(context, Icons.bloodtype_rounded, 'Blood Donors',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/blood');
                      }),
                  const Spacer(),
                  Divider(color: Colors.grey[300]),
                  _item(context, Icons.logout_rounded, 'Logout',
                      isLogout: true, onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/auth-options', (route) => false);
                        }
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _item(BuildContext context, IconData icon, String title,
      {required VoidCallback onTap, bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon,
          color: isLogout ? Colors.red[400] : const Color(0xFFFF8080)),
      title: Text(title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isLogout ? Colors.red[400] : const Color(0xFF333333))),
      onTap: onTap,
    );
  }
}