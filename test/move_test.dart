import 'package:docking/docking.dart';
import 'package:flutter_test/flutter_test.dart';

import 'exceptions.dart';
import 'utils.dart';

void main() {
  group('move item - exceptions', () {
    test('draggedItem == targetArea ', () {
      final item = dockingItem('a');
      final layout = DockingLayout(root: item);
      expect(() => moveItemToPosition(layout, item, item, DropPosition.bottom),
          sameDraggedItemAndTargetAreaException());
    });

    test('nested tabbed panel - 0', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final itemC = dockingItem('c');
      final tabs = DockingTabs([itemB, itemC]);
      final row = DockingRow([itemA, tabs]);
      final layout = DockingLayout(root: row);

      expect(
          () => moveItemToIndex(layout, itemA, itemB, 0), throwsArgumentError);
    });

    test('nested tabbed panel - 1', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final itemC = dockingItem('c');
      final tabs = DockingTabs([itemB, itemC]);
      final row = DockingRow([itemA, tabs]);
      final layout = DockingLayout(root: row);

      expect(
          () => moveItemToIndex(layout, itemA, itemB, 1), throwsArgumentError);
    });
  });

  group('move item', () {
    test('row - no change', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final row = DockingRow([itemA, itemB]);
      final layout = DockingLayout(root: row);

      moveItemToPosition(layout, itemA, itemB, DropPosition.left);

      testHierarchy(layout, 'R(Ia,Ib)');
    });

    test('row - invert', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final row = DockingRow([itemA, itemB]);
      final layout = DockingLayout(root: row);

      moveItemToPosition(layout, itemA, itemB, DropPosition.right);

      testHierarchy(layout, 'R(Ib,Ia)');
    });

    test('row - to column 1', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final row = DockingRow([itemA, itemB]);
      final layout = DockingLayout(root: row);

      moveItemToPosition(layout, itemA, itemB, DropPosition.top);

      testHierarchy(layout, 'C(Ia,Ib)');
    });

    test('row - to column 2', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final row = DockingRow([itemA, itemB]);
      final layout = DockingLayout(root: row);

      moveItemToPosition(layout, itemA, itemB, DropPosition.bottom);

      testHierarchy(layout, 'C(Ib,Ia)');
    });

    test('row - to tabs 1', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final row = DockingRow([itemA, itemB]);
      final layout = DockingLayout(root: row);

      moveItemToIndex(layout, itemA, itemB, 0);

      testHierarchy(layout, 'T(Ia,Ib)');
    });

    test('row - to tabs 2', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final row = DockingRow([itemA, itemB]);
      final layout = DockingLayout(root: row);

      moveItemToIndex(layout, itemA, itemB, 1);

      testHierarchy(layout, 'T(Ib,Ia)');
    });

    test('row - to tabs 3', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final itemC = dockingItem('c');
      final tabs = DockingTabs([itemB, itemC]);
      final row = DockingRow([itemA, tabs]);
      final layout = DockingLayout(root: row);

      moveItemToIndex(layout, itemA, tabs, 0);

      testHierarchy(layout, 'T(Ia,Ib,Ic)');
    });

    test('row - to tabs 4', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final itemC = dockingItem('c');
      final tabs = DockingTabs([itemB, itemC]);
      final row = DockingRow([itemA, tabs]);
      final layout = DockingLayout(root: row);

      moveItemToIndex(layout, itemA, tabs, 1);

      testHierarchy(layout, 'T(Ib,Ia,Ic)');
    });

    test('row - to tabs 5', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final itemC = dockingItem('c');
      final tabs = DockingTabs([itemB, itemC]);
      final row = DockingRow([itemA, tabs]);
      final layout = DockingLayout(root: row);

      moveItemToIndex(layout, itemA, tabs, 2);

      testHierarchy(layout, 'T(Ib,Ic,Ia)');
    });

    test('complex 1 a', () {
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

      moveItemToIndex(layout, itemA, itemC, 0);

      testHierarchy(layout, 'C(Ib,T(Ia,Ic),T(Id,Ie))');
    });

    test('complex 1 b', () {
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

      moveItemToIndex(layout, itemA, itemC, 1);

      testHierarchy(layout, 'C(Ib,T(Ic,Ia),T(Id,Ie))');
    });

    test('complex 2 a', () {
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

      moveItemToIndex(layout, itemA, itemC, 0);

      testHierarchy(layout, 'C(Ib,T(Ia,Ic),T(Id,Ie),If)');
    });

    test('complex 2 b', () {
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

      moveItemToIndex(layout, itemA, itemC, 1);

      testHierarchy(layout, 'C(Ib,T(Ic,Ia),T(Id,Ie),If)');
    });

    test('complex 3 a', () {
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

      moveItemToIndex(layout, itemA, itemC, 0);

      testHierarchy(layout, 'R(Ig,C(Ib,T(Ia,Ic),T(Id,Ie),If))');
    });

    test('complex 3 b', () {
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

      moveItemToIndex(layout, itemA, itemC, 1);

      testHierarchy(layout, 'R(Ig,C(Ib,T(Ic,Ia),T(Id,Ie),If))');
    });

    test('complex 3 c', () {
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

      moveItemToIndex(layout, itemB, tabs, 1);

      testHierarchy(layout, 'R(Ig,C(R(Ia,Ic),T(Id,Ib,Ie),If))');
    });
  });
}
