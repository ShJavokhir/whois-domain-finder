import 'dart:io';

import 'package:cli/database/domain_repository.dart';
import 'package:cli/database/file_database.dart';
import 'package:cli/whois_service.dart';
import 'package:cli/whois_services/cctld_uz.dart';
import 'package:test/test.dart';

void main() {
  test('File write test', () async {
    //Arrange
    final myfile = File('test.txt');
    DomainRepository repository = FileDatabase(localFile: myfile);

    //act
    await repository.addDomain("test.uz");

    //assert
    List<String> result = await repository.getDomains();
    expect(result[0], "test.uz");
  });
}
