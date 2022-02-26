import 'package:flutter/material.dart';

class PassengerDetails extends StatefulWidget {
  final String passengerName, trips, airlineName, airlineCountry, airlineImage;
  PassengerDetails({
    Key key,
    this.passengerName,
    this.airlineCountry,
    this.airlineImage,
    this.airlineName,
    this.trips,
  }) : super(key: key);

  @override
  State<PassengerDetails> createState() => _PassengerDetailsState();
}

class _PassengerDetailsState extends State<PassengerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Card(
            elevation: 8,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.airlineImage),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Row(
                    children: [
                      const Text("Airline Name :"),
                      Expanded(
                        child: Text(
                          "  ${widget.airlineName}",
                          textAlign: TextAlign.end,
                          style: const TextStyle(color: Colors.teal),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Row(
                    children: [
                      const Text("Country :"),
                      Expanded(
                        child: Text(
                          "  ${widget.airlineCountry}",
                          textAlign: TextAlign.end,
                          style: const TextStyle(color: Colors.teal),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Row(
                    children: [
                      const Text("Total Trips :"),
                      Expanded(
                        child: Text(
                          "  ${widget.trips}",
                          textAlign: TextAlign.end,
                          style: const TextStyle(color: Colors.teal),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appbarWidget() {
    return AppBar(
      title: Text(
        '${widget.passengerName}',
        style: const TextStyle(
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
}
