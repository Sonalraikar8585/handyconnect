// import 'package:flutter/material.dart';
// import 'login_screen.dart';
// import 'register_screen.dart';
// import 'package:google_fonts/google_fonts.dart';

// void main() {
//   runApp(HandyConnectApp());
// }

// class HandyConnectApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'HandyConnect',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         textTheme: GoogleFonts.poppinsTextTheme(
//           Theme.of(context).textTheme,
//         ),
//       ),
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   final Color primaryColor = Colors.indigo;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("HandyConnect"),
//         centerTitle: true,
//         elevation: 2,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
//           child: Column(
//             children: [
//               Icon(Icons.handyman, size: 100, color: primaryColor),
//               SizedBox(height: 20),
//               Text(
//                 "Welcome to HandyConnect!",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: primaryColor,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "Book trusted electricians, plumbers, carpenters & more with just a few taps.",
//                 style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 30),
//               ElevatedButton.icon(
//                 icon: Icon(Icons.login),
//                 label: Text("Login"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: primaryColor,
//                   minimumSize: Size(double.infinity, 50),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                       context, MaterialPageRoute(builder: (_) => LoginScreen()));
//                 },
//               ),
//               SizedBox(height: 15),
//               OutlinedButton.icon(
//                 icon: Icon(Icons.person_add_alt),
//                 label: Text("Register"),
//                 style: OutlinedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 50),
//                   side: BorderSide(color: primaryColor),
//                   foregroundColor: primaryColor,
//                 ),
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => RegisterScreen()));
//                 },
//               ),
//               SizedBox(height: 30),
//               Divider(thickness: 1),
//               SizedBox(height: 20),
//               Text(
//                 "About Us",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "HandyConnect is your one-stop solution to find and book trusted service providers like plumbers, electricians, and more—quickly and efficiently.",
//                 style: TextStyle(color: Colors.grey[700]),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 20),
//               Text(
//                 "Contact Us",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "Email: support@handyconnect.com\nPhone: +91-9876543210",
//                 style: TextStyle(color: Colors.grey[700]),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 20),
//               Text(
//                 "Makers",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "👩‍💻 Sonal Raikar\n👨‍💻 Pranjal Pail\n👩‍💻 Aditi Giri",
//                 style: TextStyle(color: Colors.grey[800]),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 30),
//               Text(
//                 "© 2025 HandyConnect",
//                 style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'db_helper.dart'; // ✅ Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.getDB(); // ✅ Initialize SQLite DB
  runApp(HandyConnectApp());
}

class HandyConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HandyConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Color primaryColor = Colors.indigo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("HandyConnect"),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            children: [
              Icon(Icons.handyman, size: 100, color: primaryColor),
              SizedBox(height: 20),
              Text(
                "Welcome to HandyConnect!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Book trusted electricians, plumbers, carpenters & more with just a few taps.",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
  icon: Icon(Icons.login, color: Colors.white), // Make icon white too
  label: Text("Login", style: TextStyle(color: Colors.white)), // Text color set to white
  style: ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white, // Ensures icon and ripple effect are white
    minimumSize: Size(double.infinity, 50),
  ),
  onPressed: () {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => LoginScreen()));
  },
),

              SizedBox(height: 15),
              OutlinedButton.icon(
                icon: Icon(Icons.person_add_alt),
                label: Text("Register"),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  side: BorderSide(color: primaryColor),
                  foregroundColor: primaryColor,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => RegisterScreen()));
                },
              ),
              SizedBox(height: 30),
              Divider(thickness: 1),
              SizedBox(height: 20),
              Text(
                "About Us",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "HandyConnect is your one-stop solution to find and book trusted service providers like plumbers, electricians, and more—quickly and efficiently.",
                style: TextStyle(color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Contact Us",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Email: support@handyconnect.com\nPhone: +91-9876543210",
                style: TextStyle(color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Makers",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "👩‍💻 Sonal Raikar\n👨‍💻 Pranjal Pail\n👩‍💻 Aditi Giri",
                style: TextStyle(color: Colors.grey[800]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                "© 2025 HandyConnect",
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
