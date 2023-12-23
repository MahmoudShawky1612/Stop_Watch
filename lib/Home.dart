import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Declare Variables
  int seconds = 0;int minutes = 0;  int hours = 0;
  String digitseconds = "00";String digitminutes = "00";String digithours = "00";
  bool isActive = false;
  Timer? timer;
  List laps= [];

  // Start Function

  void _stop(){
    setState(() {
      timer!.cancel();

      isActive = false;
    });
  }

  // reset Function
  void _reset(){
    setState(() {
      timer!.cancel();
      isActive = false;
      seconds = 0;
      minutes = 0;
      hours = 0;
      laps.clear();
      digitseconds = "00";
      digitminutes = "00";
      digithours = "00";
    });
  }

  //add lap function
  void _addlap(){
    String currentlap = "${digithours}:${digitminutes}:${digitseconds}";
    setState(() {
      laps.add(currentlap);
    });
  }

  // Start Function
  void _start(){
    isActive = true;
    timer = Timer.periodic(Duration(seconds:1),(timer){
      int localSeconds = seconds+1;
      int localMinutes = minutes;
      int localHours = hours;

      if(localSeconds>59){
        if(localMinutes>59){
          localHours++;
          localMinutes = 0;
      }
        else{
          localMinutes++;
          localSeconds = 0;
        }

      }

      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitseconds= (seconds>=10)? "${seconds}":"0${seconds}";
        digitminutes= (minutes>=10)? "${minutes}":"0${minutes}";
        digithours= (hours>=10)? "${hours}":"0${hours}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Center(
                child: Text(
                  "Stop Watch",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

              ),
              SizedBox(height: 30,),
              Center(
                child: Text(
                  "${digithours}:${digitminutes}:${digitseconds}",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

              ),

              Container(
                height: 400,

                decoration: BoxDecoration(
                  color: Color(0xF6ECECE6),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius:10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                //list builder
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: Text("Lap ${index+1}", style: TextStyle (fontSize: 15, fontWeight: FontWeight.bold,color: Colors.blue),),
                      trailing: Text(laps[index], style: TextStyle (fontSize: 15,fontWeight: FontWeight.bold)),
                    );
                  },
                ),
              ),
              SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: MaterialButton(onPressed: (){
                        (!isActive)?_start():_stop();
                      },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                          side: BorderSide(color: Colors.blue),
                        ),
                        child: Text((!isActive)?"Start":"Pause"),
                        color: Colors.white,


                      )),
                  SizedBox(width: 5),
                  IconButton(onPressed: (){_addlap(); }, icon: Icon(Icons.flag), color: Colors.red),
                  Expanded(
                      child: MaterialButton(onPressed: (){
                          _reset();
                      },

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                          side: BorderSide(color: Colors.blue),

                        ),

                        child: Text("Reset", style: TextStyle(color: Colors.white)),
                        color: Colors.blue,

                      )),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
