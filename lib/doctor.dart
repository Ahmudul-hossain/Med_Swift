import 'package:flutter/material.dart';

class DoctorPage extends StatelessWidget {
  final Map<String, dynamic> hospital;
  const DoctorPage({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    final List doctors = hospital['doctors'];

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
                const Text('Doctor & Fee', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: doctors.length,
              itemBuilder: (context, i) {
                final doc = doctors[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFFF8080),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(doc['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doc['spec'], style: const TextStyle(fontSize: 12)),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.call, size: 12, color: Color(0xFFFF8080)),
                            const SizedBox(width: 4),
                            Text(doc['phone'], style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    trailing: Text('৳${doc['fee']}', style: const TextStyle(color: Color(0xFFFF8080), fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}