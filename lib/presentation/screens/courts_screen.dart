import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_booking_front/cubits/booking_cubit.dart';
import 'package:padel_booking_front/cubits/booking_state.dart';
import 'package:padel_booking_front/cubits/court_cubit.dart';
import 'package:padel_booking_front/cubits/court_state.dart';
import 'package:padel_booking_front/models/club.dart';
import 'package:padel_booking_front/services/booking_service.dart';
import 'package:padel_booking_front/services/court_service.dart';

import '../widgets/app_header.dart';
import '../widgets/court_accordion.dart';
import '../widgets/date_selector.dart';

class CourtsScreen extends StatefulWidget {
  final Club club;

  const CourtsScreen({required this.club, super.key});

  @override
  State<CourtsScreen> createState() => _CourtsScreenState();
}

class _CourtsScreenState extends State<CourtsScreen> {
  DateTime _selectedDate = DateTime.now();

  void _changeDate(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CourtCubit(CourtService())..loadCourts(widget.club.id),
        ),
        BlocProvider(create: (_) => BookingCubit(BookingService())),
      ],
      child: BlocListener<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is BookingSuccess) {
            context.read<CourtCubit>().loadCourts(widget.club.id);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Réservation effectuée avec succès !'),
              ),
            );
          }

          if (state is BookingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur : ${state.message}')),
            );
          }
        },
        child: Scaffold(
          appBar: AppHeader(title: 'Courts de padel'),
          body: Column(
            children: [
              MyDateSelector(
                selectedDate: _selectedDate,
                onPreviousDay: () => _changeDate(-1),
                onNextDay: () => _changeDate(1),
                onSelectDate: _selectDate,
              ),

              Expanded(
                child: BlocBuilder<CourtCubit, CourtState>(
                  builder: (context, state) {
                    if (state is CourtLoading || state is CourtInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is CourtError) {
                      return Center(child: Text('Erreur : ${state.message}'));
                    }

                    final courts = (state as CourtLoaded).courts;

                    return ListView.builder(
                      itemCount: courts.length,
                      itemBuilder: (context, index) {
                        final court = courts[index];

                        return CourtAccordion(
                          court: court,
                          date: _selectedDate,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
