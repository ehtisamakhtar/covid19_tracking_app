import 'package:covid19_tracking_app/view/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String name, image;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  const DetailScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      Reusable(
                          value: widget.totalCases.toString(), title: 'Cases'),
                      Reusable(
                          value: widget.totalDeaths.toString(),
                          title: 'Deaths'),
                      Reusable(
                          value: widget.totalRecovered.toString(),
                          title: 'Recovered'),
                      Reusable(
                          value: widget.active.toString(), title: 'Active'),
                      Reusable(
                          value: widget.critical.toString(), title: 'Critical'),
                      Reusable(
                          value: widget.todayRecovered.toString(),
                          title: 'Today Recovered'),
                      Reusable(value: widget.test.toString(), title: 'Tests'),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
