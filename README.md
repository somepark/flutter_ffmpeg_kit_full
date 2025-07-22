# flutter_ffmpeg_kit_full

A new Flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# FFmpegKit for Flutter

### 1. Features

- Includes both `FFmpeg` and `FFprobe`
- Supports
    - `Android`, `iOS` and `macOS`
    - FFmpeg `v6.0`
    - `arm-v7a`, `arm-v7a-neon`, `arm64-v8a`, `x86` and `x86_64` architectures on Android
    - `Android API Level 24` or later
        - `API Level 16` on LTS releases
    - `armv7`, `armv7s`, `arm64`, `arm64-simulator`, `i386`, `x86_64`, `x86_64-mac-catalyst` and `arm64-mac-catalyst`
      architectures on iOS
    - `iOS SDK 12.1` or later
        - `iOS SDK 10` on LTS releases
    - `arm64` and `x86_64` architectures on macOS
    - 25 external libraries

      `dav1d`, `fontconfig`, `freetype`, `fribidi`, `gmp`, `gnutls`, `kvazaar`, `lame`, `libass`, `libiconv`, `libilbc`
      , `libtheora`, `libvorbis`, `libvpx`, `libwebp`, `libxml2`, `opencore-amr`, `opus`, `shine`, `snappy`, `soxr`
      , `speex`, `twolame`, `vo-amrwbenc`, `zimg`

    - 4 external libraries with GPL license

      `vid.stab`, `x264`, `x265`, `xvidcore`

### 2. Installation

Add `flutter_ffmpeg_kit_full` as a dependency in your `pubspec.yaml file`.

```yaml
dependencies:
  flutter_ffmpeg_kit_full: ^1.0.0
```

#### 2.1 Packages

`FFmpeg` includes built-in encoders for some popular formats. However, there are certain external libraries that needs
to be enabled in order to encode specific formats/codecs. For example, to encode an `mp3` file you need `lame` or
`shine` library enabled. You have to install a `ffmpeg_kit_flutter` package that has at least one of them inside. To
encode an `h264` video, you need to install a package with `x264` inside. To encode `vp8` or `vp9` videos, you need
a `flutter_ffmpeg_kit_full` package with `libvpx` inside.

