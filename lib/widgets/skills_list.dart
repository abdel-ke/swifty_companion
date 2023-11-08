import 'package:flutter/material.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SkillsList extends StatefulWidget {
  const SkillsList({super.key, required this.skills});
  final List<Skills> skills;

  @override
  State<SkillsList> createState() => _SkillsListState();
}

class _SkillsListState extends State<SkillsList> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      backgroundColor: Colors.grey.shade200,
      title: ChartTitle(text: 'Skills'),
      legend: const Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap, position: LegendPosition.bottom, alignment: ChartAlignment.near),
      tooltipBehavior: _tooltipBehavior,
      series: <PieSeries<Skills, String>>[
        PieSeries<Skills, String>(
          explode: true,
          explodeIndex: 0,
          dataSource: widget.skills,
          xValueMapper: (Skills data, _) => data.name,
          yValueMapper: (Skills data, _) => double.parse(data.level.toStringAsFixed(2)),
          dataLabelSettings: const DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside),
          enableTooltip: true,
        )
      ],
    );
  }
}
