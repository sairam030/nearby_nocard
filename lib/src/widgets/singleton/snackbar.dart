import 'package:flutter/material.dart';

class SnakbarHelper {
  static final SnakbarHelper _instance = SnakbarHelper._();
  SnakbarHelper._();

  static SnakbarHelper get instance => _instance;

  BuildContext? _context;

  void init(BuildContext context) {
    _context = context;
  }

  void show(String message) {
    if (_context == null) {
      throw Exception("Context is null. Call init method first.");
    }

    ScaffoldMessenger.of(_context!).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 200),
      ),
    );
  }
}
