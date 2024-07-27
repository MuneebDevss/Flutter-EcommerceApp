import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<List<ConnectivityResult>> _connectionStatus = Rx<List<ConnectivityResult>>([]);


  /// Initialize the network manager and set up a stream to continually check the connection status.
  @override
  Future<void> onInit() async {
    super.onInit();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }


  /// Update the connection status based on changes in connectivity and show a relevant popup for no internet connection.
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result)async{
    _connectionStatus.value = result;
    if(!result.contains(ConnectivityResult.wifi)) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('No internet connection')));
    }
  }

  /// Check the internet connection status.
  /// Returns true if connected, false otherwise.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result.contains(ConnectivityResult.wifi);
    } catch (e) {
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel(); // Cancel the subscription to avoid memory leaks
  }
}
