//
// Generated file. Do not edit.
//

// ignore: unused_import
import 'dart:ui';

import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:video_player_web/video_player_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(PluginRegistry registry) {
  SharedPreferencesPlugin.registerWith(registry.registrarFor(SharedPreferencesPlugin));
  VideoPlayerPlugin.registerWith(registry.registrarFor(VideoPlayerPlugin));
  registry.registerMessageHandler();
}
