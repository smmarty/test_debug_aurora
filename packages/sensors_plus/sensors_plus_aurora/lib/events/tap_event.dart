// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause

/// Direction of tap. The last six directions may not be supported
/// depending on hardware.
enum TapDirection {
  /// Left or right side tapped
  x,

  /// Top or down side tapped
  y,

  /// Face or bottom tapped
  z,

  /// Tapped from left to right
  leftRight,

  /// Tapped from right to left
  rightLeft,

  /// Tapped from top to bottom
  topBottom,

  /// Tapped from bottom to top
  bottomTop,

  /// Tapped from face to back
  faceBack,

  /// Tapped from back to face
  backFace
}

/// Type of tap.
enum TapType {
  /// Double tap
  doubleTap,

  /// Single tap.
  singleTap
}

class TapEvent {
  TapEvent(this.direction, this.type);

  final TapDirection direction;

  final TapType type;

  @override
  String toString() => '[TapEvent (direction: $direction, level: $type)]';
}
