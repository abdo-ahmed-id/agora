import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:agoratestapp/shared/utils.dart';

class VideoCallPage extends StatefulWidget {
  var response;
  VideoCallPage({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  VideoCallPageState createState() => VideoCallPageState();
}

class VideoCallPageState extends State<VideoCallPage> {
  bool isCameraDisable = true;
  bool mute = true;
  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance

  void switchCamera() {
    agoraEngine.switchCamera();
  }

  void muteMic() {
    setState(() {
      mute = !mute;
    });
    agoraEngine.enableLocalAudio(mute);
  }

  void disableCamera() {
    setState(() {
      isCameraDisable = !isCameraDisable;
    });
    agoraEngine.enableLocalVideo(isCameraDisable);
  }

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    super.initState();

    // Set up an instance of Agora engine
    setupVideoSDKEngine();
  }

  Future<void> fetchToken() async {
    // Prepare the Url
    // String url = '$serverUrl/rtc/$channelName/${tokenRole.toString()}/uid/${uid.toString()}';

    // Send the request
    // final response = await http.get(Uri.parse(url));

    if (widget.response.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.
      Map<String, dynamic> json = jsonDecode(widget.response.body);
      String newToken = json['rtcToken'];
      debugPrint('Token Received: $newToken');
      // Use the token to join a channel or renew an expiring token
      setToken(newToken);
    } else {
      // If the server did not return an OK response,
      // then throw an exception.
      throw Exception(
          'Failed to fetch a token. Make sure that your server URL is valid');
    }
  }

  void setToken(String newToken) async {
    token = newToken;

    if (isTokenExpiring) {
      // Renew the token
      agoraEngine.renewToken(token);
      isTokenExpiring = false;
      showMessage("Token renewed");
    } else {
      // Join a channel.
      showMessage("Token received, joining a channel...");

      await agoraEngine.joinChannel(
        token: token,
        channelId: channelName,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          channelProfile: ChannelProfileType.channelProfileCommunication,
        ),
        uid: uid,
      );
    }
  }

  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();
    // uid = randomNumber() + 1;

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));

    await agoraEngine.enableVideo();

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    join();
  }

  void join() async {
    await agoraEngine.startPreview();

    // Set channel options including the client role and channel profile

    await fetchToken();
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });

    agoraEngine.leaveChannel();
    Navigator.pop(context);
  }

// Clean up the resources when you leave
  @override
  void dispose() async {
    // await agoraEngine.leaveChannel();
    agoraEngine.release();
    super.dispose();
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Get started with Video Calling'),
          ),
          body: Stack(
            // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            children: [
              // Container for the local video
              // this is different user video
              SizedBox(
                height: MediaQuery.of(context).size.height,
                // decoration: BoxDecoration(border: Border.all()),
                child: Center(child: _remoteVideo()),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: mute ? Colors.white : Colors.blue,
                            shape: BoxShape.circle),
                        child: IconButton(
                          icon: Icon(
                            mute ? Icons.mic : Icons.mic_off,
                            color: mute ? Colors.blue : Colors.white,
                          ),
                          onPressed: muteMic,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: IconButton(
                          icon: const Icon(
                            Icons.call_end,
                            color: Colors.blue,
                          ),
                          onPressed: leave,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: isCameraDisable ? Colors.white : Colors.blue,
                            shape: BoxShape.circle),
                        child: IconButton(
                            icon: Icon(
                              !isCameraDisable
                                  ? Icons.videocam_off
                                  : Icons.videocam,
                              color:
                                  isCameraDisable ? Colors.blue : Colors.white,
                            ),
                            onPressed: disableCamera),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: IconButton(
                            icon: const Icon(
                              Icons.cameraswitch,
                              color: Colors.blue,
                            ),
                            onPressed: switchCamera),
                      ),
                    ],
                  ),
                ),
              ),
              //end call button
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Padding(
              //     padding: const EdgeInsets.only(bottom: 30),
              //     child: Container(
              //       decoration: const BoxDecoration(
              //           color: Colors.white, shape: BoxShape.circle),
              //       child: IconButton(
              //         icon: const Icon(
              //           Icons.phone,
              //           color: Colors.blue,
              //         ),
              //         onPressed: leave,
              //       ),
              //     ),
              //   ),
              // ),
              // switch camera button
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Padding(
              //     padding: const EdgeInsets.only(bottom: 30, left: 200),
              //     child: Container(
              //       decoration: const BoxDecoration(
              //           color: Colors.white, shape: BoxShape.circle),
              //       child: IconButton(
              //         icon: const Icon(
              //           Icons.phone,
              //           color: Colors.blue,
              //         ),
              //         onPressed: muteMic,
              //       ),
              //     ),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Padding(
              //     padding: const EdgeInsets.only(bottom: 30, right: 150),
              //     child: Container(
              //       decoration: const BoxDecoration(
              //           color: Colors.white, shape: BoxShape.circle),
              //       child: IconButton(
              //           icon: const Icon(
              //             Icons.phone,
              //             color: Colors.blue,
              //           ),
              //           onPressed: disableCamera),
              //     ),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Padding(
              //     padding: const EdgeInsets.only(bottom: 30, right: 250),
              //     child: Container(
              //       decoration: const BoxDecoration(
              //           color: Colors.white, shape: BoxShape.circle),
              //       child: IconButton(
              //           icon: const Icon(
              //             Icons.phone,
              //             color: Colors.blue,
              //           ),
              //           onPressed: switchCamera),
              //     ),
              //   ),
              // ),

              // const SizedBox(height: 10),
              //Container for the Remote video

              //this is user video
              Padding(
                padding: const EdgeInsets.only(bottom: 150),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    width: 300,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: const Text(
                      "12345678910",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: Container(
                    height: 150,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Stack(children: [
                      Center(child: _localPreview()),
                      !isCameraDisable
                          ? Container(
                              height: 150,
                              width: 100,
                              color: Colors.black,
                              child: const Icon(
                                Icons.visibility_off,
                                color: Colors.white,
                              ),
                            )
                          : const SizedBox()
                    ]),
                  ),
                ),
              ),

              // Button Row
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //       child: ElevatedButton(
              //         onPressed: _isJoined ? null : () => {join()},
              //         child: const Text("Join"),
              //       ),
              //     ),
              //     const SizedBox(width: 10),
              //     Expanded(
              //       child: ElevatedButton(
              //         onPressed: _isJoined ? () => {leave()} : null,
              //         child: const Text("Leave"),
              //       ),
              //     ),
              //   ],
              // ),
              // Button Row ends
            ],
          )),
    );
  }

// Display local video preview
  Widget _localPreview() {
    if (_isJoined) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: agoraEngine,
          canvas: const VideoCanvas(uid: 0),
        ),
      );
    } else {
      return const Text(
        'Join a channel',
        textAlign: TextAlign.center,
      );
    }
  }

// Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: channelName),
        ),
      );
    } else {
      String msg = '';
      if (_isJoined) msg = 'Waiting for a remote user to join';
      return Text(
        msg,
        textAlign: TextAlign.center,
      );
    }
  }
}
