import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkCheckerProvider extends ChangeNotifier {
  bool get isConnected => _isConnected;
  bool _isConnected = false;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  Future<void> checkConnection() async {
    await _updateConnectionStatus();

    _subscription ??= Connectivity().onConnectivityChanged.listen((results) async {
        await _updateConnectionStatus(results);
      });
  }

  Future<void> _updateConnectionStatus([List<ConnectivityResult>? results]) async {
    results ??= await Connectivity().checkConnectivity();
    if (!results.any((result) => result != ConnectivityResult.none)) {
      _setConnected(false);
      return;
    }

    try {
      final lookupResult = await InternetAddress.lookup('google.com').timeout(const Duration(seconds: 5));
      if (lookupResult.isNotEmpty && lookupResult.first.rawAddress.isNotEmpty) {
        _setConnected(true);
      } else {
        _setConnected(false);
      }
    } catch (e) {
      _setConnected(false);
    }
  }

  void _setConnected(bool connected) {
    if (_isConnected != connected) {
      _isConnected = connected;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}