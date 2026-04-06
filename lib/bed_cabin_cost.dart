import 'package:flutter/material.dart';

class BedCabinCostPage extends StatelessWidget {
  final Map<String, dynamic> hospital;
  const BedCabinCostPage({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    final String phone = hospital['phone'];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 55, 20, 25),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF9999), Color(0xFFFF8080)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text('Bed / Cabin Cost', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _costCard('Low Budget', 'General ward', hospital['bedLow']),
                  _costCard('Medium Budget', 'Semi-private room', hospital['bedMedium']),
                  _costCard('High Budget', 'Private cabin', hospital['bedHigh']),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.phone_rounded, color: Color(0xFFFF8080)),
                      title: const Text('Contact for more info', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(phone, style: const TextStyle(color: Color(0xFFFF8080))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _costCard(String title, String subtitle, String price) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        trailing: Text('৳$price BDT/day', style: const TextStyle(color: Color(0xFFFF8080), fontWeight: FontWeight.bold, fontSize: 13)),
      ),
    );
  }
}