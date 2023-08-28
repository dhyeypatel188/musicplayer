import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unnecessary_import
import 'package:get/get_core/src/get_main.dart';
import 'package:music/const/colors.dart';
import 'package:music/const/text.dart';
import 'package:music/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;

  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Column(
        children: [
          Obx(
            () => Expanded(
                child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: QueryArtworkWidget(
                      id: data[controller.playIndex.value].id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: double.infinity,
                      artworkWidth: double.infinity,
                    ))),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.012,
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: whiteColor),
            child: Obx(
              () => Column(
                children: [
                  Text(
                    data[controller.playIndex.value].displayNameWOExt,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: ourStyle(color: bgColor, weight: bold, size: 24),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.012,
                  ),
                  Text(
                    data[controller.playIndex.value].artist.toString(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: ourStyle(color: bgColor, weight: normal, size: 20),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.012,
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Text(
                          controller.possition.value,
                          style: ourStyle(color: bgDarkColor),
                        ),
                        Expanded(
                            child: Slider(
                                thumbColor: sliderColor,
                                inactiveColor: bgColor,
                                activeColor: sliderColor,
                                min: const Duration(seconds: 0)
                                    .inSeconds
                                    .toDouble(),
                                max: controller.max.value,
                                value: controller.value.value,
                                onChanged: (newValue) {
                                  controller.changeDurationToSeconds(
                                      newValue.toInt());
                                  newValue = newValue;
                                })),
                        Text(
                          controller.duration.value,
                          style: ourStyle(color: bgDarkColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.012,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.playSong(
                              data[controller.playIndex.value - 1].uri,
                              controller.playIndex.value - 1);
                        },
                        icon: Icon(
                          Icons.skip_previous_rounded,
                          size: 40,
                          color: bgDarkColor,
                        ),
                      ),
                      Obx(
                        () => CircleAvatar(
                          radius: 35,
                          backgroundColor: bgDarkColor,
                          child: Transform.scale(
                            scale: 2.5,
                            child: IconButton(
                                onPressed: () {
                                  if (controller.isPlaying.value) {
                                    controller.audioPlayer.pause();
                                    controller.isPlaying(false);
                                  } else {
                                    controller.audioPlayer.play();
                                    controller.isPlaying(true);
                                  }
                                },
                                icon: controller.isPlaying.value
                                    ? const Icon(
                                        Icons.pause,
                                        color: whiteColor,
                                      )
                                    : const Icon(
                                        Icons.play_arrow_rounded,
                                        color: whiteColor,
                                      )),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.playSong(
                              data[controller.playIndex.value + 1].uri,
                              controller.playIndex.value + 1);
                        },
                        icon: Icon(Icons.skip_next_rounded, size: 40),
                        color: bgDarkColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
