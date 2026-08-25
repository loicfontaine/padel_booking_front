import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPreviousDay;
  final VoidCallback onNextDay;
  final VoidCallback onSelectDate;

  const MyDateSelector({
    super.key,
    required this.selectedDate,
    required this.onPreviousDay,
    required this.onNextDay,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat(
      'EEEE d MMMM',
      'fr_FR',
    );

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onPreviousDay,
            icon: const Icon(Icons.chevron_left),
          ),

          Expanded(
            child: InkWell(
              onTap: onSelectDate,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 10),
                    Text(
                      dateFormatter.format(selectedDate),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          IconButton(
            onPressed: onNextDay,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}