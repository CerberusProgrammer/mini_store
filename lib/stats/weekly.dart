import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mini_store/data/wallet.dart';

class Weekly extends StatefulWidget {
  const Weekly({super.key});

  @override
  State<StatefulWidget> createState() => _Weekly();
}

class _Weekly extends State<Weekly> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BarChart(
                      mainBarData(),
                      swapAnimationDuration: animDuration,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= Theme.of(context).colorScheme.primary;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched
              ? Theme.of(context).colorScheme.primary.withAlpha(125)
              : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 1000,
            color: Theme.of(context).colorScheme.primary.withAlpha(100),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        double monday = Wallet.weekMoney['monday']?.transactions.fold(0,
                (previousValue, element) => previousValue! + element.money) ??
            0;
        double tuesday = Wallet.weekMoney['tuesday']?.transactions.fold(0,
                (previousValue, element) => previousValue! + element.money) ??
            0;
        double wednesday = Wallet.weekMoney['wednesday']?.transactions.fold(0,
                (previousValue, element) => previousValue! + element.money) ??
            0;
        double thursday = Wallet.weekMoney['thursday']?.transactions.fold(0,
                (previousValue, element) => previousValue! + element.money) ??
            0;
        double friday = Wallet.weekMoney['friday']?.transactions.fold(0,
                (previousValue, element) => previousValue! + element.money) ??
            0;
        double saturday = Wallet.weekMoney['saturday']?.transactions.fold(0,
                (previousValue, element) => previousValue! + element.money) ??
            0;
        double sunday = Wallet.weekMoney['sunday']?.transactions.fold(0,
                (previousValue, element) => previousValue! + element.money) ??
            0;

        switch (i) {
          case 0:
            return makeGroupData(
              0,
              monday,
              isTouched: i == touchedIndex,
            );
          case 1:
            return makeGroupData(
              1,
              tuesday,
              isTouched: i == touchedIndex,
            );
          case 2:
            return makeGroupData(
              2,
              wednesday,
              isTouched: i == touchedIndex,
            );
          case 3:
            return makeGroupData(
              3,
              thursday,
              isTouched: i == touchedIndex,
            );
          case 4:
            return makeGroupData(
              4,
              friday,
              isTouched: i == touchedIndex,
            );
          case 5:
            return makeGroupData(
              5,
              saturday,
              isTouched: i == touchedIndex,
            );
          case 6:
            return makeGroupData(
              6,
              sunday,
              isTouched: i == touchedIndex,
            );
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Theme.of(context).colorScheme.primary.withAlpha(240),
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          tooltipMargin: -80,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Monday';
                break;
              case 1:
                weekDay = 'Tuesday';
                break;
              case 2:
                weekDay = 'Wednesday';
                break;
              case 3:
                weekDay = 'Thursday';
                break;
              case 4:
                weekDay = 'Friday';
                break;
              case 5:
                weekDay = 'Saturday';
                break;
              case 6:
                weekDay = 'Sunday';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: [
                TextSpan(
                  text: '\$${(rod.toY - 1).toString()}',
                  style: TextStyle(
                    color: Colors.white.withAlpha(180),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('M', style: style);
        break;
      case 1:
        text = Text('T', style: style);
        break;
      case 2:
        text = Text('W', style: style);
        break;
      case 3:
        text = Text('T', style: style);
        break;
      case 4:
        text = Text('F', style: style);
        break;
      case 5:
        text = Text('S', style: style);
        break;
      case 6:
        text = Text('S', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      gridData: FlGridData(show: false),
    );
  }
}
