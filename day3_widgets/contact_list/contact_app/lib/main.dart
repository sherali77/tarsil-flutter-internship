import 'package:flutter/material.dart';

void main() {
  runApp(const ContactApp());
}

class ContactApp extends StatelessWidget {
  const ContactApp({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> nameList = [
      'Sher Ali',
      'Awais Ali',
      'Ahmed Ali',
      'Arshad Ali',
      'Abdullah',
      'Umair',
      'Saif',
      'Sami',
      'Abdul Rehman',
      'Asif',
      'Hamza',
      'Nabeel',
      'Ibrahim',
      'Momin',
      'Husnain Ali',
    ];
    final List<String> phoneList = [
      '03425796139',
      '03338108509',
      '03117577850',
      '03113847956',
      '03228857506',
      '03251267406',
      '03278006906',
      '03114857706',
      '03865437906',
      '03414866916',
      '03516857302',
      '03278565903',
      '03238834956',
      '03516767956',
      '03418845606',
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Contact App",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: nameList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    color: Colors.grey.shade100,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nameList[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              phoneList[index],
                              style: TextStyle(
                                fontSize: 14,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${nameList[index]} has been pressed!",
                                ),
                                duration: const Duration(seconds: 3),
                                backgroundColor: Colors.black87,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            fixedSize: const Size(100, 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text("contact"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
