import 'package:docking/src/docking_drag.dart';
import 'package:docking/src/layout/docking_layout.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tabbed_view/tabbed_view.dart';

/// Represents a draggable widget mixin.
@internal
mixin DraggableConfigMixin {
  DraggableConfig buildDraggableConfig(
      {required DockingDrag dockingDrag, required TabData tabData}) {
    final DockingItem item = tabData.value;
    final name = item.name != null ? item.name! : '';
    return DraggableConfig(
        feedback: buildFeedback(name),
        dragAnchorStrategy: (Draggable<Object> draggable, BuildContext context,
                Offset position) =>
            const Offset(20, 20),
        onDragStarted: () {
          dockingDrag.enable = true;
        },
        onDragCompleted: () {
          dockingDrag.enable = false;
        });
  }

  Widget buildFeedback(String name) {
    return Material(
        child: Container(
            decoration:
                BoxDecoration(border: Border.all(), color: Colors.grey[300]),
            child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 0,
                  minWidth: 30,
                  maxHeight: double.infinity,
                  maxWidth: 150.0,
                ),
                child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(name, overflow: TextOverflow.ellipsis)))));
  }
}
