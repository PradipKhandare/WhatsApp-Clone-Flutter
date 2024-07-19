import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_express_mongo/custom_ui/own_file_card.dart';
import 'package:flutter_node_express_mongo/custom_ui/own_message_card.dart';
import 'package:flutter_node_express_mongo/custom_ui/reply_card.dart';
import 'package:flutter_node_express_mongo/model/chat_model.dart';
import 'package:flutter_node_express_mongo/model/message_model.dart';
import 'package:flutter_node_express_mongo/screens/camera_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../custom_ui/reply_file_card.dart';
import 'camera_screen.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage({super.key, required this.chatModel, this.sourceChat});

  final ChatModel chatModel;
  final ChatModel? sourceChat;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  FocusNode focusNode = FocusNode();
  bool show = false;
  TextEditingController textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  ImagePicker _imagePicker = ImagePicker();
  late XFile file;

  late IO.Socket socket;

  bool sendButton = false;
  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void connect() {
    socket = IO.io(
        "http://192.168.0.72:6000",
        <String, dynamic>{
          "transports": ["websocket"],
          "autoConnect": false,
        });
    socket.connect();
    socket.emit("signin", widget.sourceChat!.id);
    socket.onConnect((data) {
      print('Connected');
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"], msg["path"]);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket.connected);
  }

  void onImageSend(String path) {
    print("------>>>>>>>>>>>>Hey there path is ${path}");
  }

  void sendMessage(String message, int sourceId, int targetId, String path) {
    setMessage("source", message, path);
    socket.emit(
      "message",
      {
        "message": message,
        "sourceId": sourceId,
        "targetId": targetId,
        "path": path
      },
    );
  }

  void setMessage(String type, String message, String path) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        path: path,
        time: DateTime.now().toString().substring(10, 16));
    setState(() {
      setState(() {
        messages.add(messageModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/whatsapp_Back.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 70,
            titleSpacing: 0,
            backgroundColor: Theme.of(context).primaryColor,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blueGrey,
                    child: SvgPicture.asset(
                      widget.chatModel.isGroup!
                          ? "assets/group.svg"
                          : "assets/person.svg",
                      color: Colors.white,
                      height: 36,
                      width: 36,
                    ),
                  ),
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.name!,
                      style: const TextStyle(
                          fontSize: 18.5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Last seen today at 01:02",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.videocam,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                  color: Colors.white,
                ),
              ),
              IconTheme(
                data: const IconThemeData(color: Colors.white),
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 'View contact',
                        child: Text('View contact'),
                      ),
                      const PopupMenuItem(
                        value: 'Media, links and docs',
                        child: Text('Media, links and docs'),
                      ),
                      const PopupMenuItem(
                        value: 'Whatsapp web',
                        child: Text('WhatsApp web'),
                      ),
                      const PopupMenuItem(
                        value: 'Search',
                        child: Text('Search'),
                      ),
                      const PopupMenuItem(
                        value: 'Mute Notification',
                        child: Text('Mute Notification'),
                      ),
                      const PopupMenuItem(
                        value: 'Wallpaper',
                        child: Text('Wallpaper'),
                      ),
                    ];
                  },
                ),
              ),
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: () {
                if (show == true) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
              child: Column(
                children: [
                  Expanded(
                    //height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source") {
                          return OwnMessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else {
                          return ReplyMessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      },
                      shrinkWrap: true,
                    ),
                    // child: ListView(
                    //   children: [
                    //     OwnFileCard(),
                    //     ReplyFileCard(),
                    //   ],
                    // ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                  margin: const EdgeInsets.only(
                                    left: 2,
                                    right: 2,
                                    bottom: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    controller: textEditingController,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 6,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      contentPadding: const EdgeInsets.all(5),
                                      prefixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                            show = !show;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.emoji_emotions,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (builder) =>
                                                    bottomSheet(),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.attach_file,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (builder) =>
                                                      CameraScreen(
                                                    onImageSend: onImageSend,
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.camera_alt,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, right: 5, left: 2),
                                child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  radius: 25,
                                  child: IconButton(
                                    onPressed: () {
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                        sendMessage(
                                            textEditingController.text,
                                            widget.sourceChat!.id!,
                                            widget.chatModel!.id!,
                                            "");
                                        textEditingController.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      sendButton ? Icons.send : Icons.mic,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.insert_drive_file,
                    Colors.indigo,
                    'Documents',
                    () async {},
                  ),

                  const SizedBox(
                    width: 40,
                  ),

                  iconCreation(Icons.camera_alt, Colors.pink, 'Camera',
                      () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => CameraScreen(
                          onImageSend: onImageSend,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, 'Gallery', () async {
                    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => CameraViewPage(
                            path: pickedFile.path,
                            onImageSend: onImageSend,
                          ),
                        ),
                      );
                    } else {
                      // Handle the case where no image was selected
                      print("No image selected.");
                    }
                  }),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.headset, Colors.orange, 'Audio', () async {}),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(
                      Icons.location_pin, Colors.teal, 'Location', () async {}),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(
                      Icons.person, Colors.blue, 'Contact', () async {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(
      IconData icon, Color color, String text, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      onEmojiSelected: (category, Emoji emoji) {
        setState(() {
          textEditingController.text = textEditingController.text + emoji.emoji;
        });
      },
      config: Config(
        height: 256,
        checkPlatformCompatibility: true,
        emojiViewConfig: EmojiViewConfig(
          emojiSizeMax: 28 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.20
                  : 1.0),
        ),
        swapCategoryAndBottomBar: false,
        skinToneConfig: const SkinToneConfig(),
        categoryViewConfig: const CategoryViewConfig(),
        bottomActionBarConfig: const BottomActionBarConfig(),
        searchViewConfig: const SearchViewConfig(),
      ),
    );
  }
}
