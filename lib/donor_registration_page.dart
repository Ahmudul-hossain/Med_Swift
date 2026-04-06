import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DonorRegistrationPage extends StatefulWidget {
  const DonorRegistrationPage({super.key});

  @override
  State<DonorRegistrationPage> createState() => _DonorRegistrationPageState();
}
class _DonorRegistrationPageState extends State<DonorRegistrationPage> {
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  bool isLoading = false;  String? selectedBloodType;
  String? selectedArea;
  final List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final List<String> areas = ['Mirpur', 'Dhanmondi', 'Gulshan', 'Uttara', 'Banani', 'Mohammadpur',];
  @override
  void dispose() {
    nameCtrl.dispose();
    ageCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }
  void register() async {
    setState(() => isLoading = true);
    await FirebaseFirestore.instance.collection('donors').add({
      'name': nameCtrl.text, 'age': ageCtrl.text, 'phone': phoneCtrl.text, 'address': addressCtrl.text, 'blood': selectedBloodType, 'area': selectedArea,
    });
    if (mounted) {
      setState(() => isLoading = false);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8080).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.favorite_rounded, color: Color(0xFFFF8080), size: 50),
              ),
              const SizedBox(height: 20),
              const Text(
                'Thank You for Being a Donor!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
              ),
            ],
          ),
        ),
      );
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home',
                (route) => false,
            arguments: true,
          );
        }
      });
    }
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
        title: const Text('Donor Registration',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              child: const Column(
                children: [
                  Text(
                    'Become a Donor',
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildField('Full Name', 'Enter your name', nameCtrl, Icons.person_outline),
                  const SizedBox(height: 15),
                  _buildField('Age', 'Enter your age', ageCtrl, Icons.cake_outlined,
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 15),
                  _buildField('Phone Number', 'Enter your phone number', phoneCtrl,
                      Icons.phone_outlined,
                      keyboardType: TextInputType.phone),
                  const SizedBox(height: 15),
                  _buildField(
                      'Address', 'Enter your address', addressCtrl, Icons.home_outlined),
                  const SizedBox(height: 15),
                  const Text('Blood Type',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF666666))),
                  const SizedBox(height: 8),
                  _buildDropdown(
                    value: selectedBloodType,
                    hint: 'Select blood type',
                    icon: Icons.water_drop_rounded,
                    items: bloodTypes,
                    onChanged: isLoading
                        ? null
                        : (val) => setState(() => selectedBloodType = val),
                  ),
                  const SizedBox(height: 15),
                  const Text('Area',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF666666))),
                  const SizedBox(height: 8),
                  _buildDropdown(
                    value: selectedArea,
                    hint: 'Select area',
                    icon: Icons.location_on_outlined,
                    items: areas,
                    onChanged:
                    isLoading ? null : (val) => setState(() => selectedArea = val),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF8080),
                        disabledBackgroundColor: Colors.grey[400],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: isLoading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        ),
                      )
                          : const Text('Register as Donor',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5)),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildField(
      String label,
      String hint,
      TextEditingController ctrl,
      IconData icon, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF666666))),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          enabled: !isLoading,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            prefixIcon: Icon(icon, color: Colors.grey[400], size: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFFF8080), width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ],
    );
  }
  Widget _buildDropdown({
    required String? value,
    required String hint,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?>? onChanged,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Row(
            children: [
              const SizedBox(width: 12),
              Icon(icon, color: Colors.grey[400], size: 20),
              const SizedBox(width: 12),
              Text(hint, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
            ],
          ),
          icon: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.grey[400], size: 22),
          ),
          borderRadius: BorderRadius.circular(12),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(item,
                    style: const TextStyle(fontSize: 14, color: Color(0xFF333333))),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          selectedItemBuilder: (context) => items.map((item) {
            return Row(
              children: [
                const SizedBox(width: 12),
                Text(item,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w500)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}