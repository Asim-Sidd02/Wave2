import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

typedef DiscordInitNative = Void Function(Pointer<Utf8>, Uint64, Int32, Int32);
typedef DiscordInitDart = void Function(Pointer<Utf8>, int, int, int);

typedef DiscordUpdatePresenceNative = Void Function(Pointer<Void>);
typedef DiscordUpdatePresenceDart = void Function(Pointer<Void>);

class DiscordRPC {
  static late DynamicLibrary _lib;
  static late DiscordInitDart _init;
  static late DiscordUpdatePresenceDart _updatePresence;

  static void initialize() {
    if (Platform.isWindows) {
      _lib = DynamicLibrary.open("windows/discord-rpc.dll");
    } else if (Platform.isLinux) {
      _lib = DynamicLibrary.open("linux/libdiscord-rpc.so");
    } else {
      throw UnsupportedError("Unsupported platform");
    }

    _init = _lib.lookupFunction<DiscordInitNative, DiscordInitDart>("Discord_Initialize");
    _updatePresence = _lib.lookupFunction<DiscordUpdatePresenceNative, DiscordUpdatePresenceDart>("Discord_UpdatePresence");

    final appId = "1295383009171738726".toNativeUtf8();
    _init(appId, 0, 1, 0); // Auto-inject, no Steam
    malloc.free(appId);
  }

  static void updatePresence(String details, String state) {
    final presenceStruct = malloc.allocate(56); // DiscordRichPresence struct size

    final detailsPtr = details.toNativeUtf8();
    final statePtr = state.toNativeUtf8();

    presenceStruct.cast<Pointer<Utf8>>().value = detailsPtr;
    presenceStruct.cast<Pointer<Utf8>>().elementAt(1).value = statePtr;

    _updatePresence(presenceStruct.cast<Void>());

    malloc.free(detailsPtr);
    malloc.free(statePtr);
    malloc.free(presenceStruct);
  }
}
