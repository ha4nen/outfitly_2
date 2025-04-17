import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/magic_page.dart';
import 'package:table_calendar/table_calendar.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  bool _dayTapped = false;

  final Map<DateTime, List<String>> _events = {};

  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _calendarFormat = CalendarFormat.week;
      _dayTapped = true;
    });
  }

  void _toggleCalendarFormat() {
    setState(() {
      _calendarFormat = CalendarFormat.month;
      _dayTapped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final events = _getEventsForDay(_selectedDay ?? _focusedDay);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Plan Your Look', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              onDaySelected: _onDaySelected,
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              availableCalendarFormats: const {
                CalendarFormat.month: '',
                CalendarFormat.week: '',
              },
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                leftChevronVisible: true,
                rightChevronVisible: true,
                titleTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                titleTextFormatter: (date, locale) {
                  return '${_monthName(date.month)} ${date.year}';
                },
              ),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: false,
              ),
            ),
          ),

          // Button to switch back to month view
          if (_calendarFormat == CalendarFormat.week)
            TextButton(
              onPressed: _toggleCalendarFormat,
              child: const Text('Show Full Month'),
            ),

          // Expand section when a date is selected
          AnimatedCrossFade(
            crossFadeState: _dayTapped
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 400),
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: [
                _buildEventCard(events),
                const SizedBox(height: 12),
                _buildOutfitImagePlaceholder(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(List<String> events) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Plans for the Day',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (events.isEmpty)
              Column(
                children: [
                  const Text('No outfit planned.', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.auto_awesome),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MagicPage(
                                  onThemeChange: () {},
                                  fromCalendar: true,
                                ),
                              ),
                            );
                          },
                          label: const Text('Create Your Outfit'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.checkroom, color: Colors.black),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Choose Your Outfit selected')),
                            );
                          },
                          label: const Text('Choose Outfit'),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            else
              Column(
                children: events.map((event) {
                  return ListTile(
                    leading: const Icon(Icons.event),
                    title: Text(event),
                  );
                }).toList(),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildOutfitImagePlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/outfit_placeholder.png'), // Replace with actual asset
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
            child: Text(
              'Your planned outfit will appear here',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                backgroundColor: Colors.black54,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }
}
