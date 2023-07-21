import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late List<_ChartData> dough_nut_data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    dough_nut_data = [
      _ChartData('David', 25),
      _ChartData('Steve', 38),
      _ChartData('Jack', 34),
      _ChartData('Others', 52)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(DateTime(2010), 35),
      SalesData(DateTime(2011), 28),
      SalesData(DateTime(2012), 34),
      SalesData(DateTime(2013), 32),
      SalesData(DateTime(2014), 40)
    ];
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SfCartesianChart(primaryXAxis: DateTimeAxis(), series: <ChartSeries>[
            // Renders line chart
            LineSeries<SalesData, DateTime>(
              dataSource: chartData,
              xValueMapper: (SalesData sale, _) => sale.year,
              yValueMapper: (SalesData sale, _) => sale.sales,
            ),
          ]),
          SfCircularChart(tooltipBehavior: _tooltip, annotations: [
            CircularChartAnnotation(
                angle: 30,
                radius: '100%',
                widget: const Text(
                  'a%',
                  style: TextStyle(color: Color.fromARGB(255, 56, 163, 154)),
                )),
            CircularChartAnnotation(
                angle: 110,
                radius: '100%',
                widget: const Text(
                  'b%',
                  style: TextStyle(color: Color.fromARGB(255, 56, 163, 154)),
                )),
            CircularChartAnnotation(
                angle: 210,
                radius: '100%',
                widget: const Text(
                  'c%',
                  style: TextStyle(color: Color.fromARGB(255, 56, 163, 154)),
                )),
            CircularChartAnnotation(
                angle: 315,
                radius: '100%',
                widget: const Text(
                  'd%',
                  style: TextStyle(color: Color.fromARGB(255, 56, 163, 154)),
                )),
          ], series: <CircularSeries<_ChartData, String>>[
            DoughnutSeries<_ChartData, String>(
                dataSource: dough_nut_data,
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                name: 'Gold')
          ])
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}
