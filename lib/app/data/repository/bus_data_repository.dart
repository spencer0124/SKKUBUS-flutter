import 'package:skkumap/app/data/model/bus_data_model.dart';
import 'package:skkumap/app/data/provider/but_data_provider.dart';

class BusDataRepository {
  final BusDataProvider dataProvider;

  BusDataRepository({required this.dataProvider});

  Future<List<BusData>> getBusData() {
    return dataProvider.fetchBusData();
  }
}
