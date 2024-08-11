import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crud_odalis/models/usuario.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'odalis_crud.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        apellidos TEXT,
        correo TEXT UNIQUE,
        contrasena TEXT
      )
    ''');
  }

  // Verifica si el correo ya existe en la base de datos
  Future<bool> correoExiste(String correo) async {
    final db = await database;
    var res = await db.query("usuarios", where: "correo = ?", whereArgs: [correo]);
    return res.isNotEmpty;
  }

  // Registra un nuevo usuario
  Future<void> newUser(Usuario usuario) async {
    final db = await database;
    if (await correoExiste(usuario.correo)) {
      throw Exception("El correo ya está registrado. Intenta con un correo diferente.");
    } else {
      await db.insert('usuarios', usuario.toMap());
    }
  }

  // Función para login (como ejemplo)
  Future<Usuario?> login(String correo, String contrasena) async {
    final db = await database;
    var res = await db.query("usuarios",
        where: "correo = ? AND contrasena = ?", whereArgs: [correo, contrasena]);
    return res.isNotEmpty ? Usuario.fromMap(res.first) : null;
  }
  // Obtener todos los usuarios
  Future<List<Usuario>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('usuarios');
    return List.generate(maps.length, (i) {
      return Usuario.fromMap(maps[i]);
    });
  }
}