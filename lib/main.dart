/**
 * Title : Weather_app
 * Author : F. DALLA-VALLE
 * file : main.dart
 */

import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_repo.dart';
import 'package:weather_app/model/model_command.dart';
import 'package:weather_app/model/model.dart';
import 'package:weather_app/model/model_provider.dart';
import 'package:rx_widgets/rx_widgets.dart';
import 'package:http/http.dart' as http;

void main() {
  final repo = WeatherRepo(client: http.Client());
  final modelCommand = ModelCommand(repo);
  runApp(
    ModelProvider(
      child: MyApp(),
      modelCommand: modelCommand,
    ),
  );
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Weather',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.deepOrange,

      ),
      home: new MyHomePage(title: 'Weather Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text('What the weather like today ?'),
        actions: <Widget>[

          PopupMenuButton<int>(
            padding: EdgeInsets.all(1.0),
            tooltip: "Select how much day you want",
            onSelected: (int item){
              if(item != null){
                ModelProvider.of(context).addDayCommand(item);
              }
            },
            itemBuilder: (context){
              return listDays
                  .map((number)=>PopupMenuItem(
                value: number,
                child: Center(
                  child: Text(number.toString()),
                ),
              )).toList();
            },
          )
        ],
      ),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[

            new TextFormField(
              decoration: new InputDecoration(
              fillColor: Colors.orange,
              filled: true,
              contentPadding: new EdgeInsets.fromLTRB(
                  10.0, 30.0, 10.0, 10.0),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(12.0),
              ),
              labelText: 'City'),

              onFieldSubmitted: (String str){
                ModelProvider.of(context).addCityCommand(str);
              },
            ),

            new TextFormField(
              decoration: new InputDecoration(
                  fillColor: Colors.orange,
                  filled: true,
                  contentPadding: new EdgeInsets.fromLTRB(
                      10.0, 30.0, 10.0, 10.0),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                  ),
                  labelText: 'Country Code'),
              onFieldSubmitted: (String str){
                ModelProvider.of(context).addCountryCommand(str);
              },
            ),

            new TextFormField(
              decoration: new InputDecoration(
                  fillColor: Colors.orangeAccent,
                  filled: true,
                  contentPadding: new EdgeInsets.fromLTRB(
                      10.0, 30.0, 10.0, 10.0),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                  ),
                  labelText: 'Latitude'),
              onFieldSubmitted: (String str){
              ModelProvider.of(context).addLatCommand(str);
              },
            ),

            new TextFormField(
              decoration: new InputDecoration(
                  fillColor: Colors.orangeAccent,
                  filled: true,
                  contentPadding: new EdgeInsets.fromLTRB(
                      10.0, 30.0, 10.0, 10.0),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                  ),
                  labelText: 'Longitude'

              ),
              onFieldSubmitted: (String str){
                ModelProvider.of(context).addLonCommand(str);
              },
            ),

          Expanded(
            child: RxLoader<List<WeatherModel>>(
              radius: 30.0,
              commandResults: ModelProvider.of(context).updateWeatherCommand,
              dataBuilder: (context,data)=>WeatherList(data),
              placeHolderBuilder: (context)=>Center(child: Text("Please enter a city name and a country code")),
              errorBuilder: (context,exception)=>Center(child: Text("Please complete fields")),

              //errorBuilder: (context,exception)=>Center(child: Text("$exception")),
            ),
          ),

          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: WidgetSelector(
                    buildEvents: ModelProvider
                        .of(context)
                        .updateLocationCommand
                        .canExecute,
                    onTrue: MaterialButton(
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      child: Text("Search",
                      ),
                      onPressed: ModelProvider.of(context).updateWeatherCommand,

                    ),
                    onFalse: MaterialButton(
                      color: Colors.orange,
                      child: Text("Loading"),
                      onPressed: null,
                    ),
                  ),

                ),

                Container(
                    padding: EdgeInsets.only(left:200.0),
                    child:Column(
                      children: <Widget>[
                        SliderItem(true,ModelProvider.of(context).radioCheckedCommand
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child:  Text(" F° / C°"),
                        )
                      ],
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//Class that contains the display settings
class WeatherList extends StatelessWidget{
  final List<WeatherModel> list;
  WeatherList(this.list);
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context,index)=>ListTile(
        leading: Image.network("http://openweathermap.org/img/w/"+list[index].icon.toString()+'.png'),
        title: Container(
          padding: EdgeInsets.all(10.0),
          child: Text(list[index].description),
        ),

        trailing: Container(
          child: Column(
            children: <Widget>[
              Text(list[index].temperature.toStringAsFixed(2)),
            ],
          ),
        ),
      ),
    );
  }
}

//Unit Button Management (F / C)
class SliderItem extends StatefulWidget{
  final bool sliderState;
  final ValueChanged<bool> command;

  SliderItem(this.sliderState, this.command);

  @override
  SliderState createState() => SliderState(sliderState,command);
}
class SliderState extends State<SliderItem>{
  bool sliderState;
  ValueChanged<bool> command;

  SliderState(this.sliderState, this.command);

  @override
  Widget build(BuildContext context){
    return Switch(
      value: sliderState,
      onChanged: (item){
        setState(()=>sliderState=item);
        command(item);
      },
    );
  }
}

//List of possible days (possibility of adding days up to 16)
final List<int> listDays = <int>[1,3,7,10,16];

//TEST
//Unuse
void test(){

  final repo = WeatherRepo(client: http.Client());
  final modelCommand = ModelCommand(repo);

  runApp(new MaterialApp(
    title: 'Navigation Basics',
    home: new FirstScreen(modelCommand),
  ));
}
//Unuse
class FirstScreen extends StatelessWidget {

  final modelCommand;

  FirstScreen(this.modelCommand);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Search Weather'),
        actions: <Widget>[
          PopupMenuButton<int>(
            padding: EdgeInsets.all(1.0),
            tooltip: "Select how much day you want",
            onSelected: (int item){
              if(item != null){
                ModelProvider.of(context).addDayCommand(item);
              }
            },
            itemBuilder: (context){
              return listDays
                  .map((number)=>PopupMenuItem(
                value: number,
                child: Center(
                  child: Text(number.toString()),
                ),
              )).toList();
            },
          )
        ],
      ),
      body: new Container(
          child: new Column(
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(
                      labelText: 'City'
                  ),
                  onFieldSubmitted: (String str){
                    ModelProvider.of(context).addCityCommand(str);
                  },
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                      labelText: 'State or Country'
                  ),
                  onFieldSubmitted: (String str){
                    ModelProvider.of(context).addCountryCommand(str);
                  },
                ),
                new RaisedButton(
                  child: new Text('Search'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new ModelProvider(
                        child: MyApp(),
                        modelCommand: this.modelCommand,
                      )),
                      //resultScreen(),
                    );
                  },
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                      labelText: 'Longitude'
                  ),
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                      labelText: 'Latitude'
                  ),
                ),
                new RaisedButton(
                  child: new Text('Search'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new ModelProvider(
                        child: MyApp(),
                        modelCommand: this.modelCommand,
                      )),
                      //resultScreen(),
                    );
                  },
                ),
              ]
          )

      ),
    );
  }
}
