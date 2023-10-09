import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

import '../../data/bloc/events/route_events.dart';
import '../../data/bloc/route_bloc.dart';
import '../../data/models/search.dart';

class WebSearchWidget extends StatefulWidget {
  const WebSearchWidget({super.key});

  @override
  State<WebSearchWidget> createState() => _WebSearchWidgetState();
}

class _WebSearchWidgetState extends State<WebSearchWidget> {
  final _formSearchKey = GlobalKey<FormState>();
  final ctrStartStation = TextEditingController();
  final ctrEndStation = TextEditingController();

  late String _selectedTime = getInitialTime();
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
    final RouteBloc routeBloc = BlocProvider.of<RouteBloc>(context);

    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(20.0),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.blueAccent, width: 5)),
      child: Form(
        key: _formSearchKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                      controller: ctrStartStation,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter start station',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Please insert a start station";
                        return null;
                      }),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0)),
                Expanded(
                  child: TextFormField(
                      controller: ctrEndStation,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter end station',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Please insert an end station";
                        return null;
                      }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedTime,
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
                      if (_formSearchKey.currentState!.validate()) {
                        final search = Search(ctrStartStation.text,
                            ctrEndStation.text, _selectedTime);

                        routeBloc.add(GetRelevantRoutesEvent(search));
                      }
                    },
                    child: const Text("Search"))
              ],
            ),
          ],
        ),
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
