// inspired by ScreenUtill pub

import 'package:flutter/material.dart';

/// This will be used to costomize game table and it will make it
/// look same in all devices decpite orientationn and other staff

/// default values if no configuration was passed with [init]
const double gameWidth = 375;
const double gameHeight = 812;
const double gameBottomBar = 142;
const double gameRatio = gameWidth / gameHeight;

class Sizer {
  // Managable settings
  static double w = gameWidth;
  static double h = gameHeight;
  static double _ratio = gameRatio;

  static Sizer instance = Sizer();

  static late double _actualHeight;
  static late double _actualHeightOfDevice;
  static late double _actualWidth;
  static late double _textScaleFactor;

  /// If device is long or wider then when you
  /// try to drag some object like throw, device API
  /// will return value based on general position
  /// that is why we have to calculate difference
  static double _deviceHeightDifference = 0;
  static double _deviceWidthtDifference = 0;

  /// This value will be used to check does it
  /// if header space of game table is big
  /// enough to set new back and voice button here
  static late bool _isTopSpaceBigEnough;

  void init(
      {required BuildContext context,
      double gameWidth = gameWidth,
      double gameHeight = gameHeight,
      double gameRatio = gameRatio}) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    w = gameWidth;
    h = gameHeight;
    _ratio = gameRatio;

    // as we know ratio is width/height
    final double width = mediaQuery.size.width;
    final double height = mediaQuery.size.height;
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
  double getSp(num fontSize, {bool? allowFontScalingSelf}) =>
      (fontSize * scaleWidth) / _textScaleFactor;
}
