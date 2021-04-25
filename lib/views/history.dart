import 'package:flutter/material.dart';

class History extends StatefulWidget{
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Card(
                // margin: EdgeInsets.symmetric(vertical: size.height/5, horizontal: size.width/100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)
                        ),
                        color: Color(0XFF0358BD),
                      ),
                      height: 130,
                      child: Center(
                        child: Container(
                          width: 5,
                        ),
                      ),
                    ),
                    Container(
                      height: 130,
                      width: 120,
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "09.00",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color(0XFF797979)
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Agenda",
                                  style: TextStyle(
                                      color: Color(0XFF797979)
                                  ),
                                ),
                                Text(
                                  "05 Okt 2021",
                                  style: TextStyle(
                                      color: Color(0XFF797979)
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0XFFE9E9E9),
                      height: 125,
                      width: 2,
                    ),
                    Container(
                      height: 130,
                      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Clock-In",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0XFF797979)
                                  ),
                                ),
                                Container(
                                  color: Color(0XFFE9E9E9),
                                  height: 2,
                                  width: 270,
                                ),
                                Text(
                                  "Keterangan = P20",
                                  style: TextStyle(
                                      color: Color(0XFF797979),
                                      fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Muhammad Agung Santoso",
                                  style: TextStyle(
                                      color: Color(0XFF797979),
                                      fontSize: 12

                                  ),
                                ),
                                Text(
                                  "Dpt. Teknologi Informasi",
                                  style: TextStyle(
                                      color: Color(0XFF797979),
                                      fontSize: 12

                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
            ),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)
                          ),
                          color: Color(0XFFF29C12),
                        ),
                        height: 130,
                        child: Center(
                          child: Container(
                            width: 5,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 130,
                        width: 120,
                        child: Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "09.00",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Color(0XFF797979)
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Agenda",
                                    style: TextStyle(
                                        color: Color(0XFF797979)
                                    ),
                                  ),
                                  Text(
                                    "05 Okt 2021",
                                    style: TextStyle(
                                        color: Color(0XFF797979)
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        color: Color(0XFFE9E9E9),
                        height: 125,
                        width: 2,
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        height: 130,
                        padding: EdgeInsets.only(left: 10, top: 5, bottom: 5,right: 10),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Clock-In",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0XFF797979)
                                    ),
                                  ),
                                  Container(
                                    color: Color(0XFFE9E9E9),
                                    height: 2,
                                  ),
                                  Text(
                                    "Keterangan = P20",
                                    style: TextStyle(
                                        color: Color(0XFF797979),
                                        fontSize: 12
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Muhammad Agung Santoso",
                                    style: TextStyle(
                                        color: Color(0XFF797979),
                                        fontSize: 12

                                    ),
                                  ),
                                  Text(
                                    "Dpt. Teknologi Informasi",
                                    style: TextStyle(
                                        color: Color(0XFF797979),
                                        fontSize: 12

                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}