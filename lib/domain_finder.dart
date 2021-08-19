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

  WhoisService? whoisService;

  DomainFinder(
      {required this.serviceName,
      required this.domainZone,
      required this.length,
      required Dio dio}) {
    if (serviceName == 'CCTLD_UZ') {
      whoisService = CCTLD_UZ(dio);
    }
  }

  void startSearch() {}
}
