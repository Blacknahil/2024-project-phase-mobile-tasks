import "dart:js_util";

import "package:flutter/material.dart";

class LearnFlutterPage extends StatefulWidget {
  const LearnFlutterPage({super.key});

  @override
  State<LearnFlutterPage> createState() => _LearnFlutterPageState();
}

class _LearnFlutterPageState extends State<LearnFlutterPage> {
  bool isSwitch = true;
  bool? isCheckbox = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Learn flutter"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {
                debugPrint("Icon info is clicked");
              },
              icon: const Icon(Icons.info),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'images/einstein.jpg',
                height: screenSize.height * 0.5,
                width: screenSize.width,
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.black,
                thickness: 10.0,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(5, 30, 10, 15),
                margin: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                color: Colors.blueAccent,
                child: const Center(
                  child: Text(
                    "This is a text inside a container",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white60,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSwitch ? Colors.green : Colors.blue,
                ),
                child: const Text("Elevated Button"),
                onPressed: () {
                  debugPrint("Elevated Button");
                },
              ),
              OutlinedButton(
                child: const Text("Outlined Button"),
                onPressed: () {
                  debugPrint("Outlined Button");
                },
              ),
              TextButton(
                child: const Text("Text Button"),
                onPressed: () {
                  debugPrint("Text Button");
                },
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  debugPrint("This is the row you clicked");
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.fire_extinguisher,
                      color: Colors.blueAccent,
                    ),
                    Text("Row Widget"),
                    Icon(
                      Icons.fire_extinguisher,
                      color: Colors.blueAccent,
                    )
                  ],
                ),
              ),
              Switch(
                value: isSwitch,
                onChanged: (bool newBool) {
                  setState(() {
                    isSwitch = newBool;
                  });
                },
              ),
              Checkbox(
                value: isCheckbox,
                onChanged: (bool? newBool) {
                  setState(() {
                    isCheckbox = newBool;
                  });
                },
              ),
              Image.network(
                  'https://grupa.it/sites/default/files/2023-10/einstein-8041625_1280.png')
            ],
          ),
        ));
  }
}
