import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/screens/calendar/professor_calendar_screen.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/professor.dart';
import '../../../domain/models/schedule.dart';
import '../../../domain/providers/schedule_provider.dart';
import 'calendar_content_screen.dart';

class ProfessorCalendarContentScreen extends StatefulWidget {
  final Schedule schedule;
  final List<Professor> professors;

  const ProfessorCalendarContentScreen({
    super.key,
    required this.schedule,
    required this.professors,
  });

  @override
  _ProfessorCalendarContentScreenState createState() =>
      _ProfessorCalendarContentScreenState();
}

class _ProfessorCalendarContentScreenState
    extends State<ProfessorCalendarContentScreen> {
  late final PageController controller;
  late final ScrollController _scrollController;
  double currentPage = 0;
  int num = 5;
  bool showAllDays = true;
  String? selectedProfessor;
  List<Professor> filteredProfessors = [];
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
    controller.addListener(_onPageChanged);
    _scrollController = ScrollController();
    filteredProfessors = widget.professors;
  }

  @override
  void dispose() {
    controller.removeListener(_onPageChanged);
    controller.dispose();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    setState(() {
      currentPage = controller.page ?? 0;
    });
  }

  void _onDotTapped(double position) {
    int index = position.round();
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _filterProfessors(String query) {
    setState(() {
      filteredProfessors = widget.professors
          .where((professor) =>
              professor.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _overlayEntry?.markNeedsBuild();
    });
  }

  void _showOverlay(BuildContext context) {
    if (_overlayEntry != null) return;

    if (selectedProfessor != null) {
      final selectedProf =
          widget.professors.firstWhere((prof) => prof.id == selectedProfessor);
      filteredProfessors.removeWhere((prof) => prof.id == selectedProfessor);
      filteredProfessors.insert(0, selectedProf);
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 200,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 50),
          child: Material(
            elevation: 4.0,
            child: SizedBox(
              height: 200,
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: ListView(
                  shrinkWrap: true,
                  controller: _scrollController,
                  children: filteredProfessors.map((Professor professor) {
                    return ListTile(
                      title: Text(professor.name),
                      onTap: () {
                        setState(() {
                          selectedProfessor = professor.id;
                          _searchController.text = professor.name;
                          _overlayEntry?.remove();
                          _overlayEntry = null;
                        });
                        Provider.of<ScheduleProvider>(context, listen: false)
                            .setProfessor(professor.id);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ProfessorCalendarScreen()),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0 && currentPage > 0) {
            controller.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          } else if (details.delta.dx < 0 &&
              currentPage < (5 - num).toDouble()) {
            controller.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (showAllDays)
                    SizedBox(
                      width: 200,
                      child: CompositedTransformTarget(
                        link: _layerLink,
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Пребарај професор...',
                            border: UnderlineInputBorder(),
                          ),
                          onChanged: (query) {
                            _filterProfessors(query);
                            if (_overlayEntry == null) {
                              _showOverlay(context);
                            }
                          },
                          onTap: () {
                            if (_overlayEntry == null) {
                              _showOverlay(context);
                            }
                          },
                        ),
                      ),
                    ),
                  const SizedBox(width: 20),
                  if (!showAllDays)
                    DotsIndicator(
                      dotsCount: 5 - num + 1,
                      position: currentPage,
                      decorator: const DotsDecorator(
                        color: Colors.grey,
                        activeColor: Colors.blueAccent,
                      ),
                      onTap: _onDotTapped,
                    ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showAllDays = !showAllDays;
                        num = showAllDays ? 5 : 1;
                        if (showAllDays) {
                          controller.jumpToPage(0);
                          currentPage = 0;
                        }
                      });
                    },
                    child: Text(
                      showAllDays ? 'Еден ден' : 'Сите денови',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller,
                children: getColumns(num, showAllDays, widget.schedule),
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index.toDouble();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
