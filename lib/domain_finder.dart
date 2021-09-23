import 'dart:io';

import 'package:cli/enums/domain_status_enum.dart';
import 'package:cli/models/domain_status_with_info.dart';
import 'package:cli/whois_service.dart';
import 'package:cli/whois_services/cctld_uz.dart';
import 'package:cli/whois_services/eskiz_uz.dart';
import 'package:dio/dio.dart';

class DomainFinder {
  //Whois service name, for example CCTLD.UZ
  final String serviceName;
  //Domain zone, for example .uz
  final String domainZone;
  //length of domain
  final int length;
  //Number of domains checked out
  int counter = 0;
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
      //whoisService = CCTLD_UZ(dio);
    } else if (serviceName == "ESKIZ_UZ") {
      whoisService = ESKIZ_UZ(dio);
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

  Future<void> generateDomainNames(String sb, int n) async {
    //await Future.delayed(Duration(milliseconds: 1000));
    if (n == sb.length) {
      //print(sb.toString());
      counter++;
      stdout.write('\r' + counter.toString() + " ");
      //print("request");

      whoisService?.setDomain(sb.toString(), domainZone);
      try {
        await whoisService?.callService();
      } catch (e) {
        print("Error: " + e.toString());
        return;
      }

      final domainStatus = whoisService?.getDomainStatus();

      if (domainStatus?.domainStatus == DomainStatus.EXPIRED) {
        final info = domainStatus?.info ?? "NULL";
        stdout.write(sb.toString() + ' | ' + info + '\n');
      }

      if (domainStatus?.domainStatus == DomainStatus.REDEMPTION_PERIOD) {
        final info = domainStatus?.info ?? "NULL";
        stdout.write(sb.toString() + ' | ' + info + '\n');
      }

      return;
    }
    for (String letter in alphabet) {
      //sb.setCharAt(n, letter);
      //await Future.delayed(Duration(milliseconds: 1000));
      sb = replaceCharAt(sb, n, letter);
      await generateDomainNames(sb, n + 1);
    }
  }

  String _getStringWithLength(int length) {
    String result = '';
    for (int i = 0; i < length; i++) result += ' ';
    return result;
  }

  void startSearch() {
    print("Starting...\nHere are domains that you can buy right now:");
    String sb = _getStringWithLength(length);
    generateDomainNames(sb, 0);
  }
}
