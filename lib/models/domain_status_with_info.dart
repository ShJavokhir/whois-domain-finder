import 'package:cli/enums/domain_status_enum.dart';

class DomainStatusWithInfo {
  DomainStatus? domainStatus;
  String? info;
  DomainStatusWithInfo({required this.domainStatus, required this.info});
  //DomainStatus get getDomainStatus => domainStatus;
  //String get getInfo => info;
}
