import 'package:docking/src/internal/layout/layout_modifier.dart';
import 'package:docking/src/layout/docking_layout.dart';
import 'package:meta/meta.dart';

/// Removes [DockingItem] from this layout.
@internal
class RemoveItem extends LayoutModifier {
  RemoveItem({required this.itemToRemove});

  final DockingItem itemToRemove;

  @override
  void validate(DockingLayout layout, DockingArea area) {
    super.validate(layout, area);
    if (area.layoutId != layout.id) {
      throw ArgumentError(
          'DockingArea belongs to another layout. Keep the layout in the state of your StatefulWidget.');
    }
  }

  @override
  DockingArea? newLayout(DockingLayout layout) {
    validate(layout, itemToRemove);
    if (layout.root != null) {
      return _buildLayout(layout.root!);
    }
    return null;
  }

  /// Builds a new root.
  DockingArea? _buildLayout(DockingArea area) {
    if (area is DockingItem) {
      final dockingItem = area;
      if (dockingItem == itemToRemove) {
        return null;
      }
      return dockingItem;
    } else if (area is DockingTabs) {
      final dockingTabs = area;
      final children = <DockingItem>[];
      dockingTabs.forEach((child) {
        if (child != itemToRemove) {
          children.add(child);
        }
      });
      if (children.length == 1) {
        return children.first;
      }
      final newDockingTabs = DockingTabs(children,
          maximized: dockingTabs.maximized,
          maximizable: dockingTabs.maximizable);
      newDockingTabs.selectedIndex = dockingTabs.selectedIndex;
      return newDockingTabs;
    } else if (area is DockingParentArea) {
      final children = <DockingArea>[];
      area.forEach((child) {
        final newChild = _buildLayout(child);
        if (newChild != null) {
          children.add(newChild);
        }
      });
      if (children.isEmpty) {
        return null;
      } else if (children.length == 1) {
        return children.first;
      }
      if (area is DockingRow) {
        return DockingRow(children);
      } else if (area is DockingColumn) {
        return DockingColumn(children);
      }
      throw ArgumentError(
          'DockingArea class not recognized: ${area.runtimeType}');
    }
    throw ArgumentError(
        'DockingArea class not recognized: ${area.runtimeType}');
  }
}
