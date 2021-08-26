import 'package:cli/domain_finder.dart';
import 'package:cli/whois_service.dart';
import 'package:cli/whois_services/cctld_uz.dart';
import 'package:dio/dio.dart';

void main(List<String> arguments) async {
  var dio = Dio();
  String domainZone = arguments[0];
  String domainLength = arguments[1];
  String domainService = arguments[2] == null ? "ESKIZ_UZ" : arguments[2];

  final domainFinder = DomainFinder(
      serviceName: domainService,
      domainZone: domainZone,
      length: int.parse(domainLength),
      dio: dio);

  // var domainFinder = DomainFinder(
  //    serviceName: 'CCTLD_UZ', domainZone: 'uz', length: 4, dio: dio);
  //var domainFinder = DomainFinder(
  //    serviceName: 'ESKIZ_UZ', domainZone: 'uz', length: 4, dio: dio);
  domainFinder.startSearch();
}
