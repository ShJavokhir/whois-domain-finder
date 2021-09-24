import 'dart:io';

import 'package:args/args.dart';
import 'package:cli/communication/communication.dart';
import 'package:cli/communication/communication_services/telegram.dart';
import 'package:cli/database/database_services/file_database.dart';
import 'package:cli/database/domain_repository.dart';
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
  var parser = ArgParser();

  //var args = parser.parse(['-logger', '-numbers', '-letters', '-communication', '--communicationService', '--messageReceiver', '-database', '--cctldService', '--length', '--zone']);

  //print(args);
  //return;


  DomainRepository domainRepository = FileDatabase(localFile: File('domains.txt'));
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
      communication: cm,
      domainRepository: domainRepository
  );

  // var domainFinder = DomainFinder(
  //    serviceName: 'CCTLD_UZ', domainZone: 'uz', length: 4, dio: dio);
  //var domainFinder = DomainFinder(
  //    serviceName: 'ESKIZ_UZ', domainZone: 'uz', length: 4, dio: dio);
  domainFinder.startSearch();
}

ArgParser _configureParser(){
  final parser = ArgParser();
  
  parser.addFlag('logger', abbr: 'l', help: 'Enables logging', defaultsTo: false);
  parser.addFlag('numbers', abbr: 'n', help: 'Searches for domains with numbers', defaultsTo: false);
  parser.addFlag('letters', abbr: 'l', help: 'Searches for domains with letters', defaultsTo: true);
  parser.addFlag('communication', abbr: 'c', help: 'Sends messages to your messenger or api about free domain, receiver flag and receiver id should be should be defined', defaultsTo: false);
  parser.addOption('communicationService', abbr: 'cs', help: 'Communication Service (Default: TELEGRAM)', defaultsTo: 'TELEGRAM');
  parser.addOption('messageReceiver', abbr: 'mr', help: 'Message receiver (For example your id on telegram)', defaultsTo: '0');
  parser.addFlag('database', abbr: 'd', help: 'Continously checks domains from database', defaultsTo: false);
  parser.addOption('cctldService', abbr: 's', help: 'CCTLD whois service (Default ESKIZ_UZ)', defaultsTo: 'ESKIZ_UZ');
  parser.addOption('length', abbr: 'ln', help: 'Length of domains to generate (Default 3)', defaultsTo: '3');
  parser.addOption('zone', abbr: 'zn', help: 'Domain Zone (Default UZ)', defaultsTo: 'UZ');


  return parser;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
