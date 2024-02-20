import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../Constants/constant.dart';


class MosqueInfo extends StatefulWidget {
  const MosqueInfo({Key? key}) : super(key: key);

  @override
  _MosqueInfoState createState() => _MosqueInfoState();
}

class _MosqueInfoState extends State<MosqueInfo> {
  String _selectedCity = "Not Selected";
  DateTime? _selectedDate;

  final List<String> cities = [
    "Not Selected","London", "Westminster", "Birmingham", "Leeds", "Glasgow", "Manchester", "Sheffield", "Bradford", "Liverpool", "Bristol",
    "Edinburgh", "Cardiff", "Leicester", "Coventry", "Wakefield", "Belfast", "Nottingham", "Newcastle upon Tyne",
    "Doncaster", "Milton Keynes", "Salford", "Sunderland", "Brighton & Hove", "Wolverhampton", "Kingston upon Hull",
    "Plymouth", "Derby", "Stoke-on-Trent", "Southampton", "Swansea", "Aberdeen", "Peterborough", "Portsmouth",
    "York", "Colchester", "Chelmsford", "Southend-on-Sea", "Oxford", "Newport", "Canterbury", "Preston",
    "Cambridge", "St Albans", "Dundee", "Lancaster", "Norwich", "Exeter", "Wrexham", "Gloucester", "Winchester",
    "Derry", "Carlisle", "Worcester", "Lincoln", "Durham", "Chester", "Bath", "Inverness", "Bangor", "Hereford",
    "Dunfermline", "Perth", "Lisburn", "Salisbury", "Stirling", "Lichfield", "Newry", "Chichester", "Ely",
    "Bangor", "Truro", "Ripon", "Armagh", "Wells", "St Asaph", "St Davids"
  ];

  Widget _buildCard(DocumentSnapshot document) {
    return Card(
      color: AppColor_card,
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(
          "Mosque: ${document['mosqueName']}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor_purple,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Address: ${document['address']}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Text(
              "PRAYER TIMES-",
              style: TextStyle(
                color: AppColor_second,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Fajr: ${document['fajr']}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.red,
              ),
            ),
            Text(
              "Zuhr: ${document['Zuhr']}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.red,
              ),
            ),
            Text(
              "Asr: ${document['Asr']}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.red,
              ),
            ),
            Text(
              "Maghrib: ${document['Maghrib']}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.red,
              ),),
            Text(
              "Isha: ${document['Isha']}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.red,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${document['date']}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Jama'ah Time - Find Mosque",
          style: TextStyle(
            color: AppColor_White,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Expanded(
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
                    decoration: InputDecoration(
                        labelText: 'Select City',
                        labelStyle: TextStyle(
                          // fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () => _selectDate(context),
                        icon: Icon(Icons.calendar_today),
                        tooltip: 'Select Date',
                      ),
                      if (_selectedDate != null)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '${DateFormat('dd-MM-yy').format(_selectedDate!)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _selectedDate == null
                  ? FirebaseFirestore.instance
                  .collection('MosqueInfo')
                  .where('city', isEqualTo: _selectedCity)
                  .snapshots()
                  : FirebaseFirestore.instance
                  .collection('MosqueInfo')
                  .where('city', isEqualTo: _selectedCity)
                  .where('date', isEqualTo: DateFormat('yyyy-MM-dd').format(_selectedDate!))
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.hourglass_empty, size: 100, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          _selectedDate == null
                              ? 'Sorry, No Mosque Found in $_selectedCity!!'
                              : 'Sorry, No Mosque Found in $_selectedCity for ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}!!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return _buildCard(snapshot.data!.docs[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
