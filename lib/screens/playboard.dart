import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';
import 'package:tic_tac_toe/utilities/custom_colors.dart';
import 'package:tic_tac_toe/widgets/text.dart';
import 'package:tic_tac_toe/widgets/circle.dart';
import 'package:tic_tac_toe/widgets/cross.dart';
import 'package:tic_tac_toe/widgets/my_painer.dart';

class PlayBoard extends StatefulWidget {
  @override
  _PlayBoardState createState() => _PlayBoardState();
}

class _PlayBoardState extends State<PlayBoard> {
  GameController _controller = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _controller.init(0);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: BODY_COLOR,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_sharp,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.replay_outlined,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () => _controller.tossPopUp(context),
              ),
            ],
          ),
          body: Container(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Obx(
                          () => CircleAvatar(
                            backgroundColor: _controller.cpuPlaying.value
                                ? Colors.transparent
                                : Colors.green,
                            radius: 50,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(
                                FirebaseAuth.instance.currentUser!.photoURL!,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Txt('VS', size: 30),
                        Spacer(),
                        Obx(
                          () => CircleAvatar(
                            backgroundColor: !_controller.cpuPlaying.value
                                ? Colors.transparent
                                : Colors.green,
                            radius: 50,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: AssetImage(
                                'assets/Images/bot.png',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.4),
                          child: Txt(
                            FirebaseAuth.instance.currentUser!.displayName!
                                .toUpperCase(),
                            size: 14,
                          ),
                        ),
                        Spacer(),
                        Txt('CPU', size: 14),
                        SizedBox(width: 40),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Stack(
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width + 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GridView.builder(
                          padding: EdgeInsets.all(0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: 9,
                          itemBuilder: (ctx, i) => Obx(
                            () => InkWell(
                              onTap: () {
                                if (!_controller.cpuPlaying.value)
                                  _controller.playgame(i, context);
                              },
                              child: Card(
                                color: TILE_COLOR.withOpacity(0.9),
                                margin: EdgeInsets.all(5),
                                elevation: _controller.board[(i / 3).floor()]
                                            [i % 3] !=
                                        '_'
                                    ? 0
                                    : 7,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  padding: _controller.board[(i / 3).floor()]
                                              [i % 3] ==
                                          'x'
                                      ? EdgeInsets.all(10)
                                      : EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    child: _controller.board[(i / 3).floor()]
                                                [i % 3] ==
                                            'o'
                                        ? Circle()
                                        : _controller.board[(i / 3).floor()]
                                                    [i % 3] ==
                                                'x'
                                            ? Cross()
                                            : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => CustomPaint(
                        painter: _controller.result.value == 0
                            ? null
                            : MyPainter(_controller.result.value, context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
