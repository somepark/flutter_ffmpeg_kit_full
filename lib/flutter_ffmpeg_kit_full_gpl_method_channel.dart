import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_ffmpeg_kit_full_gpl_platform_interface.dart';

/// An implementation of [FlutterFfmpegKitFullGplPlatform] that uses method channels.
class MethodChannelFlutterFfmpegKitFullGpl extends FlutterFfmpegKitFullGplPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_ffmpeg_kit_full_gpl');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
