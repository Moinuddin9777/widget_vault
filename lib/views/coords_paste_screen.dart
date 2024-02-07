import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_vault/views/map_screen.dart';

class CoordsPaste extends StatefulWidget {
  const CoordsPaste({super.key});

  @override
  State<CoordsPaste> createState() => _CoordsPasteState();
}

class _CoordsPasteState extends State<CoordsPaste> {
  final TextEditingController _latcontroller = TextEditingController();
  final TextEditingController _longcontroller = TextEditingController();
  void _fromCopiedCoords() async {
    String lat = "";
    String long = "";
    bool flag = true;
    String location = await FlutterClipboard.paste();
    if (location == "") return;
    print(location);
    for (int i = 0; i < location.length; i++) {
      if (location[i] == ',') {
        flag = false;
        continue;
      }
      if (flag) {
        lat += location[i];
      } else {
        long += location[i];
      }
    }
    print(lat);
    print(long);
    if (lat == "" || long == "") return;
    _showOnMap(lat, long);
  }

  void _onCustomLocation() {
    String lat = _latcontroller.text;
    String long = _longcontroller.text;
    if (lat == "" || long == "") return;
    _showOnMap(lat, long);
  }

  void _showOnMap(String lat, String long) {
    Get.to(
      () => LocationOnMap(lat: lat, long: long),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Show Location',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _fromCopiedCoords,
            child: const Text('Use copied Coordinates'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _latcontroller,
                    maxLength: 20,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: TextField(
                    controller: _longcontroller,
                    maxLength: 20,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _onCustomLocation,
            child: const Text('Use custom coordinates'),
          ),
        ],
      ),
    );
  }
}
