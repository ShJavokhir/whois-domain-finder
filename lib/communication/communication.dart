import 'package:cli/models/message.dart';

abstract class Communication {
  Future<void> sendMessage(Message message);
}
