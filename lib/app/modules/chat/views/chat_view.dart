import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/chat/pages/ChatRoom.dart';
import 'package:taleb/app/modules/chat/widgets/message_form.dart';
import 'package:taleb/app/modules/home/widgets/comment_form.dart';
import 'package:taleb/main.dart';

import '../controllers/chat_controller.dart';

class ChatView extends StatefulWidget {
  const ChatView({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  final ChatController controller = Get.put(ChatController());
  String _selected = "null";
  String _idmessage = "2";
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<ChatMessage> messages = [
      ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
      ChatMessage(
          messageContent: "How have you been?", messageType: "receiver"),
      ChatMessage(
          messageContent: "Hey Kriss, I am doing fine dude. wbu?",
          messageType: "sender"),
      ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
      ChatMessage(
          messageContent: "Is there any thing wrong?", messageType: "sender"),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("Admin"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, true),
          ),
          actions: [
            if (_selected != "null")
              IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    try {
                      controller.delet_message("$_idmessage");
                      setState(() {
                        _selected = "null";
                      });
                    } catch (e) {
                      print(e);
                    }
                    print(_idmessage);
                  })
          ]),
      body: InkWell(
        onTap: () {
          setState(() {
            _selected = "null";
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
          ),
          child: CommentBox(
            // userImage: CommentBox.commentImageParser(
            //     imageURLorPath:
            //         "https://th.bing.com/th/id/OIP.ysdd9pBlwnNdnxQoC8y4KQHaHa?pid=ImgDet&rs=1"),

            // ignore: sort_child_properties_last
            child: FutureBuilder(
              future: controller.showmessage(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Color.fromARGB(255, 246, 154, 7),
                      size: 40,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Image.asset(
                      "assets/icons/error.png",
                      width: AppConstant.screenWidth * .8,
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No data available"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () {
                          setState(() {
                            _selected = "ee";
                            _idmessage =
                                "${snapshot.data[index]['id_message']}";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment:
                                (snapshot.data[index]['user_to_admin'] == 1
                                    ? Alignment.topRight
                                    : Alignment.topLeft),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                    (snapshot.data[index]['user_to_admin'] == 1
                                        ? Colors.blue[200]
                                        : Colors.grey.shade200),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(
                                snapshot.data[index]['message'],
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),

            labelText:
                _messageController.text.length > 0 ? "" : 'Write a message...',
            withBorder: false,
            sendButtonMethod: () async {
              if (formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();

                try {
                  await controller.sendmessage(
                    "${_messageController.text}",
                  );
                } catch (e) {
                  print(e);
                }

                _messageController.clear();
                FocusScope.of(context).unfocus();
                setState(() {});
              } else {
                print("Not validat:ed");
              }
            },
            formKey: formKey,
            commentController: _messageController,
            backgroundColor: Color.fromARGB(147, 189, 187, 187),
            textColor: Colors.black,
            sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
