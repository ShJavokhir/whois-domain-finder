import 'package:cli/communication/communication.dart';
import 'package:cli/config.dart';
import 'package:cli/models/message.dart';
import 'package:dio/dio.dart';

class Telegram implements Communication {
  String? _botToken;
  static const ROOT_URL = "https://api.telegram.org";
  String? _chatId;
  Dio? _dio;
  //bot<Bot_token>/sendMessage?chat_id=<chat_id>&text=Привет%20мир

  Telegram(Dio dio) {
    _dio = dio;
    _botToken = Config.TELEGRAM_BOT_TOKEN;
  }

  Telegram.withParameters({required String chatId, required Dio dio}) {
    _dio = dio;
    _botToken = Config.TELEGRAM_BOT_TOKEN;
    this._chatId = chatId;
  }

  set chatId(String chatId) {
    _chatId = chatId;
  }

  @override
  Future<void> sendMessage(Message message) async {
    await _dio?.get(
        '$ROOT_URL/$_botToken/sendMessage?chat_id=$_chatId&text=$message');
  }
}
