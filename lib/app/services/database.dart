import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../data/models.dart';

class NotesDatabaseService {
  late String path;

  NotesDatabaseService._();

  static final NotesDatabaseService db = NotesDatabaseService._();

  late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // If _database is null, we instantiate it
    _database = await init();
    return _database;
  }

  init() async {
    String path = await getDatabasesPath();
    path = join(path, 'notes.db');
    print("Entered path $path");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Notes (_id INTEGER PRIMARY KEY, title TEXT, content TEXT, date TEXT, isImportant INTEGER);');
      print('New table created at $path');
    });
  }

  Future<List<NotesModel>> getNotesFromDB() async {
    final db = await database;
    List<NotesModel> notesList = [];
    List<Map<String, dynamic>> maps = await db.query('Notes',
        columns: ['_id', 'title', 'content', 'date', 'isImportant']);
    if (maps.length > 0) {
      notesList = maps.map((map) => NotesModel.fromMap(map)).toList();
    }
    return notesList;
  }

  Future<void> updateNoteInDB(NotesModel updatedNote) async {
    final db = await database;
    await db.update('Notes', updatedNote.toMap(),
        where: '_id = ?', whereArgs: [updatedNote.id]);
    print('Note updated: ${updatedNote.title} ${updatedNote.content}');
  }

  Future<void> deleteNoteInDB(NotesModel noteToDelete) async {
    final db = await database;
    await db.delete('Notes', where: '_id = ?', whereArgs: [noteToDelete.id]);
    print('Note deleted');
  }

  Future<NotesModel> addNoteInDB(NotesModel newNote) async {
    final db = await database;
    if (newNote.title.trim().isEmpty) newNote.title = 'Untitled Note';
    final int id = await db.rawInsert(
      'INSERT into Notes(title, content, date, isImportant) VALUES (?, ?, ?, ?);',
      [
        newNote.title,
        newNote.content,
        newNote.date.toIso8601String(),
        newNote.isImportant == true ? 1 : 0
      ],
    );
    newNote.id = id;
    print('Note added: ${newNote.title} ${newNote.content}');
    return newNote;
  }
}
