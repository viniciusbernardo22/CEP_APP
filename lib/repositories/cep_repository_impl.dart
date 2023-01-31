import 'dart:developer';

import 'package:cep_app/models/endereco_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'cep_repository.dart';

@immutable
abstract class CepRepositoryImpl implements CepRepository {
  @override
  Future<EnderecoModel> getCep(String cep) async {
    try {
      final result = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      return EnderecoModel.fromMap(result.data);
    } on DioError catch (e) {
      log("Erro ao Buscar CEP", error: e);
      throw Exception("Erro ao Buscar cep");
    }
  }
}
