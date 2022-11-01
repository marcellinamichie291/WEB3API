import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'api_calls.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WandyApi Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'WandyApi Flutter Demo V0.50'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String seedsPhrase = '';
  String walletAddress = '';
  double balance = 0.0;

  Future<void> _incrementCounter() async {
      seedsPhrase ='vivid lava apple exotic reform clap pioneer blind uncle lawsuit drop label'; //bip39.generateMnemonic();
      print(seedsPhrase);
      walletAddress = await createWallet(0, seedsPhrase);
      balance = await getBalance(0,seedsPhrase, Solana.tokenAddress);
      balance = balance / pow(10, Solana.decimals);
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$walletAddress ${Solana.name} $balance',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}