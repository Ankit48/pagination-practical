
import 'package:pagination/model/common_model.dart';
import 'package:pagination/utils/api_provider.dart';

class PassengerRepository {
  final ApiProvider _provider = ApiProvider();

  Future<CommonModel> fetchRoiearning(int page) async {
    
    final requestBody = {};
    
    final response = await _provider.httpMethodWithoutToken('get', 'passenger?page=$page&size=10', requestBody);

    return CommonModel.fromJson(response);
  }
}
