// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause

class ProximityEvent {
  ProximityEvent(this.withinProximity);

  final bool withinProximity;

  @override
  String toString() => '[ProximityEvent (withinProximity: $withinProximity)]';
}
