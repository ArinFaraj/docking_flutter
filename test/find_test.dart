import 'package:docking/docking.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

DockingItem dockingItem(dynamic id) {
  return DockingItem(id: id, widget: Container());
}

void main() {
  group('find item', () {
    test('empty layout', () {
      final layout = DockingLayout(root: null);
      expect(layout.findDockingItem(1), isNull);
    });
    test('row', () {
      final item1 = dockingItem(1);
      final item2 = dockingItem(2);
      final row = DockingRow([item1, item2]);
      final layout = DockingLayout(root: row);
      expect(layout.findDockingItem(1), isNotNull);
      expect(layout.findDockingItem(2), isNotNull);
      expect(layout.findDockingItem(3), isNull);
    });
    test('column', () {
      final item1 = dockingItem(1);
      final item2 = dockingItem(2);
      final column = DockingColumn([item1, item2]);
      final layout = DockingLayout(root: column);
      expect(layout.findDockingItem(1), isNotNull);
      expect(layout.findDockingItem(2), isNotNull);
      expect(layout.findDockingItem(3), isNull);
    });

    test('tabs', () {
      final itemB = dockingItem(1);
      final itemC = dockingItem(2);
      final tabs = DockingTabs([itemB, itemC]);
      final layout = DockingLayout(root: tabs);
      expect(layout.findDockingItem(1), isNotNull);
      expect(layout.findDockingItem(2), isNotNull);
      expect(layout.findDockingItem(3), isNull);
    });

    test('complex', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final itemC = dockingItem('c');
      final itemD = dockingItem('d');
      final itemE = dockingItem('e');
      final innerColumn = DockingColumn([itemB, itemC]);
      final row = DockingRow([itemA, innerColumn]);
      final tabs = DockingTabs([itemD, itemE]);
      final column = DockingColumn([row, tabs]);
      final layout = DockingLayout(root: column);

      expect(layout.findDockingItem('a'), isNotNull);
      expect(layout.findDockingItem('b'), isNotNull);
      expect(layout.findDockingItem('c'), isNotNull);
      expect(layout.findDockingItem('d'), isNotNull);
      expect(layout.findDockingItem('e'), isNotNull);
      expect(layout.findDockingItem('f'), isNull);
    });

    test('complex 2', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final itemC = dockingItem('c');
      final itemD = dockingItem('d');
      final itemE = dockingItem('e');
      final itemF = dockingItem('f');
      final innerColumn = DockingColumn([itemB, itemC]);
      final row = DockingRow([itemA, innerColumn]);
      final tabs = DockingTabs([itemD, itemE]);
      final column = DockingColumn([row, tabs, itemF]);
      final layout = DockingLayout(root: column);

      expect(layout.findDockingItem('a'), isNotNull);
      expect(layout.findDockingItem('b'), isNotNull);
      expect(layout.findDockingItem('c'), isNotNull);
      expect(layout.findDockingItem('d'), isNotNull);
      expect(layout.findDockingItem('e'), isNotNull);
      expect(layout.findDockingItem('f'), isNotNull);
      expect(layout.findDockingItem('g'), isNull);
    });

    test('complex 3', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final itemC = dockingItem('c');
      final itemD = dockingItem('d');
      final itemE = dockingItem('e');
      final itemF = dockingItem('f');
      final itemG = dockingItem('g');
      final innerColumn = DockingColumn([itemB, itemC]);
      final row = DockingRow([itemA, innerColumn]);
      final tabs = DockingTabs([itemD, itemE]);
      final column = DockingColumn([row, tabs, itemF]);
      final row2 = DockingRow([itemG, column]);
      final layout = DockingLayout(root: row2);

      expect(layout.findDockingItem('a'), isNotNull);
      expect(layout.findDockingItem('b'), isNotNull);
      expect(layout.findDockingItem('c'), isNotNull);
      expect(layout.findDockingItem('d'), isNotNull);
      expect(layout.findDockingItem('e'), isNotNull);
      expect(layout.findDockingItem('f'), isNotNull);
      expect(layout.findDockingItem('g'), isNotNull);
      expect(layout.findDockingItem('h'), isNull);
    });
  });
}
