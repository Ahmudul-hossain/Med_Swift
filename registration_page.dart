import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  bool hidePass = true;
  bool hideConfirm = true;
  bool isLoading = false;

  @override
  void dispose() {
    nameCtrl.dispose();
    ageCtrl.dispose();
    addressCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  void register() {
    setState(() => isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => isLoading = false);
        Navigator.of(context).pushNamed('/registration-confirm', arguments: {'name': nameCtrl.text, 'email': emailCtrl.text});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFFF9999), Color(0xFFFF8080)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10)]),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back)), const SizedBox(width: 10), const Text('Register', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF333333)))]),
                      Container(margin: const EdgeInsets.only(top: 8, bottom: 25), height: 4, width: 40, decoration: BoxDecoration(color: const Color(0xFFFF8080), borderRadius: BorderRadius.circular(2))),
                      _buildField('Name', 'Enter your name', nameCtrl, Icons.person_outline),
                      const SizedBox(height: 12),
                      _buildField('Age', 'Enter your age', ageCtrl, Icons.cake_outlined, keyboardType: TextInputType.number),
                      const SizedBox(height: 12),
                      _buildField('Address', 'Enter your address', addressCtrl, Icons.home_outlined),
                      const SizedBox(height: 12),
                      const SizedBox(height: 12),
                      _buildField('Phone Number', 'Enter your phone', phoneCtrl, Icons.phone_outlined, keyboardType: TextInputType.phone),
                      const SizedBox(height: 12),
                      _buildField('Email', 'Enter your email', emailCtrl, Icons.email_outlined, keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 12),
                      _buildPasswordField('Password', passCtrl, hidePass, () => setState(() => hidePass = !hidePass)),
                      const SizedBox(height: 12),
                      _buildPasswordField('Confirm Password', confirmCtrl, hideConfirm, () => setState(() => hideConfirm = !hideConfirm)),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : register,
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF8080), disabledBackgroundColor: Colors.grey[400], elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white), strokeWidth: 2)) : const Text('Register', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.5)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: GestureDetector(
                          onTap: isLoading ? null : () => Navigator.pop(context),
                          child: RichText(text: const TextSpan(children: [TextSpan(text: 'Already registered? ', style: TextStyle(color: Colors.grey)), TextSpan(text: 'Sign in', style: TextStyle(color: Color(0xFFFF8080), fontWeight: FontWeight.w600))])),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, String hint, TextEditingController ctrl, IconData icon, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF666666))),
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
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFFF8080), width: 2)),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(String label, TextEditingController ctrl, bool hide, VoidCallback toggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF666666))),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          enabled: !isLoading,
          obscureText: hide,
          decoration: InputDecoration(
            hintText: 'Enter password',
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            prefixIcon: Icon(Icons.lock_outlined, color: Colors.grey[400], size: 20),
            suffixIcon: GestureDetector(onTap: isLoading ? null : toggle, child: Icon(hide ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey[400], size: 20)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFFF8080), width: 2)),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ],
    );
  }
}