
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:heart_rate/utils/custom_colors.dart';
import 'bluetooth_controller.dart';

class BluetoothView extends StatelessWidget {
  final BleController bleController = Get.find<BleController>();

   BluetoothView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                'Connected Device: ${bleController.device.value?.name ?? 'None'}',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                bleController.disconnectFromDevice();
              },
              child: Text(
                'Disconnect',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: CustomColors.primaryColor),
              ),
            ),
            ElevatedButton(
                onPressed: () => bleController.scanDevices(),
                child: Text("Scan",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: CustomColors.primaryColor))),
            StreamBuilder<List<ScanResult>>(
                stream: bleController.scanResults,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];

                          return InkWell(
                            onTap: () async {
                              await bleController.connectToDevice(data.device);
                            },
                            child: Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(data.device.name),
                                subtitle: Text(data.device.id.id),
                                trailing: Text(data.rssi.toString()),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: Text("No Device Found",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: CustomColors.primaryColor)),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
