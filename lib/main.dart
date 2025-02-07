import 'package:flutter/material.dart';
import 'package:waether_apl/second.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IstPage()
    );
  }
}
class IstPage extends StatelessWidget {
  final TextEditingController loc=TextEditingController();
  IstPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.blue,),
      body: Column(
      children: [
        Padding(padding: EdgeInsets.fromLTRB(15,50,15,15),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter location name',
            labelText: 'Name of place'
          ),
          controller: loc,
        ),
        ),
        ElevatedButton(onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>SecondPage(location: loc.text))
          );
        }, child: Text('press'))
      ],
                ),
    );
  }
}