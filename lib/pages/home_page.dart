import 'package:cep_app/models/endereco_model.dart';
import 'package:cep_app/repositories/cep_repository.dart';
import 'package:cep_app/repositories/cep_repository_impl.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CepRepository cepRepository = CepRepositoryImpl();
  EnderecoModel? enderecoModel;

  final formKey = GlobalKey<FormState>();
  final cepEC = TextEditingController();

  @override
  void dispose() {
    cepEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Cep1'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Cep obrigatório';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                final valid = formKey.currentState?.validate() ?? false;
                if (valid) {
                  final endereco = await CepRepository.getCep(cepEC.text);
                  setState(() {
                    enderecoModel = endereco;
                  });
                }
              },
              child: const Text('Buscar'),
            ),
            const Text('Logradouro complemento, cep')
          ]),
        ),
      ),
    );
  }
}
