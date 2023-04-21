import 'package:flutter/material.dart';
import 'package:mini_store/object/category.dart';
import 'package:pluto_grid/pluto_grid.dart';

class ShowTable extends StatefulWidget {
  final Category category;

  const ShowTable({
    super.key,
    required this.category,
  });

  @override
  State<ShowTable> createState() => _ShowTable();
}

class _ShowTable extends State<ShowTable> {
  List<PlutoColumn> columns = [
    PlutoColumn(
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.text(),
      footerRenderer: (context) {
        return PlutoAggregateColumnFooter(
          rendererContext: context,
          type: PlutoAggregateColumnType.count,
          format: 'Total: #,###',
          filter: (cell) {
            return cell.row.checked == false;
          },
          alignment: Alignment.center,
        );
      },
    ),
    PlutoColumn(
      title: 'Price',
      field: 'price',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Dis',
      field: 'disponibility',
      type: PlutoColumnType.number(),
    ),
  ];

  List<PlutoRow> rows = [];

  late PlutoGridStateManager stateManager;

  @override
  void initState() {
    super.initState();

    rows = widget.category.products.map((product) {
      return PlutoRow(
        cells: {
          'name': PlutoCell(value: product.name),
          'price': PlutoCell(value: product.price),
          'disponibility': PlutoCell(value: product.disponibility),
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      mode: PlutoGridMode.selectWithOneTap,
      columns: columns,
      rows: rows,
      configuration: PlutoGridConfiguration(
        columnSize: const PlutoGridColumnSizeConfig(
            autoSizeMode: PlutoAutoSizeMode.equal),
        style: PlutoGridStyleConfig(
          enableCellBorderHorizontal: false,
          enableCellBorderVertical: false,
          enableColumnBorderHorizontal: false,
          enableColumnBorderVertical: false,
          enableGridBorderShadow: false,
          enableRowColorAnimation: false,
          gridBorderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}


/*
onLoaded: (event) {
        stateManager = event.stateManager;
        stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
        stateManager.setShowColumnFilter(true);
      },
 */