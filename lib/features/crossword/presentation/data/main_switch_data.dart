import 'package:crossworduel/core/design-system/page_switcher/switch_data.dart';
import 'package:crossworduel/gen/assets.gen.dart';

class MainSwitchData extends SwitchData {
  MainSwitchData({
    required super.title,
    required super.value,
    required super.order,
    required super.imagePath,
  });

  factory MainSwitchData.my() {
    return MainSwitchData(
        title: "My", value: 'my', order: 0, imagePath: Assets.icons.pen.path);
  }

  factory MainSwitchData.world() {
    return MainSwitchData(
        title: "World",
        value: 'world',
        order: 1,
        imagePath: Assets.icons.world.path);
  }

  factory MainSwitchData.history() {
    return MainSwitchData(
        title: "History",
        value: 'history',
        order: 2,
        imagePath: Assets.icons.folder.path);
  }

  static List<MainSwitchData> getCategories() {
    return [
      MainSwitchData.my(),
      MainSwitchData.world(),
      MainSwitchData.history(),
    ];
  }

  static MainSwitchData getCategoryByOrder(int order) {
    final List<MainSwitchData> allCats = getCategories();
    for (final MainSwitchData cat in allCats) {
      if (cat.order == order) {
        return cat;
      }
    }
    return allCats[0];
  }
}
