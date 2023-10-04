import 'package:traveller_app/data/MockupData/models/mockup_data_models.dart';
import 'package:traveller_app/data/MockupData/models/staff.dart';

class Train {
  Train(this.id, this.seats, this.staff);

  final String id;
  final List<Seat> seats;
  final List<Staff> staff;
}