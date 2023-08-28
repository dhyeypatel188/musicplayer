import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/const/colors.dart';
import 'package:music/controller/player_controller.dart';
import 'package:music/views/player.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../const/text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          backgroundColor: bgDarkColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: whiteColor,
                ))
          ],
          leading: Icon(Icons.sort_rounded, color: whiteColor),
          title: Text(
            "Breats",
            style: ourStyle(weight: bold, size: 18, color: whiteColor),
          ),
        ),
        body: FutureBuilder<List<SongModel>>(
            future: controller.audioQuery.querySongs(
                ignoreCase: true,
                orderType: OrderType.ASC_OR_SMALLER,
                sortType: null,
                uriType: UriType.EXTERNAL),
            builder: (BuildContext context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                print(snapshot.data);
                return Center(
                  child: Text(
                    "no song found",
                    style: ourStyle(),
                  ),
                );
              } else {
                print(snapshot.data);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: Obx(
                            () => ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              tileColor: bgColor,
                              title: Text(
                                snapshot.data![index].displayNameWOExt,
                                style: ourStyle(weight: bold, size: 14),
                              ),
                              subtitle: Text(
                                "${snapshot.data![index].artist}",
                                style: ourStyle(weight: normal, size: 12),
                              ),
                              leading: QueryArtworkWidget(
                                id: snapshot.data![index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(
                                  Icons.music_note,
                                  color: whiteColor,
                                  size: 32,
                                ),
                              ),
                              trailing: controller.playIndex.value == index &&
                                      controller.isPlaying.value
                                  ? Icon(
                                      Icons.play_arrow,
                                      color: whiteColor,
                                      size: 26,
                                    )
                                  : null,
                              onTap: () {
                                Get.to(
                                    () => Player(
                                          data: snapshot.data!,
                                        ),
                                    transition: Transition.downToUp);
                                controller.playSong(
                                    snapshot.data![index].uri, index);
                              },
                            ),
                          ));
                    },
                  ),
                );
              }
            }));
  }
}
