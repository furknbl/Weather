import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_statu/screens/main_screen.dart';
import 'package:weather_statu/utils/location.dart';
import 'package:weather_statu/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  late LocationHelper locationData;

  Future<void> getLocationData()async{
    locationData=LocationHelper();
    await locationData.getCurrentLocation();

    if(locationData.latitude== null || locationData.longitude== null){
      print("Konum bilgileri yüklenirken hata oluştu");
    }
    else{
      print("Latitude="+locationData.longitude.toString());
      print("Longitude="+locationData.latitude.toString());

    }


  }


  void getWeatherData()async{
    await getLocationData();
    
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();
    
    if(weatherData.currentTemperature==null||weatherData.currentCondition==null){
      print("APIden durum bilgisi gelmedi...");
      
    }
    
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return MainScreen(weatherData: weatherData,);
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple,Colors.blue]
          )
        ),
        child: Center(
          child: SpinKitCubeGrid(
            color: Colors.white,
            size: 150.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
