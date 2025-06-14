// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'db_helper.dart';

// class ProviderDashboard extends StatefulWidget {
//   final Map userData;
//   ProviderDashboard({required this.userData});

//   @override
//   State<ProviderDashboard> createState() => _ProviderDashboardState();
// }

// class _ProviderDashboardState extends State<ProviderDashboard> {
//   List<String> providerServices = [];
//   String? selectedService;
//   List<Map> relevantBookings = [];

//   @override
//   void initState() {
//     super.initState();
//     extractProviderServices();
//   }

//   void extractProviderServices() {
//     final rawServices = widget.userData['services'] ?? '';
//     setState(() {
//       providerServices = rawServices
//           .toString()
//           .split(',')
//           .map((s) => s.trim())
//           .where((s) => s.isNotEmpty)
//           .toList();
//     });
//   }

//   Future<void> fetchRelevantBookings() async {
//     if (selectedService == null) return;
//     final allBookings = await DBHelper.getBookingsForProvider(widget.userData['id']);

//     final filtered = allBookings.where((booking) =>
//         booking['service'].toString().toLowerCase() ==
//         selectedService!.toLowerCase()).toList();

//     setState(() {
//       relevantBookings = filtered;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Color primaryColor = Colors.indigo;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Provider Dashboard', style: GoogleFonts.poppins()),
//         backgroundColor: primaryColor,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () => Navigator.pop(context),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Welcome, ${widget.userData['name']}!',
//                 style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 20),

//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 labelText: 'Select a service you want to provide',
//                 border: OutlineInputBorder(),
//               ),
//               items: providerServices.map((service) => DropdownMenuItem<String>(
//                     value: service,
//                     child: Text(service),
//                   )).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedService = value;
//                 });
//                 fetchRelevantBookings();
//               },
//               value: selectedService,
//             ),
//             SizedBox(height: 20),

//             Expanded(
//               child: relevantBookings.isEmpty
//                   ? Center(
//                       child: Text(
//                         selectedService == null
//                             ? 'Select a service to view requests.'
//                             : 'No requests for $selectedService yet.',
//                         style: GoogleFonts.poppins(),
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: relevantBookings.length,
//                       itemBuilder: (context, index) {
//                         final booking = relevantBookings[index];
//                         return FutureBuilder<Map?>(
//                           future: DBHelper.getUserById(booking['userId']),
//                           builder: (context, snapshot) {
//                             if (!snapshot.hasData) {
//                               return ListTile(title: Text("Loading..."));
//                             }
//                             final user = snapshot.data!;
//                             return Card(
//                               margin: EdgeInsets.symmetric(vertical: 6),
//                               child: ListTile(
//                                 title: Text("User: ${user['name']}"),
//                                 subtitle: Text("Address: ${user['address']}\nPhone: ${user['phone']}\nStatus: ${booking['status']}"),
//                                 isThreeLine: true,
//                                 trailing: PopupMenuButton<String>(
//   onSelected: (value) async {
//     await DBHelper.updateBookingStatus(booking['id'], value);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Booking ${value.toLowerCase()}')),
//     );
//     fetchRelevantBookings();
//   },
//   itemBuilder: (_) => [
//     PopupMenuItem(value: 'Accepted', child: Text("Accept")),
//     PopupMenuItem(value: 'Rejected', child: Text("Reject")),
//   ],
// ),

//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'db_helper.dart';

class ProviderDashboard extends StatefulWidget {
  final Map userData;
  ProviderDashboard({required this.userData});

  @override
  State<ProviderDashboard> createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard> {
  List<String> providerServices = [];
  String? selectedService;
  List<Map> relevantBookings = [];

  @override
  void initState() {
    super.initState();
    extractProviderServices();
  }

  void extractProviderServices() {
    final rawServices = widget.userData['services'] ?? '';
    setState(() {
      providerServices = rawServices
          .toString()
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
    });
  }

  Future<void> fetchRelevantBookings() async {
    if (selectedService == null) return;
    final allBookings = await DBHelper.getBookingsForProvider(widget.userData['id']);

    final filtered = allBookings
        .where((booking) => booking['service'].toString().toLowerCase() == selectedService!.toLowerCase())
        .toList();

    setState(() {
      relevantBookings = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.indigo;

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Dashboard', style: GoogleFonts.poppins()),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, ${widget.userData['name']}!',
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select a service you want to provide',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              items: providerServices.map((service) => DropdownMenuItem<String>(
                    value: service,
                    child: Text(service),
                  )).toList(),
              onChanged: (value) {
                setState(() {
                  selectedService = value;
                });
                fetchRelevantBookings();
              },
              value: selectedService,
            ),
            SizedBox(height: 20),
            Expanded(
              child: relevantBookings.isEmpty
                  ? Center(
                      child: Text(
                        selectedService == null
                            ? 'Select a service to view requests.'
                            : 'No requests for $selectedService yet.',
                        style: GoogleFonts.poppins(),
                      ),
                    )
                  : ListView.builder(
                      itemCount: relevantBookings.length,
                      itemBuilder: (context, index) {
                        final booking = relevantBookings[index];
                        return FutureBuilder<Map?>(
                          future: DBHelper.getUserById(booking['userId']),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return ListTile(title: Text("Loading..."));
                            }
                            final user = snapshot.data!;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(16),
                                  title: Text("User: ${user['name']}"),
                                  subtitle: Text(
                                      "Address: ${user['address']}\nPhone: ${user['phone']}\nStatus: ${booking['status']}"),
                                  isThreeLine: true,
                                  trailing: PopupMenuButton<String>(
                                    onSelected: (value) async {
                                      await DBHelper.updateBookingStatus(booking['id'], value);
                                      final isAccepted = value == 'Accepted';
                                      final color = isAccepted ? Colors.green : Colors.red;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            isAccepted
                                                ? 'Booking accepted. User will be notified.'
                                                : 'Booking rejected.',
                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                          ),
                                          backgroundColor: color,
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      fetchRelevantBookings();
                                    },
                                    itemBuilder: (_) => [
                                      PopupMenuItem(value: 'Accepted', child: Text("Accept")),
                                      PopupMenuItem(value: 'Rejected', child: Text("Reject")),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
