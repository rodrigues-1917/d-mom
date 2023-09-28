import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, Map<String, Map<String, String>>>> db() async {
  late Map<String, Map<String, Map<String, String>>> retorno;

  final Future aguarde = Future.delayed(const Duration(seconds: 0), () {
    retorno = {
      'Compra': {
        '000': {
          'Vendedor': 'Vendedor 01',
          'Data': '23/09/2023',
          'Valor': '1000'
        },
        '001': {
          'Vendedor': 'Vendedor 02',
          'Data': '23/09/2023',
          'Valor': '2000'
        },
        '002': {
          'Vendedor': 'Vendedor 01',
          'Data': '23/09/2023',
          'Valor': '1000'
        },
        '003': {
          'Vendedor': 'Vendedor 01',
          'Data': '23/09/2023',
          'Valor': '1000'
        },
        '004': {
          'Vendedor': 'Vendedor 01',
          'Data': '23/09/2023',
          'Valor': '1000'
        },
        '005': {
          'Vendedor': 'Vendedor 01',
          'Data': '23/09/2023',
          'Valor': '1000'
        },
        '006': {
          'Vendedor': 'Vendedor 01',
          'Data': '23/09/2023',
          'Valor': '1000'
        },
      },
      'Venda': {
        '0': {
          'Comprador': 'Comprador 01',
          'Data': '23/09/2023',
          'Valor': '100'
        },
        '1': {
          'Comprador': 'Comprador 02',
          'Data': '23/09/2023',
          'Valor': '200'
        },
      },
      'Gasto': {
        '0': {'Tipo': 'Tipo 01', 'Data': '23/09/2023', 'Valor': '1'},
        '1': {'Tipo': 'Tipo 02', 'Data': '23/09/2023', 'Valor': '2'},
      },
    };
  });
  await aguarde;

  var collection1 = FirebaseFirestore.instance.collection('Compra').doc('0');

  final result1 = await collection1.get();

  Map<String, Map<String, Map<String, String>>> reto = {};

  print(result1.get('data'));

  return retorno;
}
