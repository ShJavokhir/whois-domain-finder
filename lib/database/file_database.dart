import 'dart:io';

import 'package:cli/database/domain_repository.dart';

class FileDatabase implements DomainRepository {
  late final File _localFile;

  FileDatabase({required File localFile}) {
    _localFile = localFile;
  }

  @override
  Future<void> addDomain(String domainName) async {
    await _localFile.writeAsString('$domainName\n');
  }

  @override
  Future<void> deleteDomain(String domainName) {
    // TODO: implement deleteDomain
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getDomains() async {
    return await _localFile.readAsLines();
  }
}
