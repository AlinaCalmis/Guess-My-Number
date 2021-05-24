import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() =>  runApp(GuessNumber());

class GuessNumber extends StatefulWidget {
  const GuessNumber({Key key}) : super(key: key);

  @override
  _GuessNumberState createState() => _GuessNumberState();
}

class _GuessNumberState extends State<GuessNumber> {
  TextEditingController _controller = new TextEditingController();
  static Random random = new Random();
  int randomized = random.nextInt(100) + 1;
  int _readValue = 0;
  String _text = "";
  String _try = "higher";

  // generates Dialog Alert pop up window
  void getAlert(BuildContext context) {

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("You guessed right"),
          content: Text("It was $_readValue"),
          contentPadding: EdgeInsets.all(100.0),
          actions: <Widget>[
            new TextButton(
                onPressed: (){
                  setState(() {
                    randomized = random.nextInt(100) + 1;
                    _text = "";
                  });
                  Navigator.pop(context);
                },
                child: Text("Try again!")
            ),
            new TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Ok")
            )
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold (
        appBar: AppBar(
          title: Center(
            child: Text(
              "Guess my number"
            ),
          ),
        ),
        body: Builder(builder: (context) => Padding(
            padding:  EdgeInsets.all(10.0),
            child : Column(
              children: <Widget>[
                new Center(
                  child: Text(
                    "I'm thinking of a number between 1 and 100.",
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                ),
                new SizedBox(height: 10),
                new Center(
                  child: Text(
                    "It's your turn to guess my number!",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                new SizedBox(height: 10),
                new Text(_text, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 40.0),textAlign: TextAlign.center),
                new Container(
                  height: 190.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child : new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new SizedBox(height: 10,),
                      new Text("Try a number!",
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      new SizedBox(height: 10),
                      new Center(
                        child: Form(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: TextField(
                              controller: _controller,
                              cursorHeight: 30,
                              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                            ),
                          ),
                        ),
                      ),
                      new TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.black12),
                          ),
                          onPressed: (){
                            setState() {

                              _readValue = int.tryParse(_controller.text);

                              if (_readValue != randomized){
                                if (_readValue > randomized) {
                                  _try = "lower";
                                } else {
                                  _try = "higher";
                                }
                                _text = "You tried $_readValue.\nTry $_try";
                              } else {
                                _text = "You tried $_readValue.\nYou guessed right.";
                                getAlert(context);
                              }
                            };
                          },
                          child: Text("Guess")
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
