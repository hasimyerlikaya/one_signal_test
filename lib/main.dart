import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      print('FOREGROUND HANDLER CALLED WITH: ${event}');

      event.complete(null);
    });

    OneSignal.shared.setInAppMessageClickedHandler((OSInAppMessageAction action) {});

    OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges changes) {
      print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
    });

//Todo: App Id yazılacak
    await OneSignal.shared.setAppId("");

    OneSignal.shared.disablePush(false);

    bool userProvidedPrivacyConsent = await OneSignal.shared.userProvidedPrivacyConsent();
    print("USER PROVIDED PRIVACY CONSENT: $userProvidedPrivacyConsent");
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
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
