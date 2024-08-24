import 'package:covid19_tracking_app/services/states_services.dart';
import 'package:covid19_tracking_app/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Countries for Covid 19 Report',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: statesServices.countriesListApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitFadingCircle(
                        color: Colors.grey,
                        size: 50,
                        controller: _controller,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('No data available'),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];

                      if (_searchController.text.isEmpty ||
                          name.toLowerCase().contains(_searchController.text.toLowerCase())) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  name: snapshot.data![index]['country'],
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  totalRecovered: snapshot.data![index]['recovered'],
                                  active: snapshot.data![index]['active'],
                                  critical: snapshot.data![index]['critical'],
                                  todayRecovered: snapshot.data![index]['todayRecovered'],
                                  test: snapshot.data![index]['tests'],
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: Image(
                              height: 50,
                              width: 50,
                              image: NetworkImage(
                                snapshot.data![index]['countryInfo']['flag'],
                              ),
                            ),
                            title: Text(snapshot.data![index]['country']),
                            subtitle:
                            Text(snapshot.data![index]['cases'].toString()),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
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
