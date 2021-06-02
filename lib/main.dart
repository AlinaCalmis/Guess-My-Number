import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const GuessNumber());

class GuessNumber extends StatefulWidget {
  const GuessNumber({Key? key}) : super(key: key);

  @override
  _GuessNumberState createState() => _GuessNumberState();
}

class _GuessNumberState extends State<GuessNumber> {
  final TextEditingController _controller = TextEditingController();
  static Random random = Random();
  int randomized = random.nextInt(100) + 1;
  int _readValue = 0;
  String _text = '';
  String _try = 'higher';

  // generates Dialog Alert pop up window
  void getAlert(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('You guessed right'),
        content: Text('It was $_readValue'),
        contentPadding: const EdgeInsets.all(100.0),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                setState(() {
                  randomized = random.nextInt(100) + 1;
                  _text = '';
                });
                Navigator.pop(context);
              },
              child: const Text('Try again!')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Guess my number'),
          ),
        ),
        body: Builder(
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                const Center(
                  child: Text(
                    "I'm thinking of a number between 1 and 100.",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "It's your turn to guess my number!",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                const SizedBox(height: 10),
                Text(_text,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 40.0),
                    textAlign: TextAlign.center),
                Container(
                  height: 190.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Try a number!',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Form(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextField(
                              controller: _controller,
                              cursorHeight: 30,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black12),
                          ),
                          onPressed: () {
                            _readValue = int.tryParse(_controller.text)!;

                            if (_readValue != randomized) {
                              if (_readValue > randomized) {
                                _try = 'lower';
                              } else {
                                _try = 'higher';
                              }
                              _text = 'You tried $_readValue.\nTry $_try';
                            } else {
                              _text =
                                  'You tried $_readValue.\nYou guessed right.';
                              getAlert(context);
                            }
                          },
                          child: const Text('Guess')),
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
