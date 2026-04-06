import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'doctor.dart';
import 'bed_cabin_cost.dart';

const Map<String, String> hospitalImages = {
  'Ibrahim General Hospital': 'assets/images/hospitals/ibrahim_hospital.jpg',
  'Ahsania Cancer Hospital': 'assets/images/hospitals/ahsania_hospital.jpg',
  'Lab Aid Hospital': 'assets/images/hospitals/labaid_hospital.jpg',
  'Square Hospital': 'assets/images/hospitals/square.jpg',
  'United Hospital': 'assets/images/hospitals/united.jpg',
  "Gulshan Children's Clinic": 'assets/images/hospitals/gulshan_clinic.jpg',
  'Uttara Modern Hospital': 'assets/images/hospitals/uttara_hospital.jpg',
  'Kuwait Bangladesh Friendship Hospital': 'assets/images/hospitals/kuwait_bangladesh_hospital.jpg',
  'Al-Manar Hospital': 'assets/images/hospitals/almanar_hospital.jpg',
  'Bangladesh Specialized Hospital': 'assets/images/hospitals/bangladesh_specialized_hospital.jpg',
};

class SearchByAreaPage extends StatefulWidget {
  const SearchByAreaPage({super.key});

  @override
  State<SearchByAreaPage> createState() => _SearchByAreaPageState();
}

class _SearchByAreaPageState extends State<SearchByAreaPage> {
  final List<String> areas = ['All', 'Mirpur', 'Dhanmondi', 'Gulshan', 'Uttara', 'Mohammadpur', 'Banani'];
  String selectedArea = 'All';
  bool showSpecializedOnly = false;
  List<Map<String, dynamic>> hospitals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHospitals();
  }

  Future<void> fetchHospitals() async {
    final snapshot = await FirebaseFirestore.instance.collection('hospitals').get();
    final data = snapshot.docs.map((doc) {
      final h = Map<String, dynamic>.from(doc.data());
      h['image'] = hospitalImages[h['name']] ?? '';
      return h;
    }).toList();

    setState(() {
      hospitals = data;
      isLoading = false;
    });
  }

  List<Map<String, dynamic>> get filtered {
    return hospitals.where((h) {
      bool areaOk = selectedArea == 'All' || h['area'] == selectedArea;
      bool specializedOk = !showSpecializedOnly || h['specialized'] == true;
      return areaOk && specializedOk;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFFF8080)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 55, 20, 15),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    const Text('Search Hospitals', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: areas.length,
                    itemBuilder: (_, i) {
                      bool active = selectedArea == areas[i];
                      return GestureDetector(
                        onTap: () => setState(() => selectedArea = areas[i]),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                          decoration: BoxDecoration(
                            color: active ? Colors.white : Colors.white24,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            areas[i],
                            style: TextStyle(
                              color: active ? const Color(0xFFFF8080) : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => setState(() => showSpecializedOnly = !showSpecializedOnly),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: showSpecializedOnly ? Colors.white : Colors.white24,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Specialized Only',
                      style: TextStyle(
                        color: showSpecializedOnly ? const Color(0xFFFF8080) : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_hospital_outlined, size: 60, color: Colors.grey[300]),
                  const SizedBox(height: 10),
                  Text('No hospitals found', style: TextStyle(color: Colors.grey[500], fontSize: 15)),
                  Text('Try changing the filters', style: TextStyle(color: Colors.grey[400], fontSize: 13)),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              itemCount: filtered.length,
              itemBuilder: (_, i) => _hospitalCard(filtered[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hospitalCard(Map<String, dynamic> h) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              h['image'],
              width: double.infinity,
              height: 130,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 130,
                color: const Color(0xFFFFD6D6),
                child: const Center(child: Icon(Icons.local_hospital, size: 50, color: Color(0xFFFF8080))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(h['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                    if (h['specialized'] == true)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF8080).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('Specialized', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFFF8080))),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('📍 ${h['address']}', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                const SizedBox(height: 2),
                Text('📞 ${h['phone']}', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorPage(hospital: h))),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8080),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Doctor & Fee'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BedCabinCostPage(hospital: h))),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFFF8080),
                          side: const BorderSide(color: Color(0xFFFF8080)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Bed / Cabin'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}