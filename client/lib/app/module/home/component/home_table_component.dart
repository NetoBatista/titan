import 'package:flutter/material.dart';
import 'package:titan/app/core/constant/execution_step_constant.dart';
import 'package:titan/app/core/extension/string_extension.dart';
import 'package:titan/app/module/home/controller/home_controller.dart';
import 'package:titan/app/module/home/model/home_execution_model.dart';

class HomeTableComponent extends StatefulWidget {
  final HomeController controller;
  const HomeTableComponent({
    required this.controller,
    super.key,
  });

  @override
  State<HomeTableComponent> createState() => _HomeTableComponentState();
}

class _HomeTableComponentState extends State<HomeTableComponent> {
  HomeController get _controller => widget.controller;
  Color colorStatus(HomeExecutionModel item) {
    switch (item.status) {
      case ExecutionStepConstant.created:
        return Colors.yellow;
      case ExecutionStepConstant.fail:
        return Colors.red;
      case ExecutionStepConstant.inProgress:
        return Colors.blue;
      case ExecutionStepConstant.success:
        return Colors.green;
      default:
        return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.homeExecutions.isEmpty) {
      return Container();
    }
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(minWidth: constraints.maxWidth),
          child: DataTable(
            border: TableBorder.all(color: Colors.grey),
            columnSpacing: 56,
            columns: [
              const DataColumn(label: Text('#')),
              DataColumn(
                label: Text('home-component.table.header.name'.translate()),
              ),
              DataColumn(
                label: Text('home-component.table.header.url'.translate()),
              ),
              DataColumn(
                label: Text('home-component.table.header.status'.translate()),
              ),
              DataColumn(
                label: Text('home-component.table.header.date'.translate()),
              ),
            ],
            rows: List.generate(
              _controller.homeExecutions.length,
              (int index) {
                var item = _controller.homeExecutions.elementAt(index);
                return DataRow(
                  cells: [
                    DataCell(
                      SizedBox(
                        width: 80,
                        child: Text(
                          item.id,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: (constraints.maxWidth - 600) / 2,
                        child: Text(
                          item.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: (constraints.maxWidth - 600) / 2,
                        child: Text(
                          item.url,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: 80,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 16,
                              width: 16,
                              color: colorStatus(item),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              ExecutionStepConstant.translate(item.status),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: 140,
                        child: Text(
                          item.date,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
