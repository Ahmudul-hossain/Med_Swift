import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  bool hidePass = true;
  bool hideConfirm = true;
  bool agree = false;
  bool isLoading = false;

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  void signup() {
    setState(() => isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => isLoading = false);
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFFF9999), Color(0xFFFF8080)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10)]),
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back)),
                          const SizedBox(width: 10),
                          const Text('Create Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildLabel('Name'),
                      const SizedBox(height: 8),
                      _buildField(nameCtrl, 'John Doe', Icons.person_outline),
                      const SizedBox(height: 15),
                      _buildLabel('Email'),
                      const SizedBox(height: 8),
                      _buildField(emailCtrl, 'demo@email.com', Icons.email_outlined),
                      const SizedBox(height: 15),
                      _buildLabel('Password'),
                      const SizedBox(height: 8),
                      _buildPasswordField(passCtrl, hidePass, () => setState(() => hidePass = !hidePass), 'Password'),
                      const SizedBox(height: 15),
                      _buildLabel('Confirm Password'),
                      const SizedBox(height: 8),
                      _buildPasswordField(confirmCtrl, hideConfirm, () => setState(() => hideConfirm = !hideConfirm), 'Confirm'),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Checkbox(value: agree, onChanged: (v) => setState(() => agree = v ?? false), activeColor: const Color(0xFFFF8080)),
                          const Expanded(child: Text('I agree to Terms & Conditions', style: TextStyle(fontSize: 12))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : signup,
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF8080), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: isLoading ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white)) : const Text('Sign Up', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: RichText(text: const TextSpan(children: [TextSpan(text: 'Have account? ', style: TextStyle(color: Colors.grey)), TextSpan(text: 'Sign in', style: TextStyle(color: Color(0xFFFF8080), fontWeight: FontWeight.w600))])),
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

  Widget _buildLabel(String text) => Text(text, style: const TextStyle(fontWeight: FontWeight.w600));

  Widget _buildField(TextEditingController ctrl, String hint, IconData icon) {
    return TextField(
      controller: ctrl,
      enabled: !isLoading,
      decoration: InputDecoration(hintText: hint, prefixIcon: Icon(icon), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), filled: true, fillColor: Colors.grey[50]),
    );
  }

  Widget _buildPasswordField(TextEditingController ctrl, bool hide, VoidCallback toggle, String hint) {
    return TextField(
      controller: ctrl,
      enabled: !isLoading,
      obscureText: hide,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.lock_outlined),
        suffixIcon: IconButton(icon: Icon(hide ? Icons.visibility_off : Icons.visibility), onPressed: isLoading ? null : toggle),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}