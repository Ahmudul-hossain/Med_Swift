import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final bloodCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  bool isEditing = false;
  String displayName = '';
  String displayEmail = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        nameCtrl.text    = data['name']    ?? '';
        ageCtrl.text     = data['age']     ?? '';
        addressCtrl.text = data['address'] ?? '';
        bloodCtrl.text   = data['blood']   ?? '';
        phoneCtrl.text   = data['phone']   ?? '';
        emailCtrl.text   = data['email']   ?? '';
        displayName  = data['name']  ?? '';
        displayEmail = data['email'] ?? '';
      });
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    ageCtrl.dispose();
    addressCtrl.dispose();
    bloodCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF8080),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit, color: Colors.white),
            onPressed: () {
              if (isEditing) {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({
                  'name':    nameCtrl.text.trim(),
                  'age':     ageCtrl.text.trim(),
                  'address': addressCtrl.text.trim(),
                  'blood':   bloodCtrl.text.trim(),
                  'phone':   phoneCtrl.text.trim(),
                });
                setState(() {
                  displayName = nameCtrl.text.trim();
                });
              }
              setState(() => isEditing = !isEditing);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
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
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, size: 60, color: Color(0xFFFF8080)),
                  ),
                  const SizedBox(height: 15),
                  Text(displayName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 5),
                  Text(displayEmail, style: const TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _field('Name', nameCtrl, Icons.person_outline),
                  const SizedBox(height: 15),
                  _field('Age', ageCtrl, Icons.cake_outlined, type: TextInputType.number),
                  const SizedBox(height: 15),
                  _field('Address', addressCtrl, Icons.home_outlined),
                  const SizedBox(height: 15),
                  _field('Blood Type', bloodCtrl, Icons.bloodtype_outlined),
                  const SizedBox(height: 15),
                  _field('Phone Number', phoneCtrl, Icons.phone_outlined, type: TextInputType.phone),
                  const SizedBox(height: 15),
                  _field('Email', emailCtrl, Icons.email_outlined, type: TextInputType.emailAddress),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, IconData icon, {TextInputType type = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF666666))),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          enabled: isEditing,
          keyboardType: type,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey[400], size: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[200]!)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFFF8080), width: 2)),
            filled: true,
            fillColor: isEditing ? Colors.white : Colors.grey[100],
          ),
        ),
      ],
    );
  }
}