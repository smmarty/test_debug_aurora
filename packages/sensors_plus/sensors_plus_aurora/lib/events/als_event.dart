// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause

class ALSEvent {
  ALSEvent(this.degrees);

  final int degrees;

  @override
  String toString() => '[ALSEvent (degrees: $degrees)]';
}
