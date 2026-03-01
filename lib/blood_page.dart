import 'package:flutter/material.dart';

class BloodPage extends StatefulWidget {
  const BloodPage({super.key});

  @override
  State<BloodPage> createState() => _BloodPageState();
}

class _BloodPageState extends State<BloodPage> {
  int selectedTab = 0;
  String selectedArea = 'All';
  String selectedBlood = 'All';

  final List<String> areas = ['All', 'Mirpur', 'Dhanmondi', 'Gulshan', 'Uttara', 'Mohammadpur', 'Banani'];
  final List<String> bloodTypes = ['All', 'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  final List<Map<String, String>> donors = [
    {'name': 'Rahim Uddin',   'blood': 'A+',  'area': 'Mirpur',      'address': '12, Mirpur Road, Dhaka',      'last': 'Last donated: 3 months ago', 'phone': '01711-234567'},
    {'name': 'Sumaiya Akter', 'blood': 'O+',  'area': 'Dhanmondi',   'address': '45, Dhanmondi, Dhaka',        'last': 'Last donated: 6 months ago', 'phone': '01812-345678'},
    {'name': 'Karim Hossain', 'blood': 'B+',  'area': 'Gulshan',     'address': '78, Gulshan-1, Dhaka',        'last': 'Last donated: 4 months ago', 'phone': '01912-456789'},
    {'name': 'Nusrat Jahan',  'blood': 'AB+', 'area': 'Uttara',      'address': '23, Uttara, Sector-7, Dhaka', 'last': 'Last donated: 5 months ago', 'phone': '01611-567890'},
    {'name': 'Tariq Ahmed',   'blood': 'O-',  'area': 'Banani',      'address': '55, Banani, Road-11, Dhaka',  'last': 'Last donated: 2 months ago', 'phone': '01511-678901'},
    {'name': 'Mitu Begum',    'blood': 'A-',  'area': 'Mohammadpur', 'address': '90, Mohammadpur, Dhaka',      'last': 'Last donated: 7 months ago', 'phone': '01711-789012'},
    {'name': 'Sabbir Rahman', 'blood': 'O+',  'area': 'Mirpur',      'address': '34, Mirpur-10, Dhaka',        'last': 'Last donated: 1 month ago',  'phone': '01611-111222'},
    {'name': 'Fatema Khatun', 'blood': 'B-',  'area': 'Dhanmondi',   'address': '67, Dhanmondi-27, Dhaka',     'last': 'Last donated: 8 months ago', 'phone': '01911-333444'},
  ];

  final List<Map<String, String>> banks = [
    {'name': 'Dhaka Blood Bank',     'area': 'Mirpur',      'address': '15, Mirpur-1, Dhaka',        'available': 'A+, B+, O+, AB+',  'phone': '01711-111000'},
    {'name': 'Life Blood Center',    'area': 'Dhanmondi',   'address': '32, Dhanmondi-15, Dhaka',    'available': 'A+, A-, O+, O-',   'phone': '01811-222000'},
    {'name': 'Gulshan Blood Bank',   'area': 'Gulshan',     'address': '8, Gulshan-2, Dhaka',        'available': 'B+, B-, AB+, AB-', 'phone': '01911-333000'},
    {'name': 'Uttara Blood Center',  'area': 'Uttara',      'address': '45, Uttara Sector-4, Dhaka', 'available': 'O+, O-, A+, B+',  'phone': '01611-444000'},
    {'name': 'Red Cross Blood Bank', 'area': 'Mohammadpur', 'address': '22, Mohammadpur, Dhaka',     'available': 'All Blood Types',  'phone': '01511-555000'},
  ];

  List<Map<String, String>> get filteredDonors {
    return donors.where((d) {
      bool areaOk  = selectedArea  == 'All' || d['area']  == selectedArea;
      bool bloodOk = selectedBlood == 'All' || d['blood'] == selectedBlood;
      return areaOk && bloodOk;
    }).toList();
  }

  List<Map<String, String>> get filteredBanks {
    return banks.where((b) {
      bool areaOk  = selectedArea  == 'All' || b['area'] == selectedArea;
      bool bloodOk = selectedBlood == 'All' || b['available']!.contains(selectedBlood);
      return areaOk && bloodOk;
    }).toList();
  }

