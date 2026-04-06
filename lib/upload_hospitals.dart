import 'package:cloud_firestore/cloud_firestore.dart';

const List<Map<String, dynamic>> _hospitals = [
  {
    'name': 'Ibrahim General Hospital',
    'area': 'Mirpur',
    'address': '1/1, Mirpur Road, Dhaka-1216',
    'phone': '01700-823450',
    'specialized': false,
    'doctors': [
      {'name': 'Dr. Tanvir Rahman', 'spec': 'MBBS, FCPS (Medicine)', 'fee': '1800', 'phone': '01700-000001'},
      {'name': 'Dr. Nusrat Jahan', 'spec': 'MBBS, MD (Cardiology)', 'fee': '1650', 'phone': '01700-000001'},
    ],
    'bedLow': '800', 'bedMedium': '1500', 'bedHigh': '4000',
  },
  {
    'name': 'Ahsania Cancer Hospital',
    'area': 'Mirpur',
    'address': 'Plot 16/2, Mirpur-14, Dhaka-1206',
    'phone': '9008919',
    'specialized': true,
    'doctors': [
      {'name': 'Dr. Mahmudul Hasan', 'spec': 'MBBS, MD (Oncology)', 'fee': '2000', 'phone': '01700-000001'},
      {'name': 'Dr. Sharmin Akter', 'spec': 'MBBS, FCPS (Radiotherapy)', 'fee': '1850', 'phone': '01700-000001'},
    ],
    'bedLow': '1000', 'bedMedium': '2000', 'bedHigh': '5000',
  },
  {
    'name': 'Lab Aid Hospital',
    'area': 'Dhanmondi',
    'address': 'House 1, Road 4, Dhanmondi, Dhaka-1205',
    'phone': '8610793',
    'specialized': false,
    'doctors': [
      {'name': 'Dr. Arif Chowdhury', 'spec': 'MBBS, MD (Medicine)', 'fee': '1900', 'phone': '01700-000001'},
      {'name': 'Dr. Tasnim Ara', 'spec': 'MBBS, FCPS (Gynecology)', 'fee': '1800', 'phone': '01700-000001'},
    ],
    'bedLow': '1200', 'bedMedium': '2000', 'bedHigh': '5500',
  },
  {
    'name': 'Square Hospital',
    'area': 'Dhanmondi',
    'address': '18/F, Bir Uttam Sarak, Dhaka-1205',
    'phone': '8144466',
    'specialized': true,
    'doctors': [
      {'name': 'Dr. Zubair Ahmed', 'spec': 'MBBS, MS (Orthopedics)', 'fee': '2000', 'phone': '01700-000001'},
      {'name': 'Dr. Nabila Karim', 'spec': 'MBBS, MD (Dermatology)', 'fee': '1700', 'phone': '01700-000001'},
    ],
    'bedLow': '1500', 'bedMedium': '2500', 'bedHigh': '6000',
  },
  {
    'name': 'United Hospital',
    'area': 'Gulshan',
    'address': 'Plot 15, Road 71, Gulshan-2, Dhaka-1212',
    'phone': '8836000',
    'specialized': false,
    'doctors': [
      {'name': 'Dr. Nafis Alam', 'spec': 'MBBS, MD (Neurology)', 'fee': '2000', 'phone': '01700-000001'},
      {'name': 'Dr. Farzana Rahim', 'spec': 'MBBS, FCPS (Medicine)', 'fee': '1900', 'phone': '01700-000001'},
    ],
    'bedLow': '2000', 'bedMedium': '3000', 'bedHigh': '7000',
  },
  {
    'name': "Gulshan Children's Clinic",
    'area': 'Gulshan',
    'address': 'House 12, Road 53, Gulshan-1, Dhaka-1212',
    'phone': '8822738',
    'specialized': true,
    'doctors': [
      {'name': 'Dr. Rakibul Islam', 'spec': 'MBBS, MD (Pediatrics)', 'fee': '1550', 'phone': '01700-000001'},
      {'name': 'Dr. Tanjina Akter', 'spec': 'MBBS, FCPS (Child Health)', 'fee': '1650', 'phone': '01700-000001'},
    ],
    'bedLow': '1000', 'bedMedium': '1800', 'bedHigh': '4500',
  },
  {
    'name': 'Uttara Modern Hospital',
    'area': 'Uttara',
    'address': 'House 6, Road 7, Sector 4, Uttara, Dhaka-1230',
    'phone': '01718251946',
    'specialized': false,
    'doctors': [
      {'name': 'Dr. Belal Hossain', 'spec': 'MBBS, MD (Medicine)', 'fee': '1850', 'phone': '01700-000001'},
      {'name': 'Dr. Shabnam Yasmin', 'spec': 'MBBS, MS (Surgery)', 'fee': '1950', 'phone': '01700-000001'},
    ],
    'bedLow': '1000', 'bedMedium': '1800', 'bedHigh': '4500',
  },
  {
    'name': 'Kuwait Bangladesh Friendship Hospital',
    'area': 'Uttara',
    'address': 'Sector 13, Uttara, Dhaka-1230',
    'phone': 'Local helpline',
    'specialized': true,
    'doctors': [
      {'name': 'Dr. Imran Kabir', 'spec': 'MBBS, FCPS (Medicine)', 'fee': '1500', 'phone': '01700-000001'},
      {'name': 'Dr. Nuzhat Tabassum', 'spec': 'MBBS, MS (Gynecology)', 'fee': '1550', 'phone': '01700-000001'},
    ],
    'bedLow': '700', 'bedMedium': '1200', 'bedHigh': '3500',
  },
  {
    'name': 'Al-Manar Hospital',
    'area': 'Mohammadpur',
    'address': 'Asad Avenue, Mohammadpur, Dhaka-1207',
    'phone': '9121387',
    'specialized': false,
    'doctors': [
      {'name': 'Dr. Faysal Ahmed', 'spec': 'MBBS, MS (Surgery)', 'fee': '1900', 'phone': '01700-000001'},
      {'name': 'Dr. Mahjabeen Rahman', 'spec': 'MBBS, MD (Medicine)', 'fee': '1800', 'phone': '01700-000001'},
    ],
    'bedLow': '900', 'bedMedium': '1600', 'bedHigh': '4000',
  },
  {
    'name': 'Bangladesh Specialized Hospital',
    'area': 'Banani',
    'address': 'Plot 23, Road 11, Banani, Dhaka-1213',
    'phone': '01711-000000',
    'specialized': true,
    'doctors': [
      {'name': 'Dr. Shuvo Ahmed', 'spec': 'MBBS, MS (Surgery)', 'fee': '1950', 'phone': '01700-000001'},
      {'name': 'Dr. Tania Sultana', 'spec': 'MBBS, MD (Cardiology)', 'fee': '1850', 'phone': '01700-000001'},
    ],
    'bedLow': '1500', 'bedMedium': '2500', 'bedHigh': '6000',
  },
];

Future<void> uploadHospitalsIfEmpty() async {
  final db = FirebaseFirestore.instance;

  final existing = await db.collection('hospitals').limit(1).get();
  if (existing.docs.isNotEmpty) return;

  for (var hospital in _hospitals) {
    await db.collection('hospitals').add(Map<String, dynamic>.from(hospital));
  }
}