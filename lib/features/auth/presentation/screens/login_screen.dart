import 'package:flutter/material.dart';
import 'package:dealsapp/features/auth/presentation/screens/otp_screen.dart';
import 'package:dealsapp/core/services/api_service.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<bool> _selections = [true, false];
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Center(
                  child: Image.asset(
                    'assets/images/logopage.png',
                    height: 100,
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: ToggleButtons(
                    isSelected: _selections,
                    borderColor: Colors.grey,
                    fillColor: Colors.red,
                    borderWidth: 2,
                    selectedBorderColor: Colors.red,
                    selectedColor: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text("Phone", style: TextStyle(fontSize: 16)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text("Email", style: TextStyle(fontSize: 16)),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        _selections = [index == 0, index == 1];
                        if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegistrationScreen()),
                          );
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Glad to see you!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Please provide your phone number',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 50),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    hintText: 'Phone',
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final response = await ApiService.sendOtp(_phoneController.text, 'deviceId');
                      if (response['status'] == 'success') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpVerificationScreen(
                                    phoneNumber: _phoneController.text,
                                  )),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${response['message']}')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'SEND CODE',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
