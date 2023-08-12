import 'dart:convert';

import 'dart:io';
import 'package:flutter/foundation.dart';

import 'styling.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/next_page': (context) => const NextPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
        //scaffoldBackgroundColor: Color(0x9a03a7bc)
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Res response = Res();
  TextEditingController contextController = TextEditingController();
  TextEditingController questionController = TextEditingController();

  void callAPI(String question, String context) async {
    response = await contactWtihAPI(question, context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.0,
              colors: [Colors.blue, Color.fromARGB(255, 5, 231, 182)])),
      child: Scaffold(
        // By default, Scaffold background is white
        // Set its value to transparent
        backgroundColor: const Color(0x00000000),
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: const Text(
            "{ContextBoT}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.amber,
                fontFamily: 'ChivoMono'),
          ),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const WelcomeText(text: 'Welcome to ContextBoT!'),
              const SizedBox(height: 50),
              SizedBox(
                width: 600,
                child: TextFormField(
                  controller: contextController,
                  decoration: InputDecoration(
                    labelText: "Context",
                    labelStyle: const TextStyle(
                        fontFamily: 'Pacifico',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 43, 2, 66)),
                    hintText: "Enter some text here...",
                    hintStyle: const TextStyle(
                        fontStyle: FontStyle.italic, fontFamily: 'ChivoMono'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  minLines: 1,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 500,
                child: TextFormField(
                  controller: questionController,
                  decoration: InputDecoration(
                    labelText: "Question",
                    labelStyle: const TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000)),
                    hintText: "Ask a question here...",
                    hintStyle: const TextStyle(
                        fontStyle: FontStyle.italic, fontFamily: 'ChivoMono'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  callAPI(
                    questionController.value.text,
                    contextController.value.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    'Get Answer',
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'PTSerif-Regular'),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              response.answer != null
                  ? Text(
                      "\"${response.answer}\"",
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'PTSerif-Regular'),
                      textAlign: TextAlign.center,
                    )
                  : Container(),
              const SizedBox(height: 50),
              const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "© 2023 ContextBot Developers",
                    style: TextStyle(
                      fontFamily: 'PTSerif-Regular',
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          // color of the shadow
                          color: Color.fromARGB(255, 255, 238, 1),
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/next_page');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    child: const Text(
                      'About us',
                      style: TextStyle(
                          fontSize: 20, fontFamily: 'PTSerif-Regular'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.green])),
      child: Scaffold(
        // By default, Scaffold background is white
        // Set its value to transparent
        backgroundColor: const Color(0x00000000),
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: const Text('Developer Team'),
          //titleTextStyle: TextStyle(fontFamily: ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDeveloperTile(
                'Ashutosh Choudhary',
                '19U02004',
                'assets/images/Photograph.jpeg',
              ),
              const SizedBox(height: 20),
              _buildDeveloperTile(
                'Ankit Agrawal',
                '19U02052',
                'assets/images/ankit.jpg', // pass null if no image is available
              ),
              const SizedBox(height: 20),
              _buildDeveloperTile(
                'Shyam Chandra',
                '19U02063',
                'assets/images/shyam.jpeg', // pass null if no image is available
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 50,
          color: Colors.black45,
          child: const Center(
            child: Text(
              'Thank you for using ContextBoT!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ChivoMono'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeveloperTile(
    String name,
    String id,
    String? imagePath,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (imagePath != null)
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 30,
            )
          else
            const SizedBox(width: 60, height: 60),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  id,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<Res> contactWtihAPI(String question, String context) async {
  String body =
      "{\"inputs\": {\"question\": \"$question\",\"context\": \"$context\"}}";

  final response = await http.post(
    Uri.parse(
        "https://api-inference.huggingface.co/models/distilbert-base-cased-distilled-squad"),
    headers: {
      HttpHeaders.authorizationHeader:
          "Bearer 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"
    },
    body: body,
  );

  Res res = Res.fromJson(jsonDecode(response.body));
  if (kDebugMode) {
    print(res.answer);
  }
  return res;
}

class Res {
  double? score;
  int? start;
  int? end;
  String? answer;
  Res({this.score, this.start, this.end, this.answer});
  Res.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    start = json['start'];
    end = json['end'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['score'] - score;
    data['start'] = start;
    data['end'] - end;
    data['answer'] = answer;
    return data;
  }
}
