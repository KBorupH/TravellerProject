import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppSearchWidget extends StatefulWidget {
  const AppSearchWidget({super.key});

  @override
  State<AppSearchWidget> createState() => _AppSearchWidgetState();
}

class _AppSearchWidgetState extends State<AppSearchWidget> {
  late String _selectedTime = DateTime.now().toString();
  late final List<DropdownMenuItem<String>> timeEntries;
  late List<String> timeOptions = [];

  List<DropdownMenuItem<String>> setupTimeOptions() {
    late List<DropdownMenuItem<String>> timeEntries =
        <DropdownMenuItem<String>>[];

    for (var i = 0; i < 24; i++) {
      for (var j = 0; j < 60; j += 15) {
        timeOptions.add(
            "${i.toString().padLeft(2, '0')}:${j.toString().padLeft(2, '0')}");
      }
    }

    for (final String time in timeOptions) {
      timeEntries.add(DropdownMenuItem<String>(value: time, child: Text(time)));
    }

    return timeEntries;
  }

  String getInitialTime() {
    for (final String time in timeOptions) {
      DateTime timeOpt = DateFormat('HH:mm').parse(time);
      TimeOfDay timeOfDay = TimeOfDay.now();

      if (timeOfDay.isAfter(TimeOfDay.fromDateTime(timeOpt))) {
        return time;
      }
    }

    return "00:00";
  }

  @override
  void initState() {
    timeEntries = setupTimeOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String initialTime = getInitialTime();

    return Container(
      margin: const EdgeInsets.only(top: 0),
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff6b97c9), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter start station',
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'Enter end station',
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  DropdownButton(
                      value: initialTime,
                      items: timeEntries,
                      menuMaxHeight: 300,
                      onChanged: (value) {
                        _selectedTime = value!;
                      }),
                  const Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                  const Text("Arrival Time"),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    //call bloc with _selectedTime
                  },
                  child: const Text("Search")),
            ],
          ),
        ],
      ),
    );
  }
}

extension TimeOfDayExtension on TimeOfDay {
  bool isAfter(TimeOfDay other) {
    if (hour < other.hour) return false;
    if (hour > other.hour) return true;
    if (minute < other.minute) return false;
    if (minute > other.minute) return true;
    return false;
  }
}
