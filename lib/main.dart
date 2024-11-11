import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const PasswordGeneratorApp());
}

class PasswordGeneratorApp extends StatelessWidget {
  const PasswordGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PasswordGeneratorScreen(),
    );
  }
}

class PasswordGeneratorScreen extends StatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  final _lengthController = TextEditingController(text: '12');
  String _generatedPassword = '';
  bool _includeUppercase = true;
  bool _includeNumbers = true;
  bool _includeSpecialChars = true;

  void _generatePassword() {
    final length = int.tryParse(_lengthController.text) ?? 12;
    const lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
    const uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    const specialChars = '!@#\$%^&*()-_=+[]{}|;:,.<>?';

    String chars = lowercaseChars;
    if (_includeUppercase) chars += uppercaseChars;
    if (_includeNumbers) chars += numbers;
    if (_includeSpecialChars) chars += specialChars;

    final random = Random();
    setState(() {
      _generatedPassword = List.generate(length,
              (index) => chars[random.nextInt(chars.length)])
          .join();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Password Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _lengthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Password Length',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Include Uppercase Letters'),
                Switch(
                  value: _includeUppercase,
                  onChanged: (value) {
                    setState(() => _includeUppercase = value);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Include Numbers'),
                Switch(
                  value: _includeNumbers,
                  onChanged: (value) {
                    setState(() => _includeNumbers = value);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Include Special Characters'),
                Switch(
                  value: _includeSpecialChars,
                  onChanged: (value) {
                    setState(() => _includeSpecialChars = value);
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _generatePassword,
              child: const Text('Generate Password'),
            ),
            SizedBox(height: 16),
            SelectableText(
              _generatedPassword,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
