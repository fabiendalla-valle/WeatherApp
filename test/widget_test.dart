// This line imports the extension
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main.dart';

String _titleCoords="";
String _city="";
String _country="";
String _lat="";
String _lon="";
String _title=_city+", "+_country;


//SHORTCUT TO CHANGE PARAMETERS EASILY
const _padding = EdgeInsets.all(12.0);
final _backgroundFieldCity = Colors.blue[300];
final _backgroundFieldCoords = Colors.blue[200];


void main() {
  testWidgets('my test widget test', (WidgetTester tester) async {
    // You can use keys to locate the widget you need to test
    var sliderKey = UniqueKey();
    var value = 0.0;
  
    // Tells the tester to build a UI based on the widget tree passed to it
    await tester.pumpWidget(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MaterialApp(
            home: Material(
              child: Center(
                child: Slider(
                  key: sliderKey,
                  value: value,
                  onChanged: (double newValue) {
                    setState(() {
                      value = newValue;
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );

    expect(value, equals(0.0));

    // Taps on the widget found by key
    await tester.tap(find.byKey(sliderKey));

    // Verifies that the widget updated the value correctly
    expect(value, equals(0.5));

   // expect(_navigateToWeatherCoords, Scaffold);
  });

  test('initial value test', () {
    expect(_title, _city+", "+_country);
  });

  testWidgets('City Field test', (WidgetTester tester) async {
    Key inputKey = new UniqueKey();
    String value;

    await tester.pumpWidget(StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MaterialApp(
            home: Material(
              child: new Padding(
                padding: _padding,
                child: TextFormField(
                key: inputKey,
                decoration: new InputDecoration(
                fillColor: _backgroundFieldCity,
                
                filled: true,
                contentPadding: new EdgeInsets.fromLTRB(
                    10.0, 30.0, 10.0, 10.0),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(12.0),
                ),
                labelText: 'City'
                ),

                onSaved: (String str){
                  _city=str[0].toUpperCase()+str.substring(1).toLowerCase();
                  _title=_city+", "+_country;
                },
              )
            ),
            )
          );
        }
    ));

    await tester.tap(find.text("City"));

    //Test value changed
    TextFormField f = tester.widget(find.byKey(inputKey));
    f.onSaved("PaRis");
    //print('$_city');
    expect(_city, "Paris");
});


testWidgets('Country code Field test', (WidgetTester tester) async {
    Key inputKey = new UniqueKey();
    String value;
    await tester.pumpWidget(StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MaterialApp(
            home: Material(
              child: new Padding(
              padding: _padding,
                child: TextFormField(
                  key: inputKey,
                  decoration: new InputDecoration(
                      fillColor: _backgroundFieldCity,
                      filled: true,
                      contentPadding: new EdgeInsets.fromLTRB(
                          10.0, 30.0, 10.0, 10.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(12.0),
                      ),
                      labelText: 'Country Code'),
                  onSaved: (String str){
                    _country=str.toUpperCase();
                    _title=_city+", "+_country;
                  },
              )
            ),
            )
          );
        }
    ));

    await tester.tap(find.text("Country Code"));

    //Test value changed
    TextFormField f = tester.widget(find.byKey(inputKey));
    f.onSaved("Fr");
    //print('$_country');
    expect(_country, "FR");
});

testWidgets('Latitude Field test', (WidgetTester tester) async {
    Key inputKey = new UniqueKey();
    String value;
    await tester.pumpWidget(StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MaterialApp(
            home: Material(
              child: new Padding(
              padding: _padding,
              child:TextField(
              keyboardType: TextInputType.number,
              key: inputKey,
              decoration: new InputDecoration(
                  fillColor: _backgroundFieldCoords,
                  filled: true,
                  contentPadding: new EdgeInsets.fromLTRB(
                      10.0, 30.0, 10.0, 10.0),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                  ),
                  labelText: 'Latitude'),
              onChanged: (String str){
              _lat=str;
              _titleCoords="Lat "+_lat+" Lon "+_lon;
              },
            )
            ),
            )
          );
        }
    ));

    await tester.tap(find.text("Latitude"));

    //Test value changed
    await tester.enterText(find.byKey(inputKey), "123");
    //print('$_lat');
    expect(_lat, "123");
    TextField f = tester.widget(find.byKey(inputKey));
    f.onChanged("15");
    //print('$_lat');
    expect(_lat, "15");

});

testWidgets('Longitude Field test', (WidgetTester tester) async {
    Key inputKey = new UniqueKey();
    String value;

    await tester.pumpWidget(StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MaterialApp(
            home: Material(
              child: new Padding(
              padding: _padding,
              child:TextField(
              key: inputKey,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                  fillColor: _backgroundFieldCoords,
                  filled: true,
                  contentPadding: new EdgeInsets.fromLTRB(
                      10.0, 30.0, 10.0, 10.0),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                  ),
                  labelText: 'Longitude'),
              onChanged: (String str){
              _lon=str;
              _titleCoords="Lat "+_lat+" Lon "+_lon;
              },
            )
            ),
            )
          );
        }
    ));

    await tester.tap(find.text("Longitude"));

    //Test value changed
    await tester.enterText(find.byKey(inputKey), "123");
    expect(_lon, "123");
    TextField f = tester.widget(find.byKey(inputKey));
    f.onChanged("15");
    expect(_lon, "15");

});

testWidgets('Unit test', (WidgetTester tester) async {
    Key inputKey = new UniqueKey();
    String value;
    await tester.pumpWidget(StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MaterialApp(
            home: Material(
              child: new Padding(
                padding: EdgeInsets.all(20.0) ,
                child: Center(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(7.0),
                            child:  Text("  F° ", style: TextStyle(color: Colors.lightBlue[900],fontSize: 30.0,),),
                          ),
                          Container(
                            key: inputKey,
                            child : SliderItem(true,null)
                          ),
                          Container(
                            padding: EdgeInsets.all(5.0),
                            child:  Text("  C° ", style: TextStyle(color: Colors.blue[900],fontSize: 30.0,),),
                          )
                        ],
                      )
                  ),
              )
            )
          );
        }
    ));
    //Test state changed
    Container f = tester.widget(find.byKey(inputKey));
    print('$f');
});

}