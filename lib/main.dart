import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'LandingPage/splash.dart';

/*void main() {
  runApp(const MyApp());
}*/

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  // await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform
  // );
  await FirebaseMessagingApi().initNotifications();
  WidgetsFlutterBinding.ensureInitialized(); */// Ensures everything is initialized before running the app

  // Request multiple permissions at once
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.locationWhenInUse,
    // Permission.microphone,  // Example of another permission
  ].request();

  // Check the statuses of each permission
  if (statuses[Permission.camera]!.isDenied) {
    await _handleDeniedPermission(Permission.camera, 'Camera');
    //How to handle when permission is denied
    // Handle the case when the camera permission is denied
  }

  if (statuses[Permission.locationWhenInUse]!.isDenied) {
    // Handle the case when the location permission is denied
    await _handleDeniedPermission(Permission.locationWhenInUse, 'Location');
  }

  // Run the app
  runApp(const MyApp());
}



// Function to handle denied permission and re-request it
Future<void> _handleDeniedPermission(Permission permission, String permissionName) async {
  // Show a dialog informing the user about the denied permission
  await _showPermissionDeniedDialog(permissionName);

  // Request the permission again
  PermissionStatus status = await permission.request();

  // Check if the user has granted the permission after the second request
  if (status.isGranted) {
    print('$permissionName permission granted');
  } else {
    print('$permissionName permission still denied');
    // You may want to show a message or redirect to app settings if permanently denied
    await _showPermissionDeniedDialog(permissionName, isPermanent: true);
  }
}

// Function to show a dialog when a permission is denied
Future<void> _showPermissionDeniedDialog(String permissionName, {bool isPermanent = false}) async {
  return showDialog<void>(
    context: MyApp.navigatorKey.currentContext!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('$permissionName Permission Denied'),
        content: Text(
          isPermanent
              ? 'The $permissionName permission is permanently denied. Please enable it in the app settings.'
              : 'The $permissionName permission is required. Would you like to grant it?',
        ),
        actions: <Widget>[
          if (!isPermanent) // Option to retry for non-permanent denial
            TextButton(
              child: const Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          TextButton(
            child: const Text('Open Settings'),
            onPressed: () {
              openAppSettings(); // Open the app settings for permanent denial
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'LivingMenuMobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
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
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.0);
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
            child: child!);
      },
      /*builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        // Optionally clamp the scaling if necessary
        // final scale = mediaQueryData.textScaler?.scale ?? 1.0;
        final Object scale = mediaQueryData.textScaler?.scale ?? 1.0;

        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaler: TextScaler.linear(scale as double), // Replace with textScaler
          ),
          child: child!,
        );
      },*/
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      home: const Splash(),
    );
    /*return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
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
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );*/
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
