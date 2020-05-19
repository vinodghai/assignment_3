import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(home: MainScreen());
}

//This is the main screen widget which will create its layout based on screen orientation.
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //MediaQuery is used to detect the orientation of the device
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    //Scaffold widget provides the Navigation Drawer
    return Scaffold(
      appBar: AppBar(title: Text("Week 3 Assignment")),
      //If is not isLandscape then show drawer otherwise don't
      drawer: isLandscape ? null : Drawer(child: NavigationList()),
      body:
          isLandscape //isLandscape is used to decide which layout should be used in the body of Scaffold
              ? _buildWideScreenLayout()
              : _buildSingleColumnLayout(),
    );
  }

  //_buildWideScreenLayout will lay out NavigationList and UserDetails at the same time inside a Row widget
  Widget _buildWideScreenLayout() => Row(
        children: <Widget>[
          Expanded(child: NavigationList()),
          Expanded(child: UserDetails(), flex: 2)
        ],
      );

  Widget _buildSingleColumnLayout() => UserDetails();
}

class NavigationList extends StatelessWidget {
  //A list is created using ListView.builder and returned from build method
  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: 7,
      itemBuilder: (context, position) =>
          _buildRow(context, "List item ${(position + 1).toString()}"));

  //_buildRow creates a layout for a single row of list
  Widget _buildRow(BuildContext context, String content) => Padding(
      padding: EdgeInsets.all(6.0),
      child: Card(
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(content, style: TextStyle(fontSize: 22)))));
}

class UserDetails extends StatelessWidget {
  //LayoutBuilder will give the constraints exclusive of NavigationList size in wide screen, so scaling Avatar doesn't go oversize (which can be with MediaQuery)
  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        // isWidthGreater will help us to find the shorter direction (height or width), so we can expand Avatar in that shorter direction.
        var isWidthGreater = constraints.maxWidth > constraints.maxHeight;
        var scaleFactor = 0.75;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: isWidthGreater
                      ? constraints.maxHeight * scaleFactor
                      : null,
                  width: isWidthGreater
                      ? null
                      : constraints.maxWidth * scaleFactor,
                  child: FittedBox(
                      child: CircleAvatar(child: Icon(Icons.person)))),
              SizedBox(height: 12.0),
              Container(
                  width: constraints.maxWidth * 0.25,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: Text(
                        "VentureDive",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Colors.blue))
            ],
          ),
        );
      });
}
