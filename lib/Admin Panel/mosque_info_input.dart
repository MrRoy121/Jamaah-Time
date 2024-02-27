import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Constants/constant.dart';

class MosqueInfoInput extends StatefulWidget {
  const MosqueInfoInput({Key? key}) : super(key: key);

  @override
  State<MosqueInfoInput> createState() => _MosqueInfoInputState();
}

class _MosqueInfoInputState extends State<MosqueInfoInput> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mosqueNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedCity = "London";
  final TextEditingController _fajrTimeController = TextEditingController();
  final TextEditingController _zuhrTimeController = TextEditingController();
  final TextEditingController _asrTimeController = TextEditingController();
  final TextEditingController _maghribTimeController = TextEditingController();
  final TextEditingController _ishaTimeController = TextEditingController();

  final List<String> cities = [
    "London", "Westminster", "Birmingham", "Leeds", "Glasgow", "Manchester", "Sheffield", "Bradford", "Liverpool", "Bristol",
    "Edinburgh", "Cardiff", "Leicester", "Coventry", "Wakefield", "Belfast", "Nottingham", "Newcastle upon Tyne",
    "Doncaster", "Milton Keynes", "Salford", "Sunderland", "Brighton & Hove", "Wolverhampton", "Kingston upon Hull",
    "Plymouth", "Derby", "Stoke-on-Trent", "Southampton", "Swansea", "Aberdeen", "Peterborough", "Portsmouth",
    "York", "Colchester", "Chelmsford", "Southend-on-Sea", "Oxford", "Newport", "Canterbury", "Preston",
    "Cambridge", "St Albans", "Dundee", "Lancaster", "Norwich", "Exeter", "Wrexham", "Gloucester", "Winchester",
    "Derry", "Carlisle", "Worcester", "Lincoln", "Durham", "Chester", "Bath", "Inverness", "Bangor", "Hereford",
    "Dunfermline", "Perth", "Lisburn", "Salisbury", "Stirling", "Lichfield", "Newry", "Chichester", "Ely",
    "Bangor", "Truro", "Ripon", "Armagh", "Wells", "St Asaph", "St Davids"
  ];

  Future<void> _saveFormData() async {
    try {
      await FirebaseFirestore.instance.collection('MosqueInfo').add({
        'mosqueName': _mosqueNameController.text,
        'address': _addressController.text,
        'date': _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : null,
        'city': _selectedCity,
        'fajr': _fajrTimeController.text,
        'Zuhr': _zuhrTimeController.text,
        'Asr': _asrTimeController.text,
        'Maghrib': _maghribTimeController.text,
        'Isha': _ishaTimeController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data uploaded'),
        ),
      );

      _formKey.currentState?.reset();
      setState(() {
        _selectedDate = null;
      });
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, TextEditingController timeController) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        timeController.text = '${picked.hour}:${picked.minute} ${picked.period == DayPeriod.am ? 'AM' : 'PM'}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'Assets/logo.png',
          width: 10,
          height: 10,
        ),
        title: Text(
          "Jama'ah Time",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                      decoration: BoxDecoration(
                        color: AppColor_textfield,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: _mosqueNameController,
                        decoration: InputDecoration(
                          labelText: 'Mosque Name',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor_text,
                          ),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the mosque name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                      decoration: BoxDecoration(
                        color: AppColor_textfield,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(labelText: 'Address', border: InputBorder.none, labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor_text,
                        ),),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the address';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10,),

                    Container(
                      padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                      decoration: BoxDecoration(
                        color: AppColor_textfield,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: DropdownButtonFormField(
                        value: _selectedCity,
                        items: cities.map((city) {
                          return DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCity = value.toString();
                          });
                        },
                        decoration: InputDecoration(labelText: 'City', border: InputBorder.none, labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor_text,
                        ), ),
                      ),
                    ),

                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                      decoration: BoxDecoration(
                        color: AppColor_textfield,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () => _selectDate(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate != null
                                  ? '${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'
                                  : 'Select Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor_text,
                              ),
                            ),
                            Icon(Icons.calendar_today, color: AppColor_text),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Container(
                      padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                      decoration: BoxDecoration(
                        color: AppColor_textfield,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: _fajrTimeController,
                        decoration: InputDecoration(
                          labelText: 'Fajr Time',
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor_text,
                          ),
                        ),
                        onTap: () => _selectTime(context, _fajrTimeController),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Fajr time';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10,),

                    Container(
                      padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                      decoration: BoxDecoration(
                        color: AppColor_textfield,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: _zuhrTimeController,
                        decoration: InputDecoration(
                          labelText: 'Zuhr Time',
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor_text,
                          ),
                        ),
                        onTap: () => _selectTime(context, _zuhrTimeController),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Zuhr time';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10,),

                    Container(
                      padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                      decoration: BoxDecoration(
                        color: AppColor_textfield,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: _asrTimeController,
                        decoration: InputDecoration(
                          labelText: 'Asr Time',
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor_text,
                          ),
                        ),
                        onTap: () => _selectTime(context, _asrTimeController),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Asr time';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10,),

                    Container(
                      padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                      decoration: BoxDecoration(
                        color: AppColor_textfield,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: _maghribTimeController,
                        decoration: InputDecoration(
                          labelText: 'Maghrib Time',
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor_text,
                          ),
                        ),
                        onTap: () => _selectTime(context, _maghribTimeController),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Maghrib time';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10,),

                    Container(
                      padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                      decoration: BoxDecoration(
                        color: AppColor_textfield,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: _ishaTimeController,
                        decoration: InputDecoration(
                          labelText: 'Isha Time',
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor_text,
                          ),
                        ),
                        onTap: () => _selectTime(context, _ishaTimeController),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Isha time';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(height: 16.0),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _saveFormData();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: AppColor,
                        ),
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
