// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'db_helper.dart';

// class UserDashboard extends StatefulWidget {
//   final Map user;
//   UserDashboard({required this.user});

//   @override
//   _UserDashboardState createState() => _UserDashboardState();
// }

// class _UserDashboardState extends State<UserDashboard> {
//   final List<String> services = ['Plumber', 'Electrician', 'Maid', 'Painter', 'Carpenter'];
//   String? selectedService;
//   List<Map> providers = [];
//   List<Map> userBookings = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchUserBookings();
//   }

//   void _pickService(String service) async {
//     final allProvs = await DBHelper.getProviders();
//     final matched = allProvs.where((p) {
//       final servicesStr = p['services'] as String? ?? '';
//       return servicesStr.split(',').map((s) => s.trim()).contains(service);
//     }).toList();

//     setState(() {
//       selectedService = service;
//       providers = matched;
//     });
//   }

//   void _book(int providerId, String providerName) async {
//     await DBHelper.createBooking({
//       'userId': widget.user['id'],
//       'providerId': providerId,
//       'service': selectedService!,
//       'status': 'Pending',
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Requested $selectedService from $providerName')),
//     );

//     fetchUserBookings(); // Refresh bookings
//   }

//   Future<void> fetchUserBookings() async {
//     final bookings = await DBHelper.getBookingsForUser(widget.user['id']);
//     setState(() {
//       userBookings = bookings;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Color primary = Colors.indigo;
//     final FontWeight bold = FontWeight.bold;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Hello ${widget.user['name']}", style: GoogleFonts.poppins()),
//         backgroundColor: primary,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(children: [
//           Text("What service would you like to have?",
//               style: GoogleFonts.poppins(fontSize: 18, fontWeight: bold)),
//           SizedBox(height: 10),
//           DropdownButton<String>(
//             hint: Text("Select service"),
//             value: selectedService,
//             isExpanded: true,
//             items: services.map((s) => DropdownMenuItem(child: Text(s), value: s)).toList(),
//             onChanged: (val) => _pickService(val!),
//           ),
//           SizedBox(height: 16),
//           Expanded(
//             child: selectedService == null
//                 ? Center(child: Text("Select a service to see providers"))
//                 : providers.isEmpty
//                     ? Center(child: Text("No providers found for $selectedService"))
//                     : ListView.builder(
//                         itemCount: providers.length,
//                         itemBuilder: (_, i) {
//                           final p = providers[i];
//                           return Card(
//                             margin: EdgeInsets.symmetric(vertical: 8),
//                             child: ListTile(
//                               title: Text(p['name'], style: GoogleFonts.poppins(fontWeight: bold)),
//                               subtitle: Text("Phone: ${p['phone']}\nTiming: ${p['timing']}"),
//                               isThreeLine: true,
//                               trailing: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(backgroundColor: primary),
//                                 child: Text("Book"),
//                                 onPressed: () => _book(p['id'], p['name']),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//           ),
//           SizedBox(height: 20),
//           Divider(),
//           Text("Your Bookings", style: GoogleFonts.poppins(fontWeight: bold, fontSize: 18)),
//           Expanded(
//             child: userBookings.isEmpty
//                 ? Center(child: Text("No bookings yet."))
//                 : ListView.builder(
//                     itemCount: userBookings.length,
//                     itemBuilder: (_, i) {
//                       final booking = userBookings[i];
//                       return FutureBuilder<Map?>(
//                         future: DBHelper.getUserById(booking['providerId']),
//                         builder: (_, snapshot) {
//                           if (!snapshot.hasData) return SizedBox();
//                           final provider = snapshot.data!;
//                           return Card(
//                             child: ListTile(
//                               title: Text("Service: ${booking['service']}", style: GoogleFonts.poppins()),
//                               subtitle: Text(
//                                   "Provider: ${provider['name']}\nPhone: ${provider['phone']}\nStatus: ${booking['status']}"),
//                               isThreeLine: true,
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'db_helper.dart';

class UserDashboard extends StatefulWidget {
  final Map user;
  UserDashboard({required this.user});

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final List<String> services = ['Plumber', 'Electrician', 'Maid', 'Painter', 'Carpenter'];
  String? selectedService;
  List<Map> providers = [];
  List<Map> userBookings = [];

  @override
  void initState() {
    super.initState();
    fetchUserBookings();
  }

  void _pickService(String service) async {
    final allProvs = await DBHelper.getProviders();
    final matched = allProvs.where((p) {
      final servicesStr = p['services'] as String? ?? '';
      return servicesStr.split(',').map((s) => s.trim()).contains(service);
    }).toList();

    setState(() {
      selectedService = service;
      providers = matched;
    });
  }

  void _book(int providerId, String providerName) async {
    await DBHelper.createBooking({
      'userId': widget.user['id'],
      'providerId': providerId,
      'service': selectedService!,
      'status': 'Pending',
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Requested $selectedService from $providerName')),
    );

    fetchUserBookings();
  }

  Future<void> fetchUserBookings() async {
    final bookings = await DBHelper.getBookingsForUser(widget.user['id']);
    setState(() {
      userBookings = bookings;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Colors.indigo;
    final FontWeight bold = FontWeight.bold;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello ${widget.user['name']}", style: GoogleFonts.poppins()),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          Text("What service would you like to have?",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: bold)),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Choose a service',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
            value: selectedService,
            items: services.map((s) => DropdownMenuItem(child: Text(s), value: s)).toList(),
            onChanged: (val) => _pickService(val!),
          ),
          SizedBox(height: 16),
          Expanded(
            child: selectedService == null
                ? Center(child: Text("Select a service to see providers"))
                : providers.isEmpty
                    ? Center(child: Text("No providers found for $selectedService"))
                    : ListView.builder(
                        itemCount: providers.length,
                        itemBuilder: (_, i) {
                          final p = providers[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(16),
                                title: Text(p['name'], style: GoogleFonts.poppins(fontWeight: bold)),
                                subtitle: Text("Phone: ${p['phone']}\nTiming: ${p['timing']}"),
                                isThreeLine: true,
                                trailing: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primary,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Text("Book", style: TextStyle(color: Colors.white)),
                                  onPressed: () => _book(p['id'], p['name']),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
          SizedBox(height: 20),
          Divider(),
          Text("Your Bookings", style: GoogleFonts.poppins(fontWeight: bold, fontSize: 18)),
          Expanded(
            child: userBookings.isEmpty
                ? Center(child: Text("No bookings yet."))
                : ListView.builder(
                    itemCount: userBookings.length,
                    itemBuilder: (_, i) {
                      final booking = userBookings[i];
                      return FutureBuilder<Map?>(
                        future: DBHelper.getUserById(booking['providerId']),
                        builder: (_, snapshot) {
                          if (!snapshot.hasData) return SizedBox();
                          final provider = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 3,
                              child: ListTile(
                                contentPadding: EdgeInsets.all(16),
                                title: Text("Service: ${booking['service']}", style: GoogleFonts.poppins()),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Provider: ${provider['name']}"),
                                    Text("Phone: ${provider['phone']}"),
                                    Text("Status: ${booking['status']}",
                                        style: TextStyle(
                                          color: booking['status'] == 'Accepted'
                                              ? Colors.green
                                              : booking['status'] == 'Rejected'
                                                  ? Colors.red
                                                  : Colors.black87,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    if (booking['status'] == 'Accepted')
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          "Your booking is confirmed. The provider will reach in 15 to 20 mins.",
                                          style: TextStyle(
                                              color: Colors.green.shade700, fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                  ],
                                ),
                                isThreeLine: true,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ]),
      ),
    );
  }
}
