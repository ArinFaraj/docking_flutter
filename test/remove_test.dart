import 'package:docking/docking.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group('remove item', () {
    test('item', () {
      final item = dockingItem('a');
      final layout = DockingLayout(root: item);
      testHierarchy(layout, 'Ia');
      removeItem(layout, item);
      testHierarchy(layout, '');
    });

    test('item without layout', () {
      var layout = DockingLayout();
      expect(() => removeItem(layout, dockingItem('a')), throwsArgumentError);
      layout = DockingLayout(root: dockingItem('a'));
      expect(() => removeItem(layout, dockingItem('b')), throwsArgumentError);
    });

    test('item from another layout', () {
      final layout1 = DockingLayout(root: dockingItem('a'));
      final layout2 = DockingLayout(root: dockingItem('b'));
      expect(
          () => removeItem(layout2, layout1.layoutAreas().first as DockingItem),
          throwsArgumentError);
    });

    test('row item 1', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final itemC = dockingItem('c');
      final row = DockingRow([itemA, itemB, itemC]);
      final layout = DockingLayout(root: row);

      testHierarchy(layout, 'R(Ia,Ib,Ic)');

      removeItem(layout, itemA);

      testHierarchy(layout, 'R(Ib,Ic)');
    });

    test('row item 2', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final row = DockingRow([itemA, itemB]);
      final layout = DockingLayout(root: row);

      testHierarchy(layout, 'R(Ia,Ib)');

      removeItem(layout, itemA);

      testHierarchy(layout, 'Ib');
    });

    test('column item 1', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final itemC = dockingItem('c');
      final column = DockingColumn([itemA, itemB, itemC]);
      final layout = DockingLayout(root: column);

      testHierarchy(layout, 'C(Ia,Ib,Ic)');

      removeItem(layout, itemA);

      testHierarchy(layout, 'C(Ib,Ic)');
    });

    test('column item 2', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final column = DockingColumn([itemA, itemB]);
      final layout = DockingLayout(root: column);

      testHierarchy(layout, 'C(Ia,Ib)');

      removeItem(layout, itemA);

      testHierarchy(layout, 'Ib');
    });

    test('tabs item 1', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final itemC = dockingItem('c');
      final tabs = DockingTabs([itemA, itemB, itemC]);
      final layout = DockingLayout(root: tabs);

      testHierarchy(layout, 'T(Ia,Ib,Ic)');

      removeItem(layout, itemA);

      testHierarchy(layout, 'T(Ib,Ic)');
    });

    test('tabs item 2', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final tabs = DockingTabs([itemA, itemB]);
      final layout = DockingLayout(root: tabs);

      testHierarchy(layout, 'T(Ia,Ib)');

      removeItem(layout, itemA);

      testHierarchy(layout, 'Ib');
    });

    test('column row item 1', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final itemC = dockingItem('c');
      final row = DockingRow([itemA, itemB]);
      final column = DockingColumn([row, itemC]);
      final layout = DockingLayout(root: column);

      testHierarchy(layout, 'C(R(Ia,Ib),Ic)');

      removeItem(layout, itemC);

      testHierarchy(layout, 'R(Ia,Ib)');
    });

    test('column row item 2', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final itemC = dockingItem('c');
      final row = DockingRow([itemA, itemB]);
      final column = DockingColumn([row, itemC]);
      final layout = DockingLayout(root: column);

      testHierarchy(layout, 'C(R(Ia,Ib),Ic)');

      removeItem(layout, itemA);

      testHierarchy(layout, 'C(Ib,Ic)');
    });

    test('row column row item', () {
      final itemA = dockingItem('a');
      final itemB = dockingItem('b');
      final itemC = dockingItem('c');
      final itemD = dockingItem('d');
      final row = DockingRow([itemB, itemC]);
      final column = DockingColumn([row, itemD]);
      final rootRow = DockingRow([itemA, column]);
      final layout = DockingLayout(root: rootRow);

      testHierarchy(layout, 'R(Ia,C(R(Ib,Ic),Id))');

      removeItem(layout, itemD);

      testHierarchy(layout, 'R(Ia,Ib,Ic)');
    });
  });
}
