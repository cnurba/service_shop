import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/search/application/qwery_params/query_params_controller.dart';
import 'package:service_shop/app/search/application/qwery_params/qwery_params.dart';

final queryProvider =
    StateNotifierProvider<QueryParamsController, QueryParamsState>((ref) {
      return QueryParamsController();
    });
