import 'package:location/location.dart';
class LocationHelper{
  late double latitude;
  late double longitude;


  Future<void> getCurrentLocation()async{
    Location location = Location();

    bool _serviceEnable;
    PermissionStatus _permissonGranted;
    LocationData _locationData;
    _serviceEnable=await location.serviceEnabled();
    if(!_serviceEnable){
      _serviceEnable = await location.requestService();
      if(!_serviceEnable){
        return;
      }
    }

    _permissonGranted = await location.hasPermission();
    if(_permissonGranted== PermissionStatus.denied) {
      _permissonGranted = await location.requestPermission();
    }
    if(_permissonGranted!=PermissionStatus.granted){
      return;

    }

    _locationData=await location.getLocation();
    latitude=_locationData.latitude!;
    longitude=_locationData.longitude!;
  }

}