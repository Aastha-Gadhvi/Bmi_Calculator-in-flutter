import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool switchValue = false;
  var wtController = TextEditingController(); //it writes on textfield and updates its everytime it enters text
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var result = '';
  var bgColor;
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: block.darkThemeEnabled,
      initialData: false,
      builder: (context, snapshot) {
        switchValue = snapshot.data!;

        return MaterialApp(
          theme: switchValue ? ThemeData.dark() : ThemeData.light(),
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("BMI Calculator"),
              actions: <Widget>[
                PopupMenuButton(itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        child: ListTile(
                          title: Text("Dark Theme"),
                          trailing: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Switch(
                              value: switchValue,
                              onChanged: (newValue) {
                                block.changeTheme1(newValue);
                                setState(() {});
                              },
                            );
                          }),
                        )), //Problem
                  ];
                })
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery
                    .of(context).size.height,
                color: bgColor,
                child: Center(
                  child: Container(
                    width: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/weight.png'),
                              radius: 90,
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'BMI',
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 21),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enter your Weight',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              controller: wtController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.cyan.shade500
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.cyan.shade500
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Enter your Height',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: ftController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.cyan.shade500
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.cyan.shade500
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 25),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 110),
                              backgroundColor: Colors.cyan.shade500,
                              shape: StadiumBorder(
                              ),
                            ),
                            onPressed: () {
                              var wt = wtController.text
                                  .toString(); //it takes the data entered by the user and then converts it into string
                              var ft = ftController.text.toString();
                              if (wt != '' && ft != '') {
                                var int_wt = double.parse(
                                    wt); // converts string to integer
                                var int_ft = double.parse(ft);
                                //var int_inch= double.parse(inch);

                                var total_inch = int_ft *
                                    12; // All the values are converted into inches
                                var total_cm = total_inch *
                                    2.54; // After converting to inches then converted into in Centimeter
                                var total_m = total_cm /
                                    100; // After converting to Centimeters then converted into meters
                                var bmi = int_wt / (total_m * total_m);
                                var msg = '';
                                if (bmi > 25) {
                                  msg = 'You are Overweight !!!';
                                  bgColor = Colors.red.shade300;
                                } else if (bmi < 18) {
                                  msg = 'You are Underweight !!!';
                                  bgColor = Colors.red.shade100;
                                } else {
                                  msg = 'You are Healthy !!!';
                                  bgColor = Colors.green.shade200;
                                }

                                setState(() {
                                  result =
                                  '       Your Result \n$msg \n Your BMI is ${bmi
                                      .toStringAsFixed(
                                      2)}'; //takes the bmi value upto 2 digits after decimal
                                });
                              } else {
                                setState(() {
                                  result =
                                  'Please fill all the required blanks!!!';
                                });
                              }
                            },
                            child: Text(
                              'Calculate',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black87
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 11,),
                        Center(
                          child: Text(
                            '$result',
                            style: TextStyle(
                              fontSize: 19,
                            ),
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
      },
    );
  }
}

class Block {
  final _themeContol = StreamController<bool>();

  void changeTheme1(bool value) {
    _themeContol.sink.add(value);
  }

  get changeTheme => _themeContol.sink.add;

  get darkThemeEnabled => _themeContol.stream;
}

final block = Block();


