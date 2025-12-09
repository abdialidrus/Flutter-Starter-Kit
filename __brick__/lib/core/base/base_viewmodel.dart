import 'package:flutter/foundation.dart';

/// Base class for all ViewModels in the application.
/// Extends [ChangeNotifier] to provide state management capabilities.
abstract class BaseViewModel extends ChangeNotifier {
  bool _isDisposed = false;

  /// Check if this ViewModel has been disposed
  bool get isDisposed => _isDisposed;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }
}
