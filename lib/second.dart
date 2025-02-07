import 'package:intl/intl.dart';
import 'package:waether_apl/wheather_api.dart';
import 'package:weather/weather.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  
 
  String location;
  SecondPage({super.key,required this.location});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  WeatherFactory wf=WeatherFactory(OPENWHEATHER_API);
  Weather? w;

  void fun()async{
     await wf.currentWeatherByCityName(widget.location).then((a){
      setState(() {
        w=a;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   fun();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  Colors.white,
        
        body: SingleChildScrollView(child: UI()),
      ),
    );
  }
  

  Widget UI(){
    if (w==null) {
      return Center(child: CircularProgressIndicator(),);
    }
    else{
      return SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
           locationName(),
           SizedBox(height: 20,),
           dateTimeInfo(),
           weatherIcon(),
           temp(),
           ExtraInfo(),
          ],
        ),
      );
    }
  }

  Widget locationName(){
    return Text(w!.areaName??"",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),);
  }
  Widget dateTimeInfo(){
    DateTime now=w!.date!;
    
    return Column(
      children: [
        Text(DateFormat('hh:mm a').format(now),style: TextStyle(fontSize: 30)),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat('EEEE').format(now)),
            SizedBox(width: 20,),
            Text(DateFormat('dd.mm.yyyy').format(now)),
           
          ],
        ),
      ],
    );
  }
  Widget weatherIcon(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Image(image: NetworkImage('http://openweathermap.org/img/wn/${w!.weatherIcon}@4x.png')),
        ),
        Text(w!.weatherDescription!)
      ],
    );
  }
  Widget temp(){
    return Text(w!.temperature!.celsius!.toStringAsFixed(0)+'° C',style: TextStyle(fontSize: 35),);
  }
  Widget ExtraInfo(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,30,0,0),
      child: Container(
        width: 300,height: 120,
      
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.all(Radius.circular(20)) 
        ),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(" Max: "+w!.tempMax.toString(),style: TextStyle(color: Colors.white),),
      
                Text("Min: "+w!.tempMin.toString(),style: TextStyle(color: Colors.white),),
              ],
            ),
            SizedBox(height: 20,),
             Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(" Max: "+w!.windSpeed.toString()+"m/s",style: TextStyle(color: Colors.white),),
      
                Text(" Min: "+w!.humidity.toString()+"%",style: TextStyle(color: Colors.white),),
              ],
            )
          ],
        ),
      ),
    );
  }
}