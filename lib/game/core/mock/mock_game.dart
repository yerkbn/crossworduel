import 'package:crossworduel/game/core/crossword/crossword_generator.dart';
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
  Future<void> running({
    required int duration,
  }) async {
    await CrosswordGenerator.crosswordGenerate();
    return execute(duration: duration, input: {
      "status": "RUNING_INST",
      "data": {
        "leftSec": 300,
        "spans": [
          {
            "point": {"x": 0, "y": 0},
            "vert": false,
            "length": 6,
            "answer": "AVATAR",
            "clue": "James Cameron movie",
          },
          {
            "point": {"x": 5, "y": 0},
            "vert": true,
            "length": 5,
            "answer": "RADIO",
            "clue": "RADIO",
          },
        ]
      }
    });
  }
}





  // RUNNING
  // void running({
  //   required int duration,
  // }) async {
  //   await Crossword.crosswordGenerate();
  //   return execute(duration: duration, input: {
  //     "status": "RUNING_INST",
  //     "data": {
  //       "leftSec": 300,
  //       "items": [
  //         {"index": 0, "value": "A"},
  //         {"index": 1, "value": "V"},
  //         {"index": 2, "value": "A"},
  //         {"index": 3, "value": "T"},
  //         {"index": 4, "value": "A"},
  //         {"index": 5, "value": "R"},
  //         {"index": 15, "value": "A"},
  //         {"index": 16, "value": "P"},
  //         {"index": 17, "value": "P"},
  //         {"index": 18, "value": "L"},
  //         {"index": 19, "value": "E"},
  //         {"index": 22, "value": "I"},
  //         {"index": 23, "value": "P"},
  //         {"index": 24, "value": "A"},
  //         {"index": 25, "value": "D"},
  //         {"index": 35, "value": "I"},
  //         {"index": 45, "value": "O"}
  //       ],
  //       "hints": [
  //         {
  //           "indexes": [0, 1, 2, 3, 4, 5],
  //           "hint": "James Cameron movie",
  //           "isRow": true,
  //         },
  //         {
  //           "point": {"x": 0, "y": 0},
  //           "vert": false,
  //           "length": 6,
  //           "answer": "AVATAR",
  //           "clue": "James Cameron movie",
  //         },
  //         {
  //           "indexes": [0, 1, 2, 3, 4, 5],
  //           "hint": "James Cameron movie",
  //           "isRow": true,
  //         },
  //         {
  //           "indexes": [15, 16, 17, 18, 19],
  //           "hint": "World largest company",
  //           "isRow": true,
  //         },
  //         {
  //           "indexes": [5, 15, 25, 35, 45],
  //           "hint": "Previous to TV",
  //           "isRow": false,
  //         },
  //         {
  //           "indexes": [22, 23, 24, 25],
  //           "hint": "Not phone not computer, from Apple company",
  //           "isRow": true,
  //         },
  //       ]
  //     }
  //   });
  // }