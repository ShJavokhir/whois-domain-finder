import 'package:dio/dio.dart';

abstract class WhoisService {
  Future<void> callService();
  bool isEmpty();
  void setDomain(String domainName, String domainZone);
}
