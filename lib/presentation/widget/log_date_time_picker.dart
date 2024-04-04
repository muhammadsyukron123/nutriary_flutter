import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/model/user/user.dart';
import '../provider/consumption_log_provider.dart';
import '../provider/get_user_log_dates_provider.dart';
import '../provider/summary_provider.dart';
import 'food_log_list_card.dart';

class LogDateTimePicker extends StatelessWidget {
  final User user;

  LogDateTimePicker({required this.user});

  @override
  Widget build(BuildContext context) {
    return Consumer<GetUserlogDatesProvider>(
      builder: (context, provider, child) {
        List<DateTime> selectedDays = provider.userLogDates.where((date) => date != null).map((date) => date!).toList();
        return TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: provider.focusedDay,
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate: (day) {
            return selectedDays.any((date) =>
            date.year == day.year && date.month == day.month && date.day == day.day);
          },
          eventLoader: (day) {
            return selectedDays.contains(day) ? [day] : [];
          },
          onDaySelected: (selectedDay, focusedDay) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              provider.setSelectedDate(selectedDay);
              provider.setFocusedDay(focusedDay);
              Provider.of<SummaryProvider>(context, listen: false).getConsumptionSummaryByDate(user.userId!, selectedDay);
              Provider.of<ConsumptionLogProvider>(context, listen: false).refreshDataByDate(selectedDay);
            });
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.purpleAccent,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),

        );
      },
    );
  }
}