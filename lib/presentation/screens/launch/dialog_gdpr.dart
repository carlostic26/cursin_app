import 'package:flutter/material.dart';
import 'package:gdpr_dialog/gdpr_dialog.dart';

class DialogGdpr extends StatefulWidget {
  const DialogGdpr({super.key});

  @override
  State<DialogGdpr> createState() => _DialogGdprState();
}

class _DialogGdprState extends State<DialogGdpr> {
  String status = 'none';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Debes aceptar el consentimiento de datos.'),
              ElevatedButton(
                child: Text('Show dialog'),
                onPressed: () {
                  GdprDialog.instance.resetDecision();
                  GdprDialog.instance
                      .showDialog(isForTest: false, testDeviceId: '')
                      .then((onValue) {
                    setState(() => status = 'dialog result == $onValue');
                  });

                  GdprDialog.instance.resetDecision();
                  GdprDialog.instance
                      .showDialog(isForTest: false, testDeviceId: '')
                      .then((onValue) {
                    setState(() => status = 'dialog result == $onValue');
                  });
                },
              ),
              ElevatedButton(
                child: Text('Get consent status'),
                onPressed: () => GdprDialog.instance.getConsentStatus().then(
                    (value) =>
                        setState(() => status = 'consent status == $value')),
              ),
              Container(height: 50),
              Text(status),
            ],
          ),
        ),
      ),
    );
  }
}
