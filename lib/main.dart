/**
 * Title : Weather_app
 * Author : F. DALLA-VALLE
 * file : main.dart
 */
// This line imports the extension
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_repo.dart';
import 'package:weather_app/model/model_command.dart';
import 'package:weather_app/model/model.dart';
import 'package:weather_app/model/model_provider.dart';
import 'package:rx_widgets/rx_widgets.dart';
import 'package:http/http.dart' as http;

String _title="";
String _titleCoords="";
String _city="";
String _country="";
String _lat="";
String _lon="";

//SHORTCUT TO CHANGE PARAMETERS EASILY
const _padding = EdgeInsets.all(12.0);
final _backgroundColor = Colors.blue[100];
final _backgroundFieldCity = Colors.blue[300];
final _backgroundFieldCoords = Colors.blue[200];
final _backgroundColorAppBar = Colors.blue[900];
final TextEditingController _controller = new TextEditingController();

//List of possible days (possibility of adding days up to 16)
final List<int> listDays = <int>[1,3,7,10,14];

int calc(int num){
  return num*2;
}

void main() {
  final repo = WeatherRepo(client: http.Client());
  final modelCommand = ModelCommand(repo);
  //enableFlutterDriverExtension();

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
        //primarySwatch: Colors.blue[900],

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

  //Second screen for city search result
  void _navigateToWeather(BuildContext context){
    ModelProvider.of(context).updateWeatherCommand.call();
    Navigator.of(context).push(MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return new Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            title: Text(
              "$_title",
              //style: Theme.of(context).textTheme.display1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
            centerTitle: true,
            backgroundColor: _backgroundColorAppBar,
          ),
          body: Container(
            color: _backgroundColor,
            child:Column(
            children:<Widget>[
                Expanded(
                child: RxLoader<List<WeatherModel>>(
                  radius: 30.0,
                  commandResults: ModelProvider.of(context).updateWeatherCommand,
                  dataBuilder: (context,data)=>WeatherList(data),
                  placeHolderBuilder: (context)=>Center(child: Text("Please enter a city name and a country code")),
                  errorBuilder: (context,exception)=>Center(child: Text("Please enter valid fields")),
                  //errorBuilder: (context,exception)=>Center(child: Text("$exception")),
                ),
              ),
            ],
          ), 
          )

          );
      },
  ));
  }

//Second screen for coordinates search result
void _navigateToWeatherCoords(BuildContext context){
    ModelProvider.of(context).updateWeatherCommandCoords.call();
    print("avant affichage $_titleCoords");
    Navigator.of(context).push(MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return new Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            title: Text(
              "$_titleCoords",
              //style: Theme.of(context).textTheme.display1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
            centerTitle: true,
            backgroundColor: _backgroundColorAppBar,
          ),
          body: Container(
           color: _backgroundColor,
           child: Column(
            children:<Widget>[
                Expanded(
                child: RxLoader<List<WeatherModel>>(
                  radius: 30.0,
                  commandResults: ModelProvider.of(context).updateWeatherCommandCoords,
                  dataBuilder: (context,data)=>WeatherList(data),
                  placeHolderBuilder: (context)=>Center(child: Text("Please enter a latitude and a longitude")),
                  errorBuilder: (context,exception)=>Center(child: Text("Please enter valid coordinates")),
                  //errorBuilder: (context,exception)=>Center(child: Text("$exception")),
                ),
              ),
            ],
          )
          ),
          );
      },
  ));
}

  @override
   Widget build(BuildContext context) {
    //Home page
    return new Scaffold(

      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text('What the weather like ?'),
        backgroundColor: _backgroundColorAppBar,
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

      body: Container(
        color: _backgroundColor,
        child: Column(
        
        children: <Widget>[

          //City search group
          new Padding(
          padding: EdgeInsets.all(20.0),
          child : Column(
            children: <Widget>[

            new Padding(
              padding: _padding,
              child: TextFormField(
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

              onFieldSubmitted: (String str){
                _city=str[0].toUpperCase()+str.substring(1).toLowerCase();
                _title=_city+", "+_country;
                ModelProvider.of(context).addCityCommand(str);
              },
            )
            ),

            new Padding(
              padding: _padding,
              child: TextFormField(
              decoration: new InputDecoration(
                  fillColor: _backgroundFieldCity,
                  filled: true,
                  contentPadding: new EdgeInsets.fromLTRB(
                      10.0, 30.0, 10.0, 10.0),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                  ),
                  labelText: 'Country Code'),
              onFieldSubmitted: (String str){
                _country=str.toUpperCase();
                _title=_city+", "+_country;
                print("$_title");
                ModelProvider.of(context).addCountryCommand(str);
              },
            )
            ),

            new Center(
                    child: WidgetSelector(
                    buildEvents: ModelProvider
                        .of(context)
                        .updateLocationCommand
                        .canExecute,
                    onTrue: MaterialButton(
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                      child: Icon(Icons.search,size: 40.0),
                      onPressed:(){
                        _navigateToWeather(context);
                      }  

                    ),
                    onFalse: MaterialButton(
                      color: Colors.grey,
                      child: Text("Loading"),
                      onPressed: null,
                    ),
                  ),
              ), 
            ],
          ),
        ),

        //Coordinate search group
        new Padding(
          padding: EdgeInsets.all(20.0),
            child : Column(
                children: <Widget>[
                    Padding(
              padding: _padding,
              child:TextField(
              keyboardType: TextInputType.number,
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
              ModelProvider.of(context).addLatCommand(str);
              },
            )
            ),

            new Padding(
              padding: _padding,
              child:TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                  fillColor: _backgroundFieldCoords,
                  filled: true,
                  contentPadding: new EdgeInsets.fromLTRB(
                      10.0, 30.0, 10.0, 10.0),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                  ),
                  labelText: 'Longitude'
              ),
              onChanged: (String str){
              _lon=str;
              _titleCoords="Lat "+_lat+" Lon "+_lon;
                ModelProvider.of(context).addLonCommand(str);
              }
            )
            ),

            new Center(
                    child: WidgetSelector(
                    buildEvents: ModelProvider.of(context).updateLocationCommand.canExecute,
                    onTrue: MaterialButton(
                      color: Colors.lightBlue[300],
                      textColor: Colors.white,
                      child: Icon(Icons.search,size: 40.0),
                      onPressed:(){
                        _navigateToWeatherCoords(context);
                      }
                    ),
                    onFalse: MaterialButton(
                      color: Colors.grey,
                      child: Text("Loading"),
                      onPressed: null,
                    ),
                  ),
                  
            ),

        ],
        ),
        ),    
            
        //Unit group
        Padding(
          padding: EdgeInsets.all(20.0) ,
          child: Center(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(7.0),
                      child:  Text("  F° ", style: TextStyle(color: Colors.lightBlue[900],fontSize: 30.0,),),
                    ),
                    SliderItem(true,ModelProvider.of(context).radioCheckedCommand
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child:  Text("  C° ", style: TextStyle(color: Colors.blue[900],fontSize: 30.0,),),
                    )
                  ],
                )
            ),
        )
        ],
      ),
      )
    );
  }
}

//Class that contains the display settings for the result screen
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
              Text(list[index].temperature.toInt().toString()),
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



