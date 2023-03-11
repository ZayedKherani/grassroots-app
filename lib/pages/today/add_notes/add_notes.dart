import 'package:flutter/material.dart';
import 'package:grassroots_app/models/dayPlan/notes/note.dart';
import 'package:grassroots_app/services/dayPlanService/day_plan_service.dart';
import 'package:grassroots_app/services/dayPlanService/notesService/note_service.dart';
import 'package:grassroots_app/universals/variables.dart';

class GrassrootsTodayAddNotes extends StatefulWidget {
  const GrassrootsTodayAddNotes({
    super.key,
  });

  @override
  State<GrassrootsTodayAddNotes> createState() =>
      _GrassrootsTodayAddNotesState();
}

class _GrassrootsTodayAddNotesState extends State<GrassrootsTodayAddNotes> {
  GlobalKey<FormState>? addNoteKey = GlobalKey<FormState>();

  TextEditingController? addNoteController = TextEditingController();

  @override
  Widget build(
    BuildContext? context,
  ) {
    final int? dayPlansIndex = ModalRoute.of(
      context!,
    )!
        .settings
        .arguments as int?;

    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "title",
          child: Text(
            'Add Notes',
            style: Theme.of(
              context,
            ).textTheme.titleLarge,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(
          context,
        ).colorScheme.background,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/home',
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          20.0,
          0.0,
          20.0,
          0.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: globalDayPlans!.dayPlansList![dayPlansIndex!]!.title!,
              child: Material(
                child: Card(
                  margin: EdgeInsets.zero,
                  child: CheckboxListTile(
                    title: Text(
                      globalDayPlans!.dayPlansList![dayPlansIndex]!.title!,
                    ),
                    value: globalDayPlans!
                        .dayPlansList![dayPlansIndex]!.isComplete,
                    onChanged: (
                      bool? value,
                    ) {
                      DayPlanService.toggleDayPlanCompletion(
                        dayPlan: globalDayPlans!.dayPlansList![dayPlansIndex]!,
                      );

                      DayPlanService.writeDayPlansToStorage();

                      setState(
                        () {},
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "Add A New Note:",
              style: Theme.of(
                context,
              ).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Form(
              key: addNoteKey,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Add Notes',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  filled: true,
                ),
                controller: addNoteController,
                maxLines: 5,
                minLines: 1,
                validator: (
                  String? value,
                ) {
                  if (value!.isEmpty) {
                    return 'Note Cannot Be Empty';
                  }

                  return null;
                },
                onChanged: (
                  String? value,
                ) {
                  setState(
                    () {},
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              globalDayPlans!.dayPlansList![dayPlansIndex]!.notes!.notesList!
                      .isNotEmpty
                  ? "View Note${globalDayPlans!.dayPlansList![dayPlansIndex]!.notes!.notesList!.length == 1 ? '' : 's'}:"
                  : "No Notes Added",
              style: Theme.of(
                context,
              ).textTheme.titleLarge,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: globalDayPlans!
                  .dayPlansList![dayPlansIndex]!.notes!.notesList!.length,
              shrinkWrap: true,
              itemBuilder: (
                BuildContext? context,
                int? index,
              ) =>
                  Padding(
                padding: const EdgeInsets.fromLTRB(
                  0.0,
                  10.0,
                  0.0,
                  0.0,
                ),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    title: Text(
                      globalDayPlans!.dayPlansList![dayPlansIndex]!.notes!
                          .notesList![index!]!.message!,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: addNoteController!.text.isNotEmpty
          ? FloatingActionButton(
              onPressed: () async {
                if (addNoteKey!.currentState!.validate()) {
                  await NotesService.addNote(
                    noteToAdd: Note(
                      message: addNoteController!.text,
                      createdAt: DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        DateTime.now().hour,
                        DateTime.now().minute,
                      ),
                    ),
                    notes: globalDayPlans!.dayPlansList![dayPlansIndex]!.notes!,
                  );

                  await DayPlanService.writeDayPlansToStorage();

                  addNoteController!.clear();
                  addNoteController!.text = "";

                  addNoteController!.dispose();

                  addNoteController = TextEditingController();

                  // addNoteKey!.currentState!.reset();

                  addNoteKey!.currentState!.dispose();

                  addNoteKey = GlobalKey<FormState>();

                  setState(
                    () {},
                  );
                }
              },
              child: const Icon(
                Icons.check_rounded,
              ),
            )
          : null,
    );
  }
}
