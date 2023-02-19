import 'package:flutter/material.dart';

class InitiationProvider extends ChangeNotifier {
  String? _sessionKey = null;
  String? get sessionKey {
    return _sessionKey;
  }
}

/// 추후 이 코드의 경우 재 확인 할 필요성이 있음.