  void showEmergencyDialog() {
    // Text changes based on which tab the user is on
    String requestText = selectedTab == 0
        ? 'Request will be sent to ${filteredDonors.length} donor.'
        : 'Request will be sent to ${filteredBanks.length} blood bank.';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.red[50],
              child: Icon(Icons.notification_important_rounded, color: Colors.red[400], size: 40),
            ),
            const SizedBox(height: 16),
            const Text(
              'Send Emergency Request',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(children: [
                    Icon(Icons.location_on_outlined, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 6),
                    Text('Area: ${selectedArea == 'All' ? 'All Areas' : selectedArea}',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                  ]),
                  const SizedBox(height: 6),
                  Row(children: [
                    Icon(Icons.water_drop_outlined, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 6),
                    Text('Blood: ${selectedBlood == 'All' ? 'All Types' : selectedBlood}',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              requestText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey[600], height: 1.5),
            ),
          ],
        ),
        actions: [
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  showRequestSentDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Send', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  void showRequestSentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.green[50],
              child: Icon(Icons.check_circle_rounded, color: Colors.green[400], size: 40),
            ),
            const SizedBox(height: 16),
            const Text('Request Sent!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8080),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Close', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF8080),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Blood',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: const Icon(Icons.notification_important_rounded, color: Colors.white),
              onPressed: showEmergencyDialog,
            ),
          ),
        ],
      ),
      body: Column(
        children: [

          // Stats Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF9999), Color(0xFFFF8080)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statItem('Total Donors', '${donors.length}'),
                Container(width: 1, height: 40, color: Colors.white38),
                _statItem('Blood Banks', '${banks.length}'),
                Container(width: 1, height: 40, color: Colors.white38),
                _statItem('Blood Types', '8'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  _tabButton('Donors', 0),
                  _tabButton('Blood Banks', 1),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Your Area', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: areas.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) => _filterChip(
                      areas[i],
                      selectedArea == areas[i],
                          () => setState(() => selectedArea = areas[i]),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text('Select Blood Type', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: bloodTypes.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) => _filterChip(
                      bloodTypes[i],
                      selectedBlood == bloodTypes[i],
                          () => setState(() => selectedBlood = bloodTypes[i]),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // List
          Expanded(
            child: selectedTab == 0 ? _donorList() : _bankList(),
          ),
        ],
      ),
    );
  }

  Widget _donorList() {
    if (filteredDonors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.water_drop_outlined, size: 60, color: Colors.grey[300]),
            const SizedBox(height: 10),
            Text('No donors found', style: TextStyle(color: Colors.grey[500], fontSize: 15)),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      itemCount: filteredDonors.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) {
        final d = filteredDonors[i];
        return _card(
          avatar: Text(d['blood']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white)),
          title: d['name']!,
          subtitle: d['address']!,
          bottom: d['last']!,
          bottomIcon: Icons.access_time,
        );
      },
    );
  }

  Widget _bankList() {
    if (filteredBanks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_hospital_outlined, size: 60, color: Colors.grey[300]),
            const SizedBox(height: 10),
            Text('No blood banks found', style: TextStyle(color: Colors.grey[500], fontSize: 15)),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      itemCount: filteredBanks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) {
        final b = filteredBanks[i];
        return _card(
          avatar: const Icon(Icons.local_hospital_rounded, color: Colors.white, size: 28),
          title: b['name']!,
          subtitle: b['address']!,
          bottom: b['available']!,
          bottomIcon: Icons.water_drop_outlined,
        );
      },
    );
  }

  Widget _card({
    required Widget avatar,
    required String title,
    required String subtitle,
    required String bottom,
    required IconData bottomIcon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFFF9999), Color(0xFFFF8080)]),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(child: avatar),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(children: [
                  Icon(Icons.location_on_outlined, size: 13, color: Colors.grey[500]),
                  const SizedBox(width: 3),
                  Expanded(child: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600]), overflow: TextOverflow.ellipsis)),
                ]),
                const SizedBox(height: 3),
                Row(children: [
                  Icon(bottomIcon, size: 13, color: Colors.grey[400]),
                  const SizedBox(width: 3),
                  Expanded(child: Text(bottom, style: TextStyle(fontSize: 11, color: Colors.grey[400]), overflow: TextOverflow.ellipsis)),
                ]),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.phone_rounded, color: Color(0xFFFF8080)),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }

  Widget _tabButton(String label, int index) {
    bool active = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            gradient: active ? const LinearGradient(colors: [Color(0xFFFF9999), Color(0xFFFF8080)]) : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w700, color: active ? Colors.white : Colors.grey[600]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: isSelected ? const LinearGradient(colors: [Color(0xFFFF9999), Color(0xFFFF8080)]) : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? const Color(0xFFFF8080) : Colors.grey[300]!),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : Colors.grey[600]),
          ),
        ),
      ),
    );
  }
}