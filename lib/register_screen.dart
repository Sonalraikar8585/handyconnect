import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'db_helper.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameCtrl = TextEditingController();
  final addrCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final timingCtrl = TextEditingController();
  String role = 'user';

  // Services checklist
  Map<String, bool> serviceOptions = {
    'Plumber': false,
    'Electrician': false,
    'Painter': false,
    'Carpenter': false,
    'Maid': false,
  };

  final _formKey = GlobalKey<FormState>();

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    String selectedServices = serviceOptions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .join(', ');

    Map<String, dynamic> userData = {
      'name': nameCtrl.text,
      'address': addrCtrl.text,
      'phone': phoneCtrl.text,
      'password': passCtrl.text,
      'role': role,
    };

    if (role == 'provider') {
      userData['timing'] = timingCtrl.text;
      userData['services'] = selectedServices;
    }

    await DBHelper.registerUser(userData);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Successfully registered as $role!'),
      backgroundColor: Colors.green,
    ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.indigo;

    return Scaffold(
      appBar: AppBar(
        title: Text("Register", style: GoogleFonts.poppins()),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(children: [
            Text(
              "Create your HandyConnect account",
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (val) => val!.isEmpty ? 'Enter name' : null,
            ),
            TextFormField(
              controller: addrCtrl,
              decoration: InputDecoration(labelText: 'Address'),
              validator: (val) => val!.isEmpty ? 'Enter address' : null,
            ),
            TextFormField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone'),
              validator: (val) => val!.isEmpty ? 'Enter phone number' : null,
            ),
            TextFormField(
              controller: passCtrl,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (val) => val!.length < 4 ? 'Password too short' : null,
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: role,
              decoration: InputDecoration(labelText: 'Register as'),
              items: ['user', 'provider']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                setState(() => role = val!);
              },
            ),

            // Provider-specific fields
            if (role == 'provider') ...[
              SizedBox(height: 10),
              TextFormField(
                controller: timingCtrl,
                decoration: InputDecoration(labelText: 'Available Timing'),
                validator: (val) => val!.isEmpty ? 'Enter timing' : null,
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Services You Provide:",
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Column(
                children: serviceOptions.keys.map((service) {
                  return CheckboxListTile(
                    title: Text(service),
                    value: serviceOptions[service],
                    onChanged: (val) {
                      setState(() {
                        serviceOptions[service] = val!;
                      });
                    },
                  );
                }).toList(),
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.check),
              label: Text("Register"),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: _register,
            ),
          ]),
        ),
      ),
    );
  }
}
