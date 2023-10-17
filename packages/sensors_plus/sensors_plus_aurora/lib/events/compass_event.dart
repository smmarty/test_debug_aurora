// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause

class CompassEvent {
  CompassEvent(this.degrees, this.level);

  final int degrees;

  final int level;

  @override
  String toString() => '[CompassEvent (degrees: $degrees, level: $level)]';
}
