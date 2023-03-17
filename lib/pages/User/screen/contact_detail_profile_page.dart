import 'package:agoratestapp/video_call_page.dart';
import 'package:agoratestapp/pages/User/screen/agora_uikit.dart';
import 'package:agoratestapp/shared/shared%20methods/random_number_generator.dart';
import 'package:agoratestapp/shared/shared%20methods/word_generator.dart';
import 'package:agoratestapp/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactDetailProfilePage extends StatefulWidget {
  const ContactDetailProfilePage({super.key});

  @override
  State<ContactDetailProfilePage> createState() =>
      _ContactDetailProfilePageState();
}

class _ContactDetailProfilePageState extends State<ContactDetailProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          // channelName = generateRandomString(8);
          uid = randomNumber() + 1;

          String url =
              '$serverUrl/rtc/$channelName/${tokenRole.toString()}/uid/${uid.toString()}';

          // Send the request
          var response = await http.get(Uri.parse(url));
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoCallPage(
                  // urlResponse: response,
                  response: response,
                ),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 50, bottom: 40),
          child: Container(
            width: 120,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.videocam,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Video",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                )
              ],
            ),
          ),
        ),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 250),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  image: DecorationImage(
                      image: NetworkImage(
                        "https://www.americanhumane.org/app/uploads/2022/01/Emperor-penguin2.png",
                      ),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Farah Mohammed",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "FarahMohammed@gmail.com",
              style:
                  TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.6)),
            ),
            // Spacer(
            //   flex: 1,
            // ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Row(
            //     children: [
            //       IconButton(onPressed: () {}, icon: const Icon(Icons.videocam))
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