`ffmpeg-kit` provides eight packages that include different sets of external libraries. These packages are named
according to the external libraries included. Refer to the
[Packages](https://github.com/arthenica/ffmpeg-kit/wiki/Packages) wiki page to see the names of those
packages and external libraries included in each one of them.

### 3. Using

1. Execute FFmpeg commands.

    ```dart
    import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

    FFmpegKit.execute('-i file1.mp4 -c:v mpeg4 file2.mp4').then((session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {

        // SUCCESS

      } else if (ReturnCode.isCancel(returnCode)) {

        // CANCEL

      } else {

        // ERROR

      }
    });
    ```

2. Each `execute` call creates a new session. Access every detail about your execution from the session created.

    ```dart
    FFmpegKit.execute('-i file1.mp4 -c:v mpeg4 file2.mp4').then((session) async {

      // Unique session id created for this execution
      final sessionId = session.getSessionId();

      // Command arguments as a single string
      final command = session.getCommand();

      // Command arguments
      final commandArguments = session.getArguments();

      // State of the execution. Shows whether it is still running or completed
      final state = await session.getState();

      // Return code for completed sessions. Will be undefined if session is still running or FFmpegKit fails to run it
      final returnCode = await session.getReturnCode();

      final startTime = session.getStartTime();
      final endTime = await session.getEndTime();
      final duration = await session.getDuration();

      // Console output generated for this execution
      final output = await session.getOutput();

      // The stack trace if FFmpegKit fails to run a command
      final failStackTrace = await session.getFailStackTrace();

      // The list of logs generated for this execution
      final logs = await session.getLogs();

      // The list of statistics generated for this execution (only available on FFmpegSession)
      final statistics = await (session as FFmpegSession).getStatistics();

    });
    ```

3. Execute `FFmpeg` commands by providing session specific `execute`/`log`/`session` callbacks.

    ```dart
    FFmpegKit.executeAsync('-i file1.mp4 -c:v mpeg4 file2.mp4', (Session session) async {

      // CALLED WHEN SESSION IS EXECUTED

    }, (Log log) {

      // CALLED WHEN SESSION PRINTS LOGS

    }, (Statistics statistics) {

      // CALLED WHEN SESSION GENERATES STATISTICS

    });
    ```

4. Execute `FFprobe` commands.

    ```dart
    FFprobeKit.execute(ffprobeCommand).then((session) async {

      // CALLED WHEN SESSION IS EXECUTED

    });
    ```

5. Get media information for a file/url.

    ```dart
    FFprobeKit.getMediaInformation('<file path or url>').then((session) async {
      final information = await session.getMediaInformation();

      if (information == null) {

        // CHECK THE FOLLOWING ATTRIBUTES ON ERROR
        final state = FFmpegKitConfig.sessionStateToString(await session.getState());
        final returnCode = await session.getReturnCode();
        final failStackTrace = await session.getFailStackTrace();
        final duration = await session.getDuration();
        final output = await session.getOutput();
      }
    });
    ```

6. Stop ongoing FFmpeg operations.

- Stop all sessions
  ```dart
  FFmpegKit.cancel();
  ```
- Stop a specific session
  ```dart
  FFmpegKit.cancel(sessionId);
  ```

7. (Android) Convert Storage Access Framework (SAF) Uris into paths that can be read or written by
   `FFmpegKit` and `FFprobeKit`.

- Reading a file:
  ```dart
  FFmpegKitConfig.selectDocumentForRead('*/*').then((uri) {
    FFmpegKitConfig.getSafParameterForRead(uri!).then((safUrl) {
      FFmpegKit.executeAsync("-i ${safUrl!} -c:v mpeg4 file2.mp4");
    });
  });
  ```

- Writing to a file:
  ```dart
  FFmpegKitConfig.selectDocumentForWrite('video.mp4', 'video/*').then((uri) {
    FFmpegKitConfig.getSafParameterForWrite(uri!).then((safUrl) {
      FFmpegKit.executeAsync("-i file1.mp4 -c:v mpeg4 ${safUrl}");
    });
  });
  ```

8. Get previous `FFmpeg`, `FFprobe` and `MediaInformation` sessions from the session history.

    ```dart
    FFmpegKit.listSessions().then((sessionList) {
      sessionList.forEach((session) {
        final sessionId = session.getSessionId();
      });
    });

    FFprobeKit.listFFprobeSessions().then((sessionList) {
      sessionList.forEach((session) {
        final sessionId = session.getSessionId();
      });
    });

    FFprobeKit.listMediaInformationSessions().then((sessionList) {
      sessionList.forEach((session) {
        final sessionId = session.getSessionId();
      });
    });
    ```

9. Enable global callbacks.

- Session type specific Complete Callbacks, called when an async session has been completed

  ```dart
  FFmpegKitConfig.enableFFmpegSessionCompleteCallback((session) {
    final sessionId = session.getSessionId();
  });

  FFmpegKitConfig.enableFFprobeSessionCompleteCallback((session) {
    final sessionId = session.getSessionId();
  });

  FFmpegKitConfig.enableMediaInformationSessionCompleteCallback((session) {
    final sessionId = session.getSessionId();
  });
  ```

- Log Callback, called when a session generates logs

  ```dart
  FFmpegKitConfig.enableLogCallback((log) {
    final message = log.getMessage();
  });
  ```

- Statistics Callback, called when a session generates statistics

  ```dart
  FFmpegKitConfig.enableStatisticsCallback((statistics) {
    final size = statistics.getSize();
  });
  ```

10. Register system fonts and custom font directories.

    ```dart
    FFmpegKitConfig.setFontDirectoryList(["/system/fonts", "/System/Library/Fonts", "<folder with fonts>"]);
    ```

### 4. Test Application

You can see how `FFmpegKit` is used inside an application by running `flutter` test applications developed under
the [FFmpegKit Test](https://github.com/arthenica/ffmpeg-kit-test) project.

### 5. Tips

See [Tips](https://github.com/arthenica/ffmpeg-kit/wiki/Tips) wiki page.

### 6. License

See [License](https://github.com/arthenica/ffmpeg-kit/wiki/License) wiki page.

### 7. Patents

See [Patents](https://github.com/arthenica/ffmpeg-kit/wiki/Patents) wiki page.

### 8.sh 执行权限 ###
- 初次构建或升级版本时执行一次
- Android
```chmod +x scripts/setup_android.sh```
- iOS
```chmod +x scripts/setup_ios.sh```

