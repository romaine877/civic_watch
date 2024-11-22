import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  Future<void> _handlePickImages(IssueType issueType, LatLng latLong) async{
    final ImagePicker picker = ImagePicker();
     final directory = await getTemporaryDirectory();
     final guid = UniqueKey().toString();
        final filePath = '${directory.path}/$guid.png';
        final file = File(filePath);
       final mapSnapByte = await _controller?.takeSnapshot();

       if (mapSnapByte != null) {
        await file.writeAsBytes(mapSnapByte);
    }
    picker.pickMultiImage().then((value) {
      if (value.isNotEmpty && mounted) {
     context.push('/image-preview', extra: {
      'pictures': value,
      'mapSnap': file,
      
      },);
      }
    });
  }

  Future<void> _handleReportModal(latLong) async{
    final newLatLong = LatLng(latLong.latitude, latLong.longitude);
      
    _controller?.animateCamera(CameraUpdate.newLatLng(newLatLong));
   



    setState(() {
      _markers = {
        Marker(
          markerId: MarkerId(latLong.toString()),
          position: latLong,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      };
    });

    showShadSheet<IssueType>(
        context: context,
        barrierColor: Colors.transparent,
        useRootNavigator: true,
        isDismissible: true,
        builder: (context) {
          return const ReportIssueModal();
        }).then((value) {
      if (value != null) {
        _handlePickImages(value, latLong);
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          markers: _markers,
          minMaxZoomPreference: const MinMaxZoomPreference(8, 18),
          cameraTargetBounds: CameraTargetBounds(
            LatLngBounds(
              southwest: const LatLng(17.702, -78.5),
              northeast: const LatLng(18.8, -76.2),
            ),
          ),
          onMapCreated: _onMapCreated,
          padding: const EdgeInsets.only(bottom: 100, top: 50),
          onLongPress: _handleReportModal,
          initialCameraPosition: const CameraPosition(
            zoom: 8,
            target: LatLng(18.149814495638118, -77.3208948969841),
          )),
    );
  }
}

class ReportIssueModal extends StatefulWidget {
  const ReportIssueModal({
    super.key,
  });

  @override
  State<ReportIssueModal> createState() => _ReportIssueModalState();
}

class _ReportIssueModalState extends State<ReportIssueModal> {
  IssueType? _issueType;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ShadSheet(
      draggable: true,
      closeIcon: IconButton(
        icon: const Icon(LucideIcons.x, size: 30),
        onPressed: () => Navigator.pop(context),
      ),
      padding: EdgeInsets.only(
          bottom: MediaQuery.paddingOf(context).bottom,
          left: 20,
          right: 20,
          top: 20),
      title: Text(
        'Report an issue',
        style: textTheme.displaySmall,
      ),
      description: Text(
        'Please select the type of issue you would like to report',
        style: textTheme.bodyLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShadRadioGroup<IssueType>(
            initialValue: _issueType,
            onChanged: (value) {
              setState(() {
                _issueType = value;
              });
            },
            items: [
              ShadRadio(
                padding: const EdgeInsets.all(12),
                size: 20,
                decoration: ShadDecoration(
                  labelStyle: textTheme.displayMedium,
                ),
                label: Text(
                  'Pothole',
                  style: textTheme.titleLarge,
                ),
                value: IssueType.pothole,
              ),
              ShadRadio(
                padding: const EdgeInsets.all(12),
                size: 20,
                decoration: ShadDecoration(
                  labelStyle: textTheme.displayMedium,
                ),
                label: Text(
                  'Broken Main',
                  style: textTheme.titleLarge,
                ),
                value: IssueType.brokenMain,
              ),
              ShadRadio(
                padding: const EdgeInsets.all(12),
                size: 20,
                decoration: ShadDecoration(
                  labelStyle: textTheme.displayMedium,
                ),
                label: Text(
                  'Fallen Tree',
                  style: textTheme.titleLarge,
                ),
                value: IssueType.fallenTree,
              ),
              ShadRadio(
                padding: const EdgeInsets.all(12),
                size: 20,
                decoration: ShadDecoration(
                  labelStyle: textTheme.displayMedium,
                ),
                label: Text(
                  'Other',
                  style: textTheme.titleLarge,
                ),
                value: IssueType.other,
              ),
            ],
          ),
          const SizedBox(height: 20),
          ShadButton(
            onPressed: () {
              Navigator.pop(context, _issueType);
            },
            child: const Text(
              'Continue',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

enum IssueType {
  pothole,
  brokenMain,
  fallenTree,
  other,
}
