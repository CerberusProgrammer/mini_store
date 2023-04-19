import 'package:flutter/material.dart';
import 'package:mini_store/data/products.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../object/product.dart';

class ProductDataSource extends DataGridSource {
  ProductDataSource({required List<Product> products}) {
    _products = products;
    buildDataGridRows();
  }

  List<Product> _products = [];
  List<DataGridRow> _productDataGridRows = [];

  void buildDataGridRows() {
    _productDataGridRows = _products.map<DataGridRow>(
      (product) {
        return DataGridRow(
          cells: [
            DataGridCell<int>(
              columnName: 'id',
              value: product.id,
            ),
            DataGridCell<String>(
              columnName: 'name',
              value: product.name,
            ),
            DataGridCell<double>(
              columnName: 'price',
              value: product.price,
            ),
            DataGridCell<int>(
              columnName: 'disponibility',
              value: product.disponibility,
            ),
          ],
        );
      },
    ).toList();
  }

  @override
  List<DataGridRow> get rows => _productDataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (e) {
        return Container(
          alignment: (e.columnName == 'id' ||
                  e.columnName == 'price' ||
                  e.columnName == 'disponibility')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: const EdgeInsets.all(8.0),
          child: Text(e.value.toString()),
        );
      },
    ).toList());
  }
}

class ProductDataGrid extends StatelessWidget {
  const ProductDataGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      allowSorting: true,
      allowColumnsResizing: true,
      source: ProductDataSource(products: getProducts()),
      columns: [
        GridColumn(columnName: 'id', label: const Text('ID'), width: 50),
        GridColumn(
          columnName: 'name',
          label: const Text('Name'),
        ),
        GridColumn(
          columnName: 'price',
          label: const Text('Price'),
        ),
        GridColumn(
          columnName: 'disponibility',
          label: const Text('Disponibility'),
        ),
      ],
    );
  }

  List<Product> getProducts() {
    return productList;
  }
}