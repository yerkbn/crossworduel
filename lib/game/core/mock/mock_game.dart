import 'package:crossworduel/game/core/crossword/crossoword_picker_manager.dart';
import 'package:crossworduel/game/core/mock/mock.dart';

class MockGame extends MockParent {
  final MockCore core;

  MockGame(super.config) : core = MockCore(config);

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
  Future<void> running({required int duration}) async {
    final CrosswordPickerManager picker = await CrosswordPickerManager.create();
    return execute(duration: duration, input: {
      "status": "RUNING_INST",
      "data": {
        "leftSec": 300,
        "spans": picker.pick()

        // [
        //   {
        //     "point": {"x": 0, "y": 0},
        //     "vert": false,
        //     "length": 6,
        //     "answer": "AVATAR",
        //     "clue": "James Cameron movie",
        //   },
        //   {
        //     "point": {"x": 5, "y": 0},
        //     "vert": true,
        //     "length": 5,
        //     "answer": "RADIO",
        //     "clue": "RADIO",
        //   },
        // ]
      }
    });
  }
}
