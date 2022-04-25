// ignore_for_file: avoid_print

import 'package:card_game/app/data/models/player_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseProvider {
  static final lobbyStream = FirebaseFirestore.instance.collection('lobby');

  static Future<bool> findRoomById(String id) async {
    final data = await lobbyStream.doc(id).get();

    var isRoomValid = false;
    try {
      data.get('game_status');
      isRoomValid = false;
    } catch (e) {
      isRoomValid = true;
    }

    return (data.data() != null && isRoomValid);
  }

  static void addPlayerToLobby(String roomId, PlayerModel player) async {
    await lobbyStream.doc(roomId).update({
      'player_two_id': player.id,
      'player_two_username': player.name,
    }).catchError((err) => print(err));
  }

  static void createLobby(String roomId, PlayerModel player,
      List<Map<String, dynamic>> cards) async {
    await lobbyStream.doc(roomId).set({
      'player_one_id': player.id,
      'player_one_username': player.name,
      'cards': cards
    }).catchError((err) => print(err));
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> gameStream(
      String roomId) {
    return lobbyStream.doc(roomId).snapshots();
  }

  static void startGame(String roomId, PlayerModel player) async {
    await lobbyStream
        .doc(roomId)
        .update({'game_status': 'start'}).catchError((err) => print(err));
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> fetchLobby(
      String roomId) async {
    return await lobbyStream.doc(roomId).get();
  }

  static void gameEnded(String roomId, String winner) async {
    await lobbyStream.doc(roomId).update(
      {'game_status': 'end', 'winner': winner},
    ).catchError(
      (err) => print(err),
    );
  }

  static void deleteRoomById(String roomId) async {
    await lobbyStream.doc(roomId).delete().catchError((err) => print(err));
  }

  static void leftLobby(String roomId) async {
    await lobbyStream.doc(roomId).update({
      'player_two_id': FieldValue.delete(),
      'player_two_username': FieldValue.delete()
    }).catchError((err) => print(err));
  }
}
