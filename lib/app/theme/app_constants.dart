class Constants {
  static var defaultPadding;
  static var defaultRadius;
  static var defaultElevation;
  static var iconSize;
  static late double homeOverlaySize;
  static late int lectureFlex;
  static var imageWidth;
  static var imageHeight;
  static initializeFields({
    required padding,
    required radius,
    required elevation,
    required icon,
    required double overlaySize,
    required int flex,
    required IWidth,
    required IHeight,
  }) {
    defaultPadding = padding;
    defaultRadius = radius;
    defaultElevation = elevation;
    iconSize = icon;
    homeOverlaySize = overlaySize;
    lectureFlex = flex;
    imageHeight = IHeight;
    imageWidth = IWidth;
  }
}
