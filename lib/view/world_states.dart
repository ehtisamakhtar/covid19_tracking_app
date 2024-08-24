import 'package:covid19_tracking_app/model/WorldStatesModel.dart';
import 'package:covid19_tracking_app/services/states_services.dart';
import 'package:covid19_tracking_app/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .01),
                FutureBuilder(
                    future: statesServices.fetchWorldStatesRecords(),
                    builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                      print(snapshot.data);
                      if (!snapshot.hasData) {
                        return Expanded(
                            flex: 1,
                            child: SpinKitFadingCircle(
                              color: Colors.grey,
                              size: 50,
                              controller: _controller,
                            ));
                      } else {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                'Total': double.parse(
                                    snapshot.data!.cases!.toString()),
                                'Recovered': double.parse(
                                    snapshot.data!.recovered.toString()),
                                'Deaths': double.parse(
                                    snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              chartRadius:
                                  MediaQuery.of(context).size.width / 2.5,
                              animationDuration: Duration(
                                microseconds: 3000,
                              ),
                              legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * .03),
                              child: Card(
                                child: Column(
                                  children: [
                                    Reusable(
                                      title: 'Total Cases',
                                      value: snapshot.data!.cases!.toString(),
                                    ),
                                    Reusable(
                                      title: 'Recovered',
                                      value: snapshot.data!.recovered.toString(),
                                    ),
                                    Reusable(
                                      title: 'Deaths',
                                      value: snapshot.data!.deaths.toString(),
                                    ),
                                    Reusable(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString(),
                                    ),
                                    Reusable(
                                      title: 'Critical',
                                      value: snapshot.data!.critical.toString(),
                                    ),
                                    Reusable(
                                      title: 'Today Deaths',
                                      value: snapshot.data!.todayDeaths.toString(),
                                    ),
                                    Reusable(
                                      title: 'Today Recovered',
                                      value: snapshot.data!.todayRecovered.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (contex) => CountriesList()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Track Countries',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Reusable extends StatefulWidget {
  String value, title;
  Reusable({super.key, required this.value, required this.title});

  @override
  State<Reusable> createState() => _ReusableState();
}

class _ReusableState extends State<Reusable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title),
              Text(widget.value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
