import 'dart:io';

import 'package:cli/communication/communication.dart';
import 'package:cli/communication/communication_services/telegram.dart';
import 'package:cli/domain_finder.dart';
import 'package:cli/logger/logger.dart';
import 'package:cli/models/message.dart';
import 'package:cli/whois_service.dart';
import 'package:cli/whois_services/cctld_uz.dart';
import 'package:dio/dio.dart';

void main(List<String> arguments) async {
  HttpOverrides.global = new MyHttpOverrides();
  Logger.enable();
  var dio = Dio();

  Communication? cm;
  //cm.sendMessage(Message(message: "hi"));

  String domainZone = arguments[0];
  String domainLength = arguments[1];
  String domainService = arguments[2] == null ? "ESKIZ_UZ" : arguments[2];
  String? communicationService = arguments[3];
  if (communicationService != null) {
    String? communicationReceiver = arguments[4];
    if (communicationService == "TELEGRAM") {
      cm = Telegram.withParameters(chatId: communicationReceiver, dio: dio);
    }
  }

  final domainFinder = DomainFinder(
      serviceName: domainService,
      domainZone: domainZone,
      length: int.parse(domainLength),
      dio: dio,
      communication: cm);

  // var domainFinder = DomainFinder(
  //    serviceName: 'CCTLD_UZ', domainZone: 'uz', length: 4, dio: dio);
  //var domainFinder = DomainFinder(
  //    serviceName: 'ESKIZ_UZ', domainZone: 'uz', length: 4, dio: dio);
  domainFinder.startSearch();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
