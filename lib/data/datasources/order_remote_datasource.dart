import 'package:flutter_pos_app/core/constants/variables.dart';
import 'package:flutter_pos_app/data/models/request/order_request_model.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import 'auth_local_datasource.dart';

class OrderRemoteDatasource {
  HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  Future<bool> sendOrder(OrderRequestModel requestModel) async {
    final url = Uri.parse('${Variables.baseUrl}/api/orders');
    final authData = await AuthLocalDatasource().getAuthData();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    print(requestModel.toJson());
    final response = await http.post(
      url,
      headers: headers,
      body: requestModel.toJson(),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
