import 'package:cli/whois_service.dart';
import 'package:cli/whois_services/cctld_uz.dart';
import 'package:dio/dio.dart';

class DomainFinder {
  //Whois service name, for example CCTLD.UZ
  final String serviceName;
  //Domain zone, for example .uz
  final String domainZone;
  //length of domain
  final int length;
  static const List<String> alphabet = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];
  static const List<String> numbers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0'
  ];

  WhoisService? whoisService;

  DomainFinder(
      {required this.serviceName,
      required this.domainZone,
      required this.length,
      required Dio dio}) {
    if (serviceName == 'CCTLD_UZ') {
      whoisService = CCTLD_UZ(dio);
    }

    if (whoisService == null) {
      Exception("Unknown Whois Service");
    }
  }
  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  void generateDomainNames(String sb, int n) async {
    //await Future.delayed(Duration(milliseconds: 1000));
    if (n == sb.length) {
      //print(sb.toString());

      print("request");
      whoisService?.setDomain(sb.toString(), domainZone);
      await whoisService?.callService();
      if (whoisService!.isEmpty()) {
        print(sb.toString());
      }

      return;
    }
    for (String letter in numbers) {
      //sb.setCharAt(n, letter);
      //await Future.delayed(Duration(milliseconds: 1000));
      sb = replaceCharAt(sb, n, letter);
      generateDomainNames(sb, n + 1);
    }
  }

  void startSearch() {
    print("Starting...\nHere are domains that you can buy right now:");
    String sb = "  ";
    generateDomainNames(sb, 0);
  }
}
