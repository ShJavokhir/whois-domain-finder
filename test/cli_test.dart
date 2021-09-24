import 'dart:io';

import 'package:cli/database/domain_repository.dart';
import 'package:cli/database/database_services/file_database.dart';
import 'package:cli/whois_service.dart';
import 'package:cli/whois_services/cctld_uz.dart';
import 'package:test/test.dart';

void main() {
  test('file database add domain test', () async {
    //Arrange
    final myfile = File('test.test');
    DomainRepository repository = FileDatabase(localFile: myfile);

    //act
    await repository.addDomain("test.uz");


    //assert
    List<String> result = await repository.getDomains();

    if(result.isEmpty) throwsException;

    expect(result[0], "test.uz");
  });

  test('file database add same domain second time test', () async{
    //Arrange
    final myfile = File('test.test');
    DomainRepository repository = FileDatabase(localFile: myfile);

    //act
    await repository.addDomain("test.uz");

    //assert
    List<String> result = await repository.getDomains();
    expect(result[0], "test.uz");
  });

  test('file database delete domain test', ()async{
    final myfile = File('test.test');
    DomainRepository repository = FileDatabase(localFile: myfile);

    //act
    await repository.deleteDomain("test.uz");

    //assert
    List<String> result = await repository.getDomains();
    expect(result, []);
  });
}
