import 'package:flutter/material.dart';
import 'package:dealsapp/features/widgets/custom_button.dart';
import 'package:dealsapp/core/services/api_service.dart';
import '../../../home/presentation/screens/home_screen.dart';
import 'dart:async';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _focusNodes;
  late Timer _timer;
  int _start = 117; // 1 minute 57 seconds

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(4, (_) => FocusNode());
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/otp.png', height: 150),
                const SizedBox(height: 20),
                const Text(
                  "OTP Verification",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "We have sent a unique OTP number to your mobile ${widget.phoneNumber}",
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                          }
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      timerText,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "SEND AGAIN",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: "Verify",
                  onPressed: () async {
                    String otp = _otpControllers.map((controller) => controller.text).join();
                    final response = await ApiService.verifyOtp(otp, 'deviceId', 'userId');
                    if (response['status'] == 'success') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${response['message']}')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
