import 'package:dio/dio.dart';

abstract class WhoisService {
  Future<void> callService();
  bool isEmpty();
}
