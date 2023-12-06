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
          "leftSec": 42,
        }
      });
}
