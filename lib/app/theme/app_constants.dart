class Constants {
  static var defaultPadding;
  static var defaultRadius;
  static var defaultElevation;
  static var iconSize;

  static initializeFields(
      {required padding, required radius, required elevation, required icon}) {
    defaultPadding = padding;
    defaultRadius = radius;
    defaultElevation = elevation;
    iconSize = icon;
  }
}
