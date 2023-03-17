// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:agoratestapp/shared/utils.dart';
// import 'package:flutter/material.dart';

// class AgoraUIKitPage extends StatefulWidget {
//   const AgoraUIKitPage({Key? key}) : super(key: key);

//   @override
//   State<AgoraUIKitPage> createState() => _AgoraUIKitPageState();
// }

// class _AgoraUIKitPageState extends State<AgoraUIKitPage> {
//   final AgoraClient client = AgoraClient(
//     agoraConnectionData: AgoraConnectionData(
//         appId: appId,
//         channelName: channelName,
//         // uid: 0,
//         // username: "user",
//         tempToken:
//             '$serverUrl/rtc/$channelName/${tokenRole.toString()}/uid/${uid.toString()}?expiry=${tokenExpireTime.toString()}'),
//   );

// // Future<void> fetchToken(int uid, String channelName, int tokenRole) async {
// //     // Prepare the Url
// //     String url = ;

// //     // Send the request
// //     final response = await http.get(Uri.parse(url));

// //     if (response.statusCode == 200) {
// //         // If the server returns an OK response, then parse the JSON.
// //         Map<String, dynamic> json = jsonDecode(response.body);
// //         String newToken = json['rtcToken'];
// //         debugPrint('Token Received: $newToken');
// //         // Use the token to join a channel or renew an expiring token
// //         setToken(newToken);
// //     } else {
// //         // If the server did not return an OK response,
// //         // then throw an exception.
// //         throw Exception(
// //             'Failed to fetch a token. Make sure that your server URL is valid');
// //     }
// // }
// // void setToken(String newToken) async {
// //     var token = newToken;

// //     if (isTokenExpiring) {
// //         // Renew the token
// //         client.engine.renewToken(token);
// //         isTokenExpiring = false;
// //         // showMessage("Token renewed");
// //     } else {
// //         // Join a channel.
// //         // showMessage("Token received, joining a channel...");

// //         await client.engine.joinChannel(
// //             token: token,
// //             channelId: channelName,

// //             // info: '',
// //             // uid: uid,
// //             uid: 1
// //         );
// //     }
// // }

//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }

//   // initiate agora client
//   void initAgora() async {
//     // await [Permission.microphone, Permission.camera].request();
//     await client.initialize();
//   }

//   @override
//   void dispose() {
//     client.engine.leaveChannel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Agora VideoUIKit'),
//           centerTitle: true,
//         ),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 150),
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     height: 50,
//                     width: 300,
//                     alignment: Alignment.center,
//                     decoration: const BoxDecoration(
//                       color: Colors.grey,
//                     ),
//                     child: const Text(
//                       "12345678910",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               //this display the video of all users
//               AgoraVideoViewer(
//                 client: client,
//                 showNumberOfUsers: true,
//                 layoutType: Layout.floating,
//                 enableHostControls: true,
//                 // Add this to enable host controls
//               ),
//               // this display the button
//               AgoraVideoButtons(
//                 onDisconnect: () => Navigator.pop(context),
//                 client: client,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
