import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  // Open DB
  static Future<Database> getDB() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'handyconnect.db');
    print("📦 Database path: $dbPath");

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            address TEXT NOT NULL,
            phone TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL,
            role TEXT NOT NULL,
            timing TEXT,
            services TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE bookings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER NOT NULL,
            providerId INTEGER NOT NULL,
            service TEXT NOT NULL,
            status TEXT NOT NULL DEFAULT 'Pending',
            FOREIGN KEY(userId) REFERENCES users(id),
            FOREIGN KEY(providerId) REFERENCES users(id)
          )
        ''');
      },
    );
  }

  // Register user or provider
  static Future<void> registerUser(Map<String, dynamic> data) async {
    final db = await getDB();
    try {
      int id = await db.insert('users', data);
      print("✅ Registered user ID: $id");
    } catch (e) {
      print("❌ Registration error: $e");
    }
  }

  // Login using phone & password
  static Future<Map?> login(String phone, String password) async {
    final db = await getDB();
    final res = await db.query(
      'users',
      where: 'phone = ? AND password = ?',
      whereArgs: [phone.trim(), password.trim()],
    );
    return res.isNotEmpty ? res.first : null;
  }

  // Get all providers
  static Future<List<Map>> getProviders() async {
    final db = await getDB();
    return await db.query('users', where: 'role = ?', whereArgs: ['provider']);
  }

  // Get all users
  static Future<List<Map>> getUsers() async {
    final db = await getDB();
    return await db.query('users', where: 'role = ?', whereArgs: ['user']);
  }

  // Get user details by ID
  static Future<Map?> getUserById(int id) async {
    final db = await getDB();
    final res = await db.query('users', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? res.first : null;
  }

  // Create a new booking
  static Future<void> createBooking(Map<String, dynamic> booking) async {
    final db = await getDB();
    await db.insert('bookings', booking);
  }

  // Get bookings for a provider
  static Future<List<Map>> getBookingsForProvider(int providerId) async {
    final db = await getDB();
    return await db.query(
      'bookings',
      where: 'providerId = ?',
      whereArgs: [providerId],
    );
  }

  // Get bookings for a user
  static Future<List<Map>> getBookingsForUser(int userId) async {
    final db = await getDB();
    return await db.query(
      'bookings',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  // Update booking status
  static Future<void> updateBookingStatus(int bookingId, String status) async {
    final db = await getDB();
    await db.update(
      'bookings',
      {'status': status},
      where: 'id = ?',
      whereArgs: [bookingId],
    );
  }

  // Update services for a provider
  static Future<void> updateProviderServices(int id, String services) async {
    final db = await getDB();
    await db.update(
      'users',
      {'services': services},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Clear all data (for testing)
  static Future<void> clearAll() async {
    final db = await getDB();
    await db.delete('bookings');
    await db.delete('users');
    print("🧹 All data cleared.");
  }
}
