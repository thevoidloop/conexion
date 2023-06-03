import 'package:conexion/data/models/data_combustible_chart_model.dart';
import 'package:conexion/data/providers/database_manager_provider.dart';
import 'package:conexion/ui/widgets/text_form_field_widget.dart';
import 'package:conexion/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/models.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var textStyle = TextStyle(fontSize: 30);
    return Scaffold(
      appBar: AppBar(title: Text('DashBoard')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Text(
              'Consumo Combustible',
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              height: size.height * 0.4,
              child: ColumChar(),
            ),
            _OptionsChartCombustible(size: size),
            SizedBox(height: 50),
            Text(
              'Mantenimientos Realizados',
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            PieChart(),
            SizedBox(height: 15),
            _OptionsPieServices(size: size),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _OptionsPieServices extends StatelessWidget {
  final Size size;
  const _OptionsPieServices({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          SizedBox(width: size.width * 0.45, child: DropdownVehicleData()),
          const SizedBox(width: 15),
          SizedBox(width: size.width * 0.45, child: DropdownYearPie()),
        ],
      ),
    );
  }
}

class _OptionsChartCombustible extends StatelessWidget {
  final Size size;
  const _OptionsChartCombustible({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          SizedBox(width: size.width * 0.45, child: DropdownYear()),
          const SizedBox(width: 15),
          SizedBox(width: size.width * 0.45, child: DropdownSemester()),
        ],
      ),
    );
  }
}

class ColumChar extends StatelessWidget {
  ColumChar({super.key});

  final TooltipBehavior _tooltip = TooltipBehavior(enable: true);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseManagerProvider>(
      builder: (context, db, _) {
        return SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(minimum: 0, maximum: 10000, interval: 1000),
          tooltipBehavior: _tooltip,
          series: <ChartSeries<DataCombustibleMes, String>>[
            ColumnSeries<DataCombustibleMes, String>(
              dataSource: db.dataCombustibleMes,
              xValueMapper: (DataCombustibleMes data, _) =>
                  data.asignarMes(data.mes),
              yValueMapper: (DataCombustibleMes data, _) => data.totalGastado,
              name: 'Combustible',
              color: const Color.fromRGBO(8, 142, 255, 1),
            )
          ],
        );
      },
    );
  }
}

class PieChart extends StatelessWidget {
  const PieChart({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<DatabaseManagerProvider>(
        builder: (context, db, _) {
          return SfCircularChart(
            // title: ChartTitle(text: 'Mantenimiento de Vehiculos'),
            series: <PieSeries<DataPieModel, String>>[
              PieSeries<DataPieModel, String>(
                  explode: true,
                  explodeIndex: 0,
                  dataSource: db.dataPie,
                  xValueMapper: (DataPieModel data, _) => data.type,
                  yValueMapper: (DataPieModel data, _) => data.data,
                  dataLabelMapper: (DataPieModel data, _) => data.type,
                  dataLabelSettings: const DataLabelSettings(isVisible: true)),
            ],
          );
        },
      ),
    );
  }
}
