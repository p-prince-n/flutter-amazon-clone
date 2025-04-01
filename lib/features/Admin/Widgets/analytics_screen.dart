import 'package:amazon/common/Widgets/loader.dart';
import 'package:amazon/features/Admin/Services/admin_services.dart';
import 'package:amazon/features/Admin/Widgets/category_charts_products.dart';
import 'package:amazon/features/Admin/model/sales.dart';
import 'package:flutter/cupertino.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices _adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await _adminServices.getEarnings(context);
    totalSales = earningData['totalEarning'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? Center(
            child: Loader(),
          )
        : Column(
            children: [
              Text(
                '\$$totalSales',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CategoryChartsProducts(
                sales: earnings!,
                totalAmount: totalSales.toString(),
              ),
            ],
          );
  }
}
