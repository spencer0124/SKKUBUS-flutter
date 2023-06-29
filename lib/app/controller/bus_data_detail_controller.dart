import 'package:get/get.dart';
import 'package:skkumap/app/data/model/bus_data_detail_model.dart';
import 'package:skkumap/app/data/repository/bus_data_detail_repository.dart';

class BusDetailController extends GetxController {
  final BusDetailRepository repository;
  var busDetail = BusDetail().obs;
  var phoneNumber = '027601073'.obs;

  void setPhoneNumber(String number) {
    phoneNumber.value = number;
  }

  BusDetailController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    fetchBusDetail();
  }

  void fetchBusDetail() async {
    try {
      var info = await repository.getBusDetail();
      busDetail.value = info;
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
