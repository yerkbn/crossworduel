import 'package:crossworduel/game/core/mock/mock.dart';

class MockGame extends MockParent {
  final MockCore core;

  MockGame(MockConfig config)
      : core = MockCore(config),
        super(config);

  @override
  void runTest() {
    super.runTest();
    roomCreated(duration: 250);
    playerFound(duration: 500);
    running(duration: 500);
  }

  // Room created
  void roomCreated({
    required int duration,
  }) =>
      execute(duration: duration, input: {
        "status": "ROOM_CREATED",
        "data": {
          "ownData": {
            "username": "@jacob",
            "id": cpId,
            "avatar": "https://shoq.ai:4002/studimage/default/small/8.jpg",
            "point": 1200,
            "progressPoint": 1200,
          },
          "roomId": "1222"
        }
      });

  // PLAYER FOUND
  void playerFound({
    required int duration,
  }) =>
      execute(duration: duration, input: {
        "status": "PLAYER_FOUND",
        "data": {
          "subjectId": "1",
          "players": [
            {
              "username": "@jacob",
              "id": cpId,
              "avatar": "https://shoq.ai:4002/studimage/default/small/8.jpg",
              "point": 1200,
              "progressPoint": 100,
            },
            {
              "username": "@jacob",
              "id": "1",
              "avatar": "https://shoq.ai:4002/studimage/default/small/7.jpg",
              "point": 1200,
              "progressPoint": 300,
            }
          ]
        }
      });

  // RUNNING
  void running({
    required int duration,
  }) =>
      execute(duration: duration, input: {
        "status": "RUNING_INST",
        "data": {
          "question": {
            "text": null,
            "id": 1,
            "question":
                """"<p>Which of the following is a synonym for "vivid"?</p>"""
                    "",
            "image": "",
            "answers": [
              {"id": 1, "answer": "Dull", "image": ""},
              {"id": 2, "answer": "Bright", "image": ""},
              {"id": 3, "answer": "Quiet", "image": ""},
              {"id": 4, "answer": "Sad", "image": ""},
            ],
            "correctAnswerIds": [2]
          },
          "seconds": 5
        }
      });

  // MOVE
  void move({required int duration, required String playerId}) =>
      execute(duration: duration, input: {
        "status": "MOVE_TURN",
        "data": {
          "player": {
            "username": "@jacob",
            "id": playerId,
            "avatar": "https://shoq.ai:4002/studimage/default/small/7.jpg",
            "point": 100,
            "progressPoint": 340,
          },
          "answerId": 1,
          "playerId": playerId,
          "isBotMoved": false,
          "isCorrect": true
        }
      });

  // RESULT
  void result({
    required int duration,
  }) =>
      execute(duration: duration, input: {
        "status": "RESULT_INST",
        "data": {
          "playersData": [
            {
              "username": "@jacob",
              "id": cpId,
              "avatar": "https://shoq.ai:4002/studimage/default/small/8.jpg",
              "point": 1200,
              "progressPoint": 455,
            },
            {
              "username": "@ethan",
              "id": "1",
              "avatar": "https://shoq.ai:4002/studimage/default/small/7.jpg",
              "point": 322,
              "progressPoint": 211,
            }
          ],
          "correctAnswerId": 1,
          "selections": [
            {"playerId": cpId, "answerId": 1},
            {"playerId": "1", "answerId": 1}
          ]
        }
      });

  // FINAL
  void finalIns({
    required int duration,
  }) =>
      execute(duration: duration, input: {
        "status": "FINAL_INST",
        "data": {
          "players": [
            {
              "username": "@jacob",
              "id": cpId,
              "avatar": "https://shoq.ai:4002/studimage/default/small/8.jpg",
              "point": 0,
              "progressPoint": 0,
            },
            {
              "username": "@ethan",
              "id": "1",
              "avatar": "https://shoq.ai:4002/studimage/default/small/7.jpg",
              "point": 0,
              "progressPoint": 0,
            }
          ],
          "winnerPlayerId": cpId,
          "delta": 2
        }
      });

// Rejoin
  void rejoin({required int duration}) => execute(duration: duration, input: {
        "status": "MOVE_REJOIN",
        "data": {"playerId": 10019}
      });

// Rejoin
  void timeout({required int duration}) => execute(
      duration: duration, input: {"status": "UTIL_INVITE_TIMEOUT", "data": {}});
}
