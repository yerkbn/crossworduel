import 'dart:convert';

class MockConfig {
  final void Function(String input) onMessage; // It is called from socket
  final String currentPlayer;

  MockConfig({required this.onMessage, required this.currentPlayer});
}

/// All mocks have to extend it
abstract class MockParent {
  final MockConfig config;

  void Function(String input) get onMessage => config.onMessage;
  String get cpId => config.currentPlayer; // current player id

  MockParent(this.config); // current player id

  /// This method can be overriden to
  /// build own customized test
  void runTest() {}

  /// Will execute some code after some delay
  void execute({required int duration, required Map input}) {
    Future.delayed(Duration(milliseconds: duration), () {
      _encoder(input);
    });
  }

  /// This will transform map instructions to string
  void _encoder(Map objectMap) {
    onMessage(json.encode(objectMap));
  }
}

/// Core implementation of instructions
/// collections can be retrived from here
class MockCore extends MockParent {
  MockCore(MockConfig config) : super(config);

  void joined(
          {required int duration, required int id, required int tablePlace}) =>
      execute(duration: duration, input: {
        "status": "PLAYER_JOINED",
        "data": {
          "id": id,
          "username": "Toxic",
          "avatar":
              "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRfgfaVWZurBjIvSfonF0ubvrhBh0bjZDP5zuAfBO52rqcZvNEt&usqp=CAU",
          "tablePlace": tablePlace,
          "playersShowData": [
            {"playerId": cpId, "chips": 60800, "onHat": null},
            {"playerId": id, "chips": 24080, "onHat": null},
          ]
        }
      });

  void leave({
    required int duration,
    required int id,
  }) =>
      execute(duration: duration, input: {
        "status": "PLAYER_LEAVE",
        "data": {'playerId': id, 'playersShowData': []}
      });

  void roomCreated({
    required int duration,
  }) =>
      execute(duration: duration, input: {
        "status": "ROOM_CREATED",
        "data": {
          "roomName": 'Salem Alem',
          "roomId": 1000,
          "ownData": {
            "chipsCount": 60800,
            "throwables": [
              {
                "id": 1,
                "title": "Помидоры",
                "description": "Кинь помидор тому, кто заслуживает унижения",
                "priceRange": [],
                "amount": 72
              },
              {
                "id": 2,
                "title": "Тухлые яйца",
                "description":
                    "Кинь тухлое яйцо тому, кто заслуживает унижения",
                "priceRange": [],
                "amount": 12
              }
            ],
            "onHat": null
          },
          "playersShowData": [
            {"playerId": cpId, "chips": 60800, "onHat": null}
          ]
        }
      });
}
