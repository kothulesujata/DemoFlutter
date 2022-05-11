import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddReading extends StatefulWidget {
  const AddReading({Key? key}) : super(key: key);

  @override
  State<AddReading> createState() => _AddReadingState();
}

class _AddReadingState extends State<AddReading> {
  final _ageNoFNode = FocusNode();
  final _age = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _dobFNode = FocusNode();
  final _date18YearsAgo = DateTime.now();
  bool isbefore = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 16.0 + kToolbarHeight + MediaQuery.of(context).padding.top,
              left: 16.0,
              right: 16.0,
              bottom: 16.0 + kBottomNavigationBarHeight,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          !isbefore;
                          setState(() {});
                        },
                        child: Card(
                            child: Center(
                              child: Container(
                                  height: 50,
                                  width: 100,
                                  child: Center(child: Text(' Before Meal'))),
                            ),
                            clipBehavior: Clip.antiAlias,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0))),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {},
                        child: Card(
                            child: Center(
                              child: Container(
                                  height: 50,
                                  width: 100,
                                  child: Center(child: Text('After Meal'))),
                            ),
                            clipBehavior: Clip.antiAlias,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  focusNode: _ageNoFNode,
                  controller: _age,
                  decoration: InputDecoration(
                    labelText: 'Reading',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  validator: (value) {
                    if (value!.length == 0) {
                      return 'Enter Reading';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  focusNode: _dobFNode,
                  controller: _dobCtrl,
                  decoration: InputDecoration(
                    labelText: 'DOB',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'dd / mm / yyyy',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (dCtx) {
                        final maxDate = _date18YearsAgo;
                        final minDate = DateTime(1950);
                        final selectedDate = _dobCtrl.text.isNotEmpty
                            ? DateFormat('dd / MM / yyyy').parse(_dobCtrl.text)
                            : _date18YearsAgo.subtract(Duration(hours: 1));

                        return Dialog(
                          insetPadding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 24.0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 200.0,
                                child: CupertinoDatePicker(
                                  onDateTimeChanged: (date) {
                                    _dobCtrl.text = DateFormat('dd / MM / yyyy')
                                        .format(date);
                                  },
                                  dateOrder: DatePickerDateOrder.dmy,
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: selectedDate,
                                  minimumDate: minDate,
                                  maximumDate: maxDate,
                                  minimumYear: minDate.year,
                                  maximumYear: maxDate.year,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      if (_dobCtrl.text.isEmpty) {
                                        _dobCtrl.text =
                                            DateFormat('dd / MM / yyyy')
                                                .format(selectedDate);
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Ok'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select Date of birth';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Successfully submitted")),
                      );
                    },
                    child: Text('Submit'))
              ],
            )));
  }
}
