import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Simulation/simulation_gp_screen.dart';
import 'package:kreditpensiun_apps/Screens/Simulation/simulation_screen.dart';
import 'package:kreditpensiun_apps/Screens/Simulation/simulation_tht_screen.dart';
import 'package:kreditpensiun_apps/constants.dart';

class SimulationViewScreen extends StatefulWidget {
  @override
  _SimulationViewScreenState createState() => _SimulationViewScreenState();
}

class _SimulationViewScreenState extends State<SimulationViewScreen> {
  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(
      fontFamily: "Montserrat Regular",
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Simulation',
          style: TextStyle(
            fontFamily: 'Montserrat Regular',
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
                color: Colors.blueAccent,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SimulationGpScreen()));
                  },
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.border_color,
                          size: 50, color: Colors.white),
                      title: Text(
                        'GRACE PERIOD',
                        style: cardTextStyle,
                      ),
                      subtitle: Text(''),
                    ),
                  ]),
                )),
            Card(
                color: Colors.redAccent,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SimulationThtScreen()));
                  },
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.border_color,
                        size: 50,
                        color: Colors.white,
                      ),
                      title: Text(
                        'THT',
                        style: cardTextStyle,
                      ),
                      subtitle: Text(''),
                    ),
                  ]),
                )),
            Card(
                color: Colors.amberAccent,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SimulationScreen()));
                  },
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.border_color,
                        size: 50,
                        color: Colors.white,
                      ),
                      title: Text(
                        'REGULAR',
                        style: cardTextStyle,
                      ),
                      subtitle: Text(''),
                    ),
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}
