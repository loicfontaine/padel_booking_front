import 'package:flutter_bloc/flutter_bloc.dart';

import '/services/booking_service.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingService _bookingService;

  BookingCubit(this._bookingService) : super(BookingInitial());

  Future<void> createBooking(int slotId) async {
    emit(BookingLoading());
    try {
      final booking = await _bookingService.createBooking(slotId);
      emit(BookingSuccess(booking));
    } catch (e) {
      if (isClosed) return;
      emit(BookingError(e.toString()));
    }
  }

  Future<void> loadUserBookings() async {
    emit(BookingLoading());
    try {
      final bookings = await _bookingService.getUserBookings();
      emit(BookingLoaded(bookings));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}
