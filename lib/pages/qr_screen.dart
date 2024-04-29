import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_barcode_scanner/flutter_barcode_scanner.dart";
import 'package:geolocator/geolocator.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<QrScreen> {
  var getResult = "QR Code Resultado";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bienvenido"),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            scanQR();
          }, 
          child: const Text("Codigo QR"),
          ),
          const SizedBox(height: 20,),
          Text(getResult)
        ],
      ),),
    );
  }
  void scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      if (!mounted) return;
      setState(() {
        getResult = qrCode;
      });
      print("QRCode_result:--");
      print(qrCode);
    } on PlatformException {
      getResult = "Failed to get platform version.";
    }
  }
}

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late Position _currentPosition;
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: const Text('Ubicacion actual'),
      ), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LAT: ${_currentPosition.latitude}, LNG:${_currentPosition.longitude}"),
              ElevatedButton(
                child: const Text("Obtener ubicacion"),
                onPressed: () {
                  _getCurrentLocation();
                },
               ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Position>('_currentPosition', _currentPosition));
  }
}