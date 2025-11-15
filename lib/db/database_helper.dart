import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/ticket.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tickets.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tickets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        category TEXT,
        status TEXT,
        createdAt TEXT
      )
    ''');
  }

  Future<int> insertTicket(Ticket ticket) async {
    final db = await instance.database;
    return db.insert('tickets', ticket.toMap());
  }

  Future<List<Ticket>> getTickets() async {
    final db = await instance.database;
    final result = await db.query('tickets', orderBy: "id DESC");
    return result.map((e) => Ticket.fromMap(e)).toList();
  }

  Future<int> updateStatus(int id, String status) async {
    final db = await instance.database;
    return db.update(
      'tickets',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
