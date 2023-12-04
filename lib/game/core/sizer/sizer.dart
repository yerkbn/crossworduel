// inspired by ScreenUtill pub

import 'package:flutter/material.dart';

/// This will be used to costomize game table and it will make it
/// look same in all devices decpite orientationn and other staff

const double SIZER_WIDTH = 1170;
const double SIZER_HEIGHT = 2532;
const double SIZER_RATIO = SIZER_WIDTH / SIZER_HEIGHT;

class Sizer {
  // Managable settings
  static double w = SIZER_WIDTH;
  static double h = SIZER_HEIGHT;
  static double _ratio = SIZER_RATIO;

  static Sizer instance = new Sizer();
  static double _actualHeight = 0;
  static double _actualHeightOfDevice = 0;
  static double _actualWidth = 0;
  static double _textScaleFactor = 0;

  /// If device is long or wider then when you
  /// try to drag some object like throw, device API
  /// will return value based on general position
  /// that is why we have to calculate difference
  static double _deviceHeightDifference = 0;
  static double _deviceWidthtDifference = 0;

  /// This value will be used to check does it
  /// if header space of game table is big
  /// enough to set new back and voice button here
  static bool _isTopSpaceBigEnough = true;

  void init(
      {required BuildContext context,
      double gameWidth = SIZER_WIDTH,
      double gameHeight = SIZER_HEIGHT,
      double gameRatio = SIZER_RATIO}) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    w = gameWidth;
    h = gameHeight;
    _ratio = gameRatio;

    // as we know ratio is width/height
    double width = mediaQuery.size.width;
    double height = mediaQuery.size.height;
    _textScaleFactor = mediaQuery.textScaleFactor;
    _actualHeightOfDevice = height;
    if (width / height > _ratio) {
      // it means that device width is wider
      // that is why we getheight as max
      _isTopSpaceBigEnough = false;
      _actualHeight = height;
      _actualWidth = _ratio * height;
      _deviceWidthtDifference = (width - _actualWidth) / (scaleWidth * 2);
    } else {
      // width will be max value
      _actualWidth = width;
      _actualHeight = width * 1 / _ratio;
      _deviceHeightDifference = (height - _actualHeight) / scaleHeight;

      /// Check, If divce will be long vertically and free
      /// space in top is bigger than 150px then we will
      /// set [_isTopSpaceBigEnough] to true in that case game header
      /// will have enough space to fit there
      if ((height - _actualHeight) > getHeight(150)) {
        _isTopSpaceBigEnough = true;
      } else {
        _isTopSpaceBigEnough = false;
      }
    }
  }

  /// The ratio of the actual dp to the design draft px
  bool get isTopSpaceBigEnough => _isTopSpaceBigEnough;
  double get scaleWidth => _actualWidth / w;
  double get scaleHeight => _actualHeight / h;
  double get scaleHeightOfDevice =>
      _actualHeightOfDevice / h; // in dragible item will use it
  double get getDeviceHeightDifference => _deviceHeightDifference;
  double get getDeviceWidthDifference => _deviceWidthtDifference;
  double getWidth(double width) => width * scaleWidth;
  double getHeight(double height) => height * scaleHeight;
  double getFont(double size) => size * scaleWidth;
  double getSp(num fontSize) => ((fontSize * scaleWidth) / _textScaleFactor);
}
