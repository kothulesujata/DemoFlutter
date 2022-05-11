import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({
    Key? key,
  }) : super(key: key);

  @override
  _FarmerRegisterPageState createState() => _FarmerRegisterPageState();
}

class _FarmerRegisterPageState extends State<RegisterUserPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _phoneNoCtrl = TextEditingController();
  final _age = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();

  final _firstNameFNode = FocusNode();
  final _lastNameFNode = FocusNode();
  final _phoneNoFNode = FocusNode();
  final _ageNoFNode = FocusNode();
  final _dobFNode = FocusNode();
  final _pinFNode = FocusNode();

  bool _hasOption = false;
  Map<String, String> _options = {};
  String? _selectedOption;

  final _date18YearsAgo = DateTime.now().subtract(Duration(days: 18 * 365 + 5));

  List<Widget> get _registerFormFields {
    final fields = <Widget>[];

    final firstName = <Widget>[
      TextFormField(
        focusNode: _firstNameFNode,
        controller: _firstNameCtrl,
        decoration: InputDecoration(
          labelText: 'First Name',
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
        ],
        validator: (value) {
          if (value == null || value.replaceAll(' ', '').isEmpty) {
            return 'First name required';
          }
          return null;
        },
        textInputAction: TextInputAction.next,
      ),
    ];

    final lastName = <Widget>[
      TextFormField(
        focusNode: _lastNameFNode,
        controller: _lastNameCtrl,
        decoration: InputDecoration(
          labelText: 'Last Name',
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
        ],
        validator: (value) {
          if (value == null || value.replaceAll(' ', '').isEmpty) {
            return 'Lase Name is required';
          }
          return null;
        },
        textInputAction: TextInputAction.next,
      ),
    ];

    final phoneNumber = <Widget>[
      TextFormField(
        focusNode: _phoneNoFNode,
        controller: _phoneNoCtrl,
        decoration: InputDecoration(
          labelText: 'Phone Number',
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        validator: (value) {
          if (value!.length != 10) {
            return 'Phone Number';
          }
          return null;
        },
        textInputAction: TextInputAction.next,
      ),
    ];

    final age = <Widget>[
      TextFormField(
        focusNode: _ageNoFNode,
        controller: _age,
        decoration: InputDecoration(
          labelText: 'Age',
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        validator: (value) {
          if (value!.length == 0) {
            return 'Enter Age';
          }
          return null;
        },
        textInputAction: TextInputAction.next,
      ),
    ];

    final dateOfBirth = <Widget>[
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
                          _dobCtrl.text =
                              DateFormat('dd / MM / yyyy').format(date);
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
                              _dobCtrl.text = DateFormat('dd / MM / yyyy')
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
    ];

    final pinCode = <Widget>[
      TextFormField(
        focusNode: _pinFNode,
        controller: _pinCtrl,
        decoration: InputDecoration(
          labelText: 'Password',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Four digit password',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
        ],
        validator: (value) {},
        textInputAction: TextInputAction.next,
      ),
    ];

    fields.addAll(
      firstName + lastName + phoneNumber + age + dateOfBirth + pinCode,
    );

    return fields;
  }

  @override
  void initState() {}

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_hasOption) ...{
                  CupertinoSegmentedControl<String>(
                    padding: EdgeInsets.zero,
                    groupValue: _selectedOption,
                    children: Map.fromEntries(
                      _options.entries.map(
                        (e) => MapEntry(
                          e.key,
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.key),
                          ),
                        ),
                      ),
                    ),
                    onValueChanged: (value) {
                      _selectedOption = value;
                      print('$_selectedOption  ${_options[_selectedOption]}');
                      setState(() {});
                    },
                  ),
                } else ...{
                  Container(
                    width: 125.0,
                    height: 32.0,
                  ),
                }
              ],
            ),
            SizedBox(height: 32.0),
            Form(
              key: _formKey,
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (lvCtx, i) {
                  return _registerFormFields[i];
                },
                separatorBuilder: (sepCtx, i) {
                  return SizedBox(height: 16.0);
                },
                itemCount: 6,
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(onPressed: () {}, child: Text('Register')),
            OrDivider(text: 'or'),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Alredy have a account',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              child: Text('Click here to Login'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  final String text;
  final EdgeInsets padding;

  const OrDivider({
    Key? key,
    required this.text,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 32.0,
      vertical: 42.0,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[400],
              height: 2.0,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[400],
              height: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}
