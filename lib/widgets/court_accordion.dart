import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_booking_front/widgets/slot_tile.dart';
import '../cubits/slot_cubit.dart';
import '../cubits/slot_state.dart';
import '../models/court.dart';
import '../models/slot.dart';
import '../services/slot_service.dart';

class CourtAccordion extends StatefulWidget {
  final Court court;
  final DateTime date;

  const CourtAccordion({
    super.key,
    required this.court,
    required this.date,
  });

  @override
  State<CourtAccordion> createState() => _CourtAccordionState();
}

class _CourtAccordionState extends State<CourtAccordion> {
  late final SlotCubit _slotCubit;

  @override
  void initState() {
    super.initState();

    _slotCubit = SlotCubit(SlotService())
      ..loadSlotsByCourt(
        widget.court.id,
        widget.date,
      );
  }

  @override
  void didUpdateWidget(CourtAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);

    // La date a changé
    if (oldWidget.date != widget.date) {
      _slotCubit.loadSlotsByCourt(
        widget.court.id,
        widget.date,
      );
    }
  }

  @override
  void dispose() {
    _slotCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _slotCubit,
      child: Card(
        child: ExpansionTile(
          title: Text(widget.court.name),
          children: [
            BlocBuilder<SlotCubit, SlotState>(
              builder: (context, state) {
                if (state is SlotLoading ||
                    state is SlotInitial) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is SlotError) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Erreur : ${state.message}',
                    ),
                  );
                }

                final slots = (state as SlotLoaded).slots;

                if (slots.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Aucun créneau disponible.',
                    ),
                  );
                }

                return Column(
                  children: slots.map((slot) {
                    return SlotTile(slot: slot);
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}