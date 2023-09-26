import 'package:docking/docking.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group('remove item by id', () {
    test('item', () {
      final item = dockingItem('a', id: 1);
      final layout = DockingLayout(root: item);
      testHierarchy(layout, 'Ia');
      removeItemById(layout, [1]);
      testHierarchy(layout, '');
    });

    test('empty layout', () {
      final layout = DockingLayout();
      removeItemById(layout, [1]);
      testHierarchy(layout, '');
    });

    test('row item 1', () {
      final itemA = dockingItem('a', id: 1);
      final itemB = dockingItem('b', id: 2);
      final itemC = dockingItem('c', id: 3);
      final row = DockingRow([itemA, itemB, itemC]);
      final layout = DockingLayout(root: row);

      testHierarchy(layout, 'R(Ia,Ib,Ic)');

      removeItemById(layout, [1]);

      testHierarchy(layout, 'R(Ib,Ic)');
    });

    test('row item 2', () {
      final itemA = dockingItem('a', id: 1);
      final itemB = dockingItem('b', id: 2);
      final row = DockingRow([itemA, itemB]);
      final layout = DockingLayout(root: row);

      testHierarchy(layout, 'R(Ia,Ib)');

      removeItemById(layout, [1]);

      testHierarchy(layout, 'Ib');
    });

    test('column item 1', () {
      final itemA = dockingItem('a', id: 1);
      final itemB = dockingItem('b', id: 2);
      final itemC = dockingItem('c', id: 3);
      final column = DockingColumn([itemA, itemB, itemC]);
      final layout = DockingLayout(root: column);

      testHierarchy(layout, 'C(Ia,Ib,Ic)');

      removeItemById(layout, [1]);

      testHierarchy(layout, 'C(Ib,Ic)');
    });

    test('column item 2', () {
      final itemA = dockingItem('a', id: 1);
      final itemB = dockingItem('b', id: 2);
      final column = DockingColumn([itemA, itemB]);
      final layout = DockingLayout(root: column);

      testHierarchy(layout, 'C(Ia,Ib)');

      removeItemById(layout, [1]);

      testHierarchy(layout, 'Ib');
    });

    test('tabs item 1', () {
      final itemA = dockingItem('a', id: 1);
      final itemB = dockingItem('b', id: 2);
      final itemC = dockingItem('c', id: 3);
      final tabs = DockingTabs([itemA, itemB, itemC]);
      final layout = DockingLayout(root: tabs);

      testHierarchy(layout, 'T(Ia,Ib,Ic)');

      removeItemById(layout, [1]);

      testHierarchy(layout, 'T(Ib,Ic)');
    });

    test('tabs item 2', () {
      final itemA = dockingItem('a', id: 1);
      final itemB = dockingItem('b', id: 2);
      final tabs = DockingTabs([itemA, itemB]);
      final layout = DockingLayout(root: tabs);

      testHierarchy(layout, 'T(Ia,Ib)');

      removeItemById(layout, [1]);

      testHierarchy(layout, 'Ib');
    });

    test('tabs item 3', () {
      final itemA = dockingItem('a', id: 1);
      final itemB = dockingItem('b', id: 2);
      final tabs = DockingTabs([itemA, itemB]);
      final layout = DockingLayout(root: tabs);

      testHierarchy(layout, 'T(Ia,Ib)');

      removeItemById(layout, [1, 2]);

      testHierarchy(layout, '');
    });

    test('column row item 1', () {
      final itemA = dockingItem('a', id: 1);
      final itemB = dockingItem('b', id: 2);
      final itemC = dockingItem('c', id: 3);
      final row = DockingRow([itemA, itemB]);
      final column = DockingColumn([row, itemC]);
      final layout = DockingLayout(root: column);

      testHierarchy(layout, 'C(R(Ia,Ib),Ic)');

      removeItemById(layout, [3]);

      testHierarchy(layout, 'R(Ia,Ib)');
    });

    test('column row item 2', () {
      final itemA = dockingItem('a', id: 1);
      final itemB = dockingItem('b', id: 2);
      final itemC = dockingItem('c', id: 3);
      final row = DockingRow([itemA, itemB]);
      final column = DockingColumn([row, itemC]);
      final layout = DockingLayout(root: column);

      testHierarchy(layout, 'C(R(Ia,Ib),Ic)');

      removeItemById(layout, [1]);

      testHierarchy(layout, 'C(Ib,Ic)');
    });

    test('row column row item', () {
      final itemA = dockingItem('a', id: 1);
      final itemB = dockingItem('b', id: 2);
      final itemC = dockingItem('c', id: 3);
      final itemD = dockingItem('d', id: 4);
      final row = DockingRow([itemB, itemC]);
      final column = DockingColumn([row, itemD]);
      final rootRow = DockingRow([itemA, column]);
      final layout = DockingLayout(root: rootRow);

      testHierarchy(layout, 'R(Ia,C(R(Ib,Ic),Id))');

      removeItemById(layout, [4]);

      testHierarchy(layout, 'R(Ia,Ib,Ic)');
    });

    test('row column row item (2)', () {
      final itemA = dockingItem('a', id: 1);
      final itemB = dockingItem('b', id: 2);
      final itemC = dockingItem('c', id: 3);
      final itemD = dockingItem('d', id: 4);
      final row = DockingRow([itemB, itemC]);
      final column = DockingColumn([row, itemD]);
      final rootRow = DockingRow([itemA, column]);
      final layout = DockingLayout(root: rootRow);

      testHierarchy(layout, 'R(Ia,C(R(Ib,Ic),Id))');
      removeItemById(layout, [1, 4]);

      testHierarchy(layout, 'R(Ib,Ic)');
    });

    test('row column row item (3)', () {
      final itemA = dockingItem('a', id: 1);
      final itemB = dockingItem('b', id: 2);
      final itemC = dockingItem('c', id: 3);
      final itemD = dockingItem('d', id: 4);
      final row = DockingRow([itemB, itemC]);
      final column = DockingColumn([row, itemD]);
      final rootRow = DockingRow([itemA, column]);
      final layout = DockingLayout(root: rootRow);

      testHierarchy(layout, 'R(Ia,C(R(Ib,Ic),Id))');
      removeItemById(layout, [1, 3]);

      testHierarchy(layout, 'C(Ib,Id)');
    });

    test('row column row item (4)', () {
      final itemA = dockingItem('a', id: 1);
      final itemB = dockingItem('b', id: 2);
      final itemC = dockingItem('c', id: 3);
      final itemD = dockingItem('d', id: 4);
      final row = DockingRow([itemB, itemC]);
      final column = DockingColumn([row, itemD]);
      final rootRow = DockingRow([itemA, column]);
      final layout = DockingLayout(root: rootRow);

      testHierarchy(layout, 'R(Ia,C(R(Ib,Ic),Id))');
      removeItemById(layout, [1, 2, 3]);

      testHierarchy(layout, 'Id');
    });
  });
}
