import 'dart:io';

import 'package:flutter/material.dart';
import 'package:github_poc/scripts/localize.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final folder = Directory("git_repo");

                  final result = await Process.start('git', [
                    'clone',
                    'git@github.com:milan-zezelj-greenstate/github_poc_repo.git',
                    'git_repo'
                  ]);
                  final exitCode = await result.exitCode;
                  // print(exitCode);

                  final file = File("git_repo/example.json");
                  // print(await file.readAsString());

                  await file.copy("assets/example.json");

                  localize(jsonFilePath: "assets/example.json");
                },
                child: const Text("Clone and translate"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final process = await Process.start(
                    "./push.sh",
                    [],
                    runInShell: true,
                  );

                  process.stderr.forEach((element) => print(
                        "ERROR: ${String.fromCharCodes(element)}",
                      ));
                  process.stdout.forEach((element) => print(
                        String.fromCharCodes(element),
                      ));
                },
                child: const Text("Push changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
