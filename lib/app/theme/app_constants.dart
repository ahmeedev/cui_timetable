class Constants {
  static var defaultPadding;
  static var defaultRadius;
  static var defaultElevation;
  static var iconSize;
  static var homeOverlaySize;
  static var lectureFlex;

  static initializeFields({
    required padding,
    required radius,
    required elevation,
    required icon,
    required overlaySize,
    required flex,
  }) {
    defaultPadding = padding;
    defaultRadius = radius;
    defaultElevation = elevation;
    iconSize = icon;
    homeOverlaySize = overlaySize;
    lectureFlex = flex;
  }
}
