import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_ffmpeg_kit_full_gpl_method_channel.dart';

abstract class FlutterFfmpegKitFullGplPlatform extends PlatformInterface {
  /// Constructs a FlutterFfmpegKitFullGplPlatform.
  FlutterFfmpegKitFullGplPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterFfmpegKitFullGplPlatform _instance = MethodChannelFlutterFfmpegKitFullGpl();

  /// The default instance of [FlutterFfmpegKitFullGplPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterFfmpegKitFullGpl].
  static FlutterFfmpegKitFullGplPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterFfmpegKitFullGplPlatform] when
  /// they register themselves.
  static set instance(FlutterFfmpegKitFullGplPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
