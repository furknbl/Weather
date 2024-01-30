import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'location.dart';
import 'package:flutter/cupertino.dart';

const apiKey="40196c063b973f13544a9ea732bf87e4";

class WeatherDisplayData{
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData{

  WeatherData ({required this.locationData});
  LocationHelper locationData;
  late double currentTemperature;
  late int currentCondition;


  Future<void>getCurrentTemperature()async{
    Response response= await get("https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric" as Uri);

    if(response.statusCode==200){
      String data = response.body;

      var currentWeather =jsonDecode(data);

      try{
        currentTemperature= currentWeather["main"]["temp"];
        currentCondition = currentWeather["weather"][0]["id"];

      }catch(e){
        print(e);
      }

    }
    else{
      print("APIden değer gelmiyor...");
    }
  }

  WeatherDisplayData getWeatherDisplayData(){
    if(currentCondition<600){
      return WeatherDisplayData(weatherIcon: Icon(
        FontAwesomeIcons.cloud,
        size: 75.0,
        color: Colors.white,

      ),
      weatherImage: AssetImage("assets/bulutlu.jpeg")
      );


    }
    else{
      var now = new DateTime.now();
      if(now.hour>=19){
        return WeatherDisplayData(weatherIcon: Icon(
          FontAwesomeIcons.moon,
          size: 75.0,
          color: Colors.white,

        ),
            weatherImage: AssetImage("assets/gece.jpg")
        );

      }
      else{
        return WeatherDisplayData(weatherIcon: Icon(
          FontAwesomeIcons.sun,
          size: 75.0,
          color: Colors.white,

        ),
            weatherImage: AssetImage("assets/günesli.jpg")
        );
      }
    }
  }
}