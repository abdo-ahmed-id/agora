import 'package:agoratestapp/pages/User/screen/contact_detail_profile_page.dart';
import 'package:agoratestapp/pages/User/screen/contact_list_list_tile.dart';
import 'package:flutter/material.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Padding(
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
                "New",
                style: TextStyle(color: Colors.white, fontSize: 22),
              )
            ],
          ),
        ),
      ),
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 100,
      title: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.blue.withOpacity(0.2),
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none),
                      hintText: "Search for name",
                      // fillColor: Colors.blue[200]!.withOpacity(0.5),
                      // filled: true,
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  alignment: Alignment.center,
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red[600]),
                  child: Text("Farah".substring(0, 1),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 24)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactDetailProfilePage(),
                    ));
              },
              child: const ContactListTile());
        },
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(),
          );
        },
        itemCount: 10);
  }
}
