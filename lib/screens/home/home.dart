import 'package:ez_notes/models/note.dart';
import 'package:ez_notes/models/user.dart';
import 'package:ez_notes/screens/home/note_list.dart';
import 'package:ez_notes/screens/home/settings_form.dart';
import 'package:ez_notes/shared/constant.dart';
import 'package:ez_notes/services/auth.dart';
import 'package:ez_notes/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:ez_notes/services/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();

  static _HomeState? of(BuildContext context) =>
      context.findAncestorStateOfType<_HomeState>();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  UserData? _userData;

  List<int> _selectedItems = [];

  set selectedItems(List<int> list) => setState(() => _selectedItems = list);

  List<int> get selectedItems {
    return _selectedItems;
  }

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        backgroundColor: bgColorTheme,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Column(
              children: [
                SettingsForm(_userData),
              ],
            ),
          );
        },
      );
    }

    return MultiProvider(
      providers: [
        StreamProvider<List<Note>>.value(
          value: DatabaseService(_auth.userId).notes,
          child: NoteList(),
          initialData: [],
          catchError: (_, context) {
            //TODO: if connection is lost, prevent the list from disappearing
            // (this is actually the case but it could be better to just implement
            // a refresh button)
            return _.read();
          },
        ),
        StreamProvider<List<Reminder>>.value(
          value: DatabaseService(_auth.userId).reminders,
          initialData: [],
          catchError: (_, context) {
            return _.read();
          },
        )
      ],
      child: Scaffold(
        backgroundColor: bgColorTheme,
        appBar: AppBar(
          backgroundColor: colorTheme,
          elevation: 0.0,
          title: StreamBuilder<UserData>(
            stream: DatabaseService(_auth.userId).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserData? userData = snapshot.data;
                _userData = userData;

                return Center(
                  child: Text(
                    userData!.name,
                    style: GoogleFonts.outfit(color: bgColorTheme),
                  ),
                );
              }
              return Center();
            },
          ),
          leading: IconButton(
            icon: Icon(Icons.logout_rounded, color: bgColorTheme),
            onPressed: () {
              Widget logoutCancelButton = TextButton(
                child: Text('Annuler'),
                onPressed: () => Navigator.pop(context),
              );
              Widget logoutContinueButton = TextButton(
                child: Text('Confirmer'),
                onPressed: () {
                  _auth.signOut();
                  Navigator.pop(context);
                },
              );
              AlertDialog logoutAlert = AlertDialog(
                title: Text('Déconnexion'),
                content: Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
                actions: [logoutCancelButton, logoutContinueButton],
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return logoutAlert;
                },
              );
            },
          ),
          actions: [
            (_selectedItems.isNotEmpty)
                ? PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: bgColorTheme),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text(
                          'Déselectionner',
                          style: GoogleFonts.outfit(),
                        ),
                        value: 1,
                        onTap: () => setState(() {
                          _selectedItems.clear();
                        }),
                      ),
                      PopupMenuItem(
                        child: Text(
                          "Supprimer",
                          style: GoogleFonts.outfit(),
                        ),
                        value: 2,
                        onTap: () {
                          Widget deleteCancelButton = TextButton(
                            child: Text('Annuler'),
                            onPressed: () => Navigator.pop(context),
                          );

                          Widget deleteContinueButton = TextButton(
                            child: Text('Confirmer'),
                            onPressed: () {
                              List<Note> notes = Provider.of<List<Note>?>(
                                      context,
                                      listen: false) ??
                                  [];
                              for (int i in _selectedItems) {
                                DatabaseService(_auth.userId)
                                    .deleteNote(notes[i]);
                              }
                              setState(() {
                                _selectedItems.clear();
                              });
                              Navigator.pop(context);
                            },
                          );
                          AlertDialog deleteAlert = AlertDialog(
                            title: Text('Suppression'),
                            content: Text('Voulez-vous supprimer ces notes ?'),
                            actions: [deleteCancelButton, deleteContinueButton],
                          );
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return deleteAlert;
                              },
                            );
                          });
                        },
                      ),
                    ],
                  )
                : IconButton(
                    icon: Icon(Icons.settings, color: bgColorTheme),
                    onPressed: () => _showSettingsPanel(),
                  ),
          ],
        ),
        body: NoteList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            DatabaseService(_auth.userId).createNote();
          },
          child: Icon(
            Icons.add_circle_rounded,
            color: bgColorTheme,
            size: 55,
          ),
          backgroundColor: colorTheme,
        ),
      ),
    );
  }
}
