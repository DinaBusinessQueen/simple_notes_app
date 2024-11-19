import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/components/drawer.dart';
import 'package:notes/components/note_tile.dart';
import 'package:notes/main.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNotes();
  }

// create a note
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                content: TextField(
                  controller: textController,
                ), // TextField actions:

                actions: [
                  MaterialButton(
                      onPressed: () {
                        context
                            .read<NoteDatabase>()
                            .addNote(textController.text);

                        textController.clear();

                        Navigator.pop(context);
                      },
                      child: const Text('Создать')),
                ]));
  }

  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  void updateNote(Note note) {
    textController.text = note.text;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Обновить заметку'),
                content: TextField(
                  controller: textController,
                ), // TextField actions:

                actions: [
                  MaterialButton(
                      onPressed: () {
                        context
                            .read<NoteDatabase>()
                            .updateNote(note.id, textController.text);

                        textController.clear();

                        Navigator.pop(context);
                      },
                      child: const Text('Обновить')),
                ]));
  }

  void deleteNote(int id) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Удалить заметку?'),
                content:
                    const Text('Вы уверены, что хотите удалить эту заметку?'),
                actions: [
                  MaterialButton(
                      onPressed: () {
                        context.read<NoteDatabase>().deleteNote(id);

                        Navigator.pop(context);
                      },
                      child: const Text('Удалить')),
                ]));
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'Заметки',
                style: GoogleFonts.dmSerifText(
                    fontSize: 48,
                    color: Theme.of(context).colorScheme.inversePrimary),
              )),
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];
                return NoteTile(
                  text: note.text,
                  onEditPressed: () => updateNote(note),
                  onDeletePressed: () => deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
