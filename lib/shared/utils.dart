import 'shared methods/random_number_generator.dart';

const String appId = "a9e15f05391e4fb3a0231baa4ce73325";
String channelName = 'flutterapp';
String token = "";
int tokenExpireTime = 500; // Expire time in Seconds.
int uid = randomNumber() + 1;
String serverUrl = "https://agora-token-service-production-df9e.up.railway.app";
int tokenRole = 1;
bool isTokenExpiring = false; 
// final channelTextController = TextEditingController(text: '');