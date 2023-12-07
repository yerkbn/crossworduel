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
    running(duration: 600);
  }

  // Room created
  void roomCreated({
    required int duration,
  }) =>
      execute(duration: duration, input: {
        "status": "ROOM_CREATED",
        "data": {
          "me": {
            "id": cpId,
            "username": "@jacob",
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
          "players": [
            {
              "username": "",
              "id": cpId,
              "avatar": "",
              "point": 1200,
              "progressPoint": 100,
            },
            {
              "username": "elonmusk",
              "id": "2",
              "avatar": "https://avatarfiles.alphacoders.com/359/359314.png",
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
          "leftSec": 300,
          "items": [
            {"index": 0, "value": "A"},
            {"index": 1, "value": "V"},
            {"index": 2, "value": "A"},
            {"index": 3, "value": "T"},
            {"index": 4, "value": "A"},
            {"index": 5, "value": "R"},
            {"index": 15, "value": "A"},
            {"index": 16, "value": "P"},
            {"index": 17, "value": "P"},
            {"index": 18, "value": "L"},
            {"index": 19, "value": "E"},
            //
            {"index": 22, "value": "I"},
            {"index": 23, "value": "P"},
            {"index": 24, "value": "A"},
            {"index": 25, "value": "D"},
            //
            {"index": 35, "value": "I"},
            {"index": 45, "value": "O"}
          ]
        }
      });
}
