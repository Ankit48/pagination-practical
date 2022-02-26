import 'package:flutter/material.dart';
import 'package:pagination/bloc/passenger_bloc.dart';
import 'package:pagination/passenger_details.dart';
import 'package:pagination/utils/error.dart';
import 'package:pagination/utils/loading.dart';
import 'package:pagination/utils/response.dart';

import 'model/common_model.dart';

class Listing extends StatefulWidget {
  Listing({Key key}) : super(key: key);

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List _pessengerList = [];
  bool firstLoad = true;
  bool isLoading = false;

  PassengerBloc _passengerBloc;

  @override
  void initState() {
    super.initState();
    _passengerBloc = PassengerBloc(page, firstLoad);
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
        } else {
          try {
            firstLoad = false;
            isLoading = true;
            _passengerBloc.fetchData(page, firstLoad);
          } catch (e) {
            debugPrint('Error: $e');
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _passengerBloc.dispose();
    super.dispose();
  }

  //------------- Build Fun -----------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: StreamBuilder(
        stream: _passengerBloc.roiEarningBlocDataStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Container(
                  child: Loading(loadingMessage: snapshot.data.message),
                );
                break;
              case Status.COMPLETED:
                return _pessangerListWidget(snapshot.data.data);
                break;
              case Status.ERROR:
                return Errors(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () =>
                      _passengerBloc.fetchData(page, firstLoad),
                );
                break;
            }
          }

          return Container();
        },
      ),
    );
  }

  Widget _appbarWidget() {
    return AppBar(
      title: const Text(
        'Passengers',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF37C8C3), Colors.teal],
          ),
        ),
      ),
    );
  }

  Widget _pessangerListWidget(CommonModel commonModel) {
    page++;
    _pessengerList.addAll(commonModel.data);
    if (commonModel.data.length > 25) {
      isLoading = true;
    }
    if (commonModel.data.length == 0) {
      isLoading = false;
    }

    return _pessengerList.length != 0
        ? SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: <Widget>[
                _listWidget(),
                _buildProgressIndicator(),
              ],
            ),
          )
        : _noDataFoundWidget();
  }

  Widget _listWidget() {
    return ListView.builder(
        //controller: _scrollController,
        primary: false,
        shrinkWrap: true,
        itemCount: _pessengerList != null ? _pessengerList.length : 0,
        padding:
            EdgeInsets.only(top: 15.0, bottom: 15.0, right: 5.0, left: 5.0),
        itemBuilder: (BuildContext context, int index) {
          var count = index + 1;
          var name = _pessengerList[index]['name'] ?? '';
          var trips = _pessengerList[index]['trips'] ?? '';
          var airlineName = _pessengerList[index]['airline'][0]['name'] ?? '';
          var airlineCountry =
              _pessengerList[index]['airline'][0]['country'] ?? '';
          var airlineImage = _pessengerList[index]['airline'][0]['logo'] ?? '';

          return Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PassengerDetails(
                        passengerName: name,
                        trips: trips.toString(),
                        airlineName: airlineName,
                        airlineCountry: airlineCountry,
                        airlineImage: airlineImage,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(-3, -2),
                          blurRadius: 8.0,
                          spreadRadius: 2.0,
                        ),
                      ]),
                  margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '$name',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF37C8C3),
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFF37C8C3), width: 1.0),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Trip: $trips',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Color(0xFF37C8C3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                        child: Row(
                          children: [
                            // CircleAvatar(
                            //     radius: 12,
                            //     backgroundImage: NetworkImage(airlineImage)),
                            Container(
                              height: 25,
                              width: 25,
                              child: Image.network(airlineImage),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text('$airlineName, $airlineCountry',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 30,
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xFF37C8C3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    '$count',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _noDataFoundWidget() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(25),
        child: const Text('No Data Found'),
      ),
    );
  }
}
