import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 245, 190, 38)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Rossman Week 7'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pageFirstLoad = true;
  bool isLoadingItemsFromDB = false;

  List<Item> items = [
    Item('Chapstick', 100, 'Beauty'),
    Item('Nail Polish', 101, 'Beauty'),
    Item('Pen', 102, 'Office'),
    Item('USB Drive', 103, 'Electronics'),
    Item('Headphones', 104, 'Electronics'),
    Item('Thumbtacs', 105, 'Office'),
    Item('Notebook', 106, 'Office'),
    Item('Record Player', 107, 'Electronics'),
    Item('TV', 108, 'Electronics'),
    Item('Toy Car', 109, 'Toys'),
  ];

  void _handleButtonPress(){
    setState(() {
      pageFirstLoad = false;
      isLoadingItemsFromDB = true;
    });

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoadingItemsFromDB = false;
      });
    });
  }

  void _handleClear(){
    setState(() {
      pageFirstLoad = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: pageFirstLoad ? 
        ElevatedButton(
          onPressed: _handleButtonPress,
          child: Text("Load Items From Database"),
        )
        : isLoadingItemsFromDB ? const Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Please wait")
          ],
        )
        : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: items.map((item) {
              return Padding(padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Text('${item.ItemName}', style: TextStyle(fontSize: 20),), 
                  Text('ID: ${item.ItemID}'), 
                  Text('Item Description: ${item.Description}'),
                  Divider(),
                ],
              ),
            );
          },).toList(),
          ),
        ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            if(!pageFirstLoad && !isLoadingItemsFromDB)
            FloatingActionButton(
              onPressed: _handleClear,
              tooltip: 'Clear Items',
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
      );
  }
}

class Item {
  String ItemName;
  int ItemID;
  String Description;

  Item(this.ItemName, this.ItemID, this.Description);
}