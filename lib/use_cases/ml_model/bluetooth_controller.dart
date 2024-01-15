import 'dart:async';



import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:heart_rate/use_cases/pill_reminder/custom_snack_bar.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController{
  Rx<BluetoothDevice?> device = Rx<BluetoothDevice?>(null);
   bool isReady=false;
  FlutterBlue flutterBlue = FlutterBlue.instance;


  Future connectToDevice(BluetoothDevice d) async {
    try {

      await   d.connect(timeout: const Duration(seconds: 3));



    } on TimeoutException catch (e) {
customSnackBar(title: "Error", message: "Error connecting to the device: $e", successful: false);
      return;
    }



    device.value = d;
    update();
    discoverServices();
  }

  disconnectFromDevice() {
    if (device.value == null) {
      return;
    }

   device.value!.disconnect();
    customSnackBar(title: "Error", message: "Disconnected", successful: false);

  }

  discoverServices() async {
    try {
      String serviceUuid = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
      String characteristicUuid = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
      List<BluetoothService> services = await device.value!.discoverServices();

      for (var service in services) {
        if (service.uuid.toString() == serviceUuid) {

          for (var characteristic in service.characteristics) {

            if (characteristic.uuid.toString() == characteristicUuid) {
              try {
                if (!characteristic.isNotifying) {

                  await characteristic.setNotifyValue(true);
                }

                characteristic.value.listen((List<int> value) {

                  _streamController.add(value);

                });
              } on Exception catch (e) {
                customSnackBar(title: "Error", message: e.toString(), successful: false);
              }

            }
          }
        }
      }
    } on Exception catch (e) {
      customSnackBar(title: "Error", message: e.toString(), successful: false);
    }


  }

  Future scanDevices() async{
    var blePermission = await Permission.bluetoothScan.status;
    if(blePermission.isDenied){
      if(await Permission.bluetoothScan.request().isGranted){
        if(await Permission.bluetoothConnect.request().isGranted){
          flutterBlue.startScan(timeout: const Duration(seconds: 10));

          flutterBlue.stopScan();
        }
      }
    }else{
      flutterBlue.startScan(timeout: const Duration(seconds: 10));

      flutterBlue.stopScan();
    }
  }

  Stream<List<int>>? getData(){

    return stream;
  }
  StreamController<List<int>> _streamController = StreamController<List<int>>.broadcast();
  Stream<List<int>>? get stream => _streamController.stream;

   Stream<List<ScanResult>>? get scanResults => flutterBlue.scanResults;
}