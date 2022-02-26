
import 'dart:async';

import 'package:pagination/model/common_model.dart';
import 'package:pagination/repository/passenger_repository.dart';
import 'package:pagination/utils/response.dart';

class PassengerBloc {
  PassengerRepository _passengerRepository;
  StreamController _passengerController;

  StreamSink<Response<CommonModel>> get roiEarningBlocDataSink => _passengerController.sink;

  Stream<Response<CommonModel>> get roiEarningBlocDataStream => _passengerController.stream;

  PassengerBloc(int page, bool firstLoad) {
    _passengerController = StreamController<Response<CommonModel>>();
    _passengerRepository = PassengerRepository();
    fetchData(page, firstLoad);
  }

  fetchData(int page, bool firstLoad) async {
    if (firstLoad) {
      roiEarningBlocDataSink.add(Response.loading('Loading Passenger List..!'));
    }

    try {
      CommonModel commonModel = await _passengerRepository.fetchRoiearning(page);
      roiEarningBlocDataSink.add(Response.completed(commonModel));
    } catch (e) {
      roiEarningBlocDataSink.add(Response.error(e.toString()));
      print("Exception === $e");
    }
  }

  dispose() {
    _passengerController.close();
  }
}