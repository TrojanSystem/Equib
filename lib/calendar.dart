import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



class MultipleResource extends StatefulWidget {
  const MultipleResource({super.key});

  @override
  MultipleResourceState createState() => MultipleResourceState();
}

class MultipleResourceState extends State<MultipleResource> {
  bool _isJoseph = false;
  bool _isStephen = false;
  final List<Appointment> _appointments = <Appointment>[];
  final DataSource _dataSource=DataSource(<Appointment>[]);
  final List<Appointment> _josephAppointments=<Appointment>[];
  final List<Appointment> _stephenAppointments=<Appointment>[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiple resource',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Column(
            children: <Widget>[
              SafeArea(
                child: Row(
                  children: <Widget>[
                    Switch(
                      value: _isJoseph,
                      onChanged: (value) {
                        setState(() {
                          if (value) {
                            _updateJosephAppointments();
                            _dataSource.appointments!.addAll(_josephAppointments);
                            _dataSource.notifyListeners(
                                CalendarDataSourceAction.reset, _josephAppointments);
                          } else {
                            for (int i = 0; i < _josephAppointments.length; i++) {
                              _dataSource.appointments!.remove(_josephAppointments[i]);
                            }
                            _josephAppointments.clear();
                            _dataSource.notifyListeners(
                                CalendarDataSourceAction.reset, _josephAppointments);
                          }
                          _isJoseph = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                    const Text('Dr.Joseph (Nephrologist)'),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Switch(
                    value: _isStephen,
                    onChanged: (value) {
                      setState(() {
                        if (value) {
                          _updateStephenAppointments();
                          _dataSource.appointments!.addAll(_stephenAppointments);
                          _dataSource.notifyListeners(
                              CalendarDataSourceAction.reset, _stephenAppointments);
                        } else {
                          for (int i = 0; i < _stephenAppointments.length; i++) {
                            _dataSource.appointments!.remove(_stephenAppointments[i]);
                          }
                          _stephenAppointments.clear();
                          _dataSource.notifyListeners(
                              CalendarDataSourceAction.reset, _stephenAppointments);
                        }
                        _isStephen = value;
                      });
                    },
                    activeTrackColor: Colors.lightBlue,
                    activeColor: Colors.blue,
                  ),
                  const Text('Dr.Stephen (Cardiologist)'),
                ],
              ),
              Expanded(
                  child: SfCalendar(
                    view: CalendarView.week,
                    dataSource: _dataSource,
                  ))
            ],
          )),
    );
  }

  void _updateJosephAppointments() {
    Appointment newAppointment = Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Interactive Live Workshop on Robotic Surgery in Gynecology',
      color: Colors.lightGreen,
    );
    Appointment newAppointment1 = Appointment(
      startTime: DateTime.now().add(const Duration(days: -3, hours: 6)),
      endTime: DateTime.now().add(const Duration(days: -3, hours: 7)),
      subject:
      'Billion Hearts Beating brings you Happy Heart Fest to celebrate World Heart Day',
      color: Colors.lightGreen,
    );
    Appointment newAppointment2 = Appointment(
      startTime: DateTime.now().add(const Duration(days: -2, hours: 5)),
      endTime: DateTime.now().add(const Duration(days: -2, hours: 6)),
      subject: 'Join Hands for Patient Safety',
      color: Colors.lightGreen,
    );
    Appointment newAppointment3 = Appointment(
      startTime: DateTime.now().add(const Duration(days: -1, hours: 4)),
      endTime: DateTime.now().add(const Duration(days: -1, hours: 5)),
      subject: 'Robotic GI Surgery International Congress',
      color: Colors.lightGreen,
    );
    Appointment newAppointment4 = Appointment(
      startTime: DateTime.now().add(const Duration(days: 3, hours: 8)),
      endTime: DateTime.now().add(const Duration(days: 3, hours: 9)),
      subject: 'World Continence Week - Free Check-up Camp for women',
      color: Colors.lightGreen,
    );
    _josephAppointments.add(newAppointment);
    _josephAppointments.add(newAppointment1);
    _josephAppointments.add(newAppointment2);
    _josephAppointments.add(newAppointment3);
    _josephAppointments.add(newAppointment4);
  }

  void _updateStephenAppointments() {
    Appointment newAppointment5 = Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'CME (Continuing Medical Education) Program',
      color: Colors.lightBlue,
    );
    Appointment newAppointment6 = Appointment(
      startTime: DateTime.now().add(const Duration(days: 1, hours: 4)),
      endTime: DateTime.now().add(const Duration(days: 1, hours: 5)),
      subject: '4th Clinical Nutrition Update',
      color: Colors.lightBlue,
    );
    Appointment newAppointment7 = Appointment(
      startTime: DateTime.now().add(const Duration(days: 2, hours: 3)),
      endTime: DateTime.now().add(const Duration(days: 2, hours: 4)),
      subject: 'National CME on Contemporary Developments in Transplants',
      color: Colors.lightBlue,
    );
    Appointment newAppointment8 = Appointment(
      startTime: DateTime.now().add(const Duration(days: 3, hours: 6)),
      endTime: DateTime.now().add(const Duration(days: 3, hours: 7)),
      subject: 'Oncological Robotic Surgery',
      color: Colors.lightBlue,
    );
    Appointment newAppointment9 = Appointment(
      startTime: DateTime.now().add(const Duration(days: -1, hours: 6)),
      endTime: DateTime.now().add(const Duration(days: -1, hours: 7)),
      subject: 'World Ostomy Day and Awareness Program',
      color: Colors.lightBlue,
    );
    _stephenAppointments.add(newAppointment5);
    _stephenAppointments.add(newAppointment6);
    _stephenAppointments.add(newAppointment7);
    _stephenAppointments.add(newAppointment8);
    _stephenAppointments.add(newAppointment9);
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}