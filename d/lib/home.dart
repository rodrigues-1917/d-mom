import 'package:d/firestore_firebase.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => HomeState();
}

// Laços de repetição
List<Widget> item(String tipoColuna, int contador,
    Map<String, Map<String, Map<String, String>>> listaDB) {
  List<Widget> retorno = [];
  int index;
  if (tipoColuna == 'Compra') {
    index = 0;
  } else if (tipoColuna == 'Venda') {
    index = 1;
  } else {
    index = 2;
  }

  for (int i = 0; i < contador; i++) {
    retorno.add(Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'ID:',
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ),
            Expanded(
                flex: 2,
                child: Text(listaDB.entries
                    .elementAt(index)
                    .value
                    .entries
                    .elementAt(i)
                    .key)),
            Expanded(
                flex: 4,
                child: Text(
                    tipoColuna == 'Compra'
                        ? 'Vendedor:'
                        : tipoColuna == 'Venda'
                            ? 'Comprador:'
                            : 'Tipo:',
                    style: TextStyle(color: Colors.grey.shade400))),
            Expanded(
                flex: 5,
                child: Text(listaDB.entries
                    .elementAt(index)
                    .value
                    .entries
                    .elementAt(i)
                    .value
                    .entries
                    .elementAt(0)
                    .value)),
            Expanded(
              flex: 2,
              child:
                  Text('Data:', style: TextStyle(color: Colors.grey.shade400)),
            ),
            Expanded(
                flex: 4,
                child: Text(listaDB.entries
                    .elementAt(index)
                    .value
                    .entries
                    .elementAt(i)
                    .value
                    .entries
                    .elementAt(1)
                    .value)),
            Expanded(
              flex: 2,
              child:
                  Text('Valor:', style: TextStyle(color: Colors.grey.shade400)),
            ),
            Expanded(
                flex: 3,
                child: Text(listaDB.entries
                    .elementAt(index)
                    .value
                    .entries
                    .elementAt(i)
                    .value
                    .entries
                    .elementAt(2)
                    .value)),
          ],
        ),
        const Divider()
      ],
    ));
  }
  return retorno;
}

// Identação -> Funções específicas
Column coluna(String titulo, int contador,
    Map<String, Map<String, Map<String, String>>> listaDB) {
  return Column(
    children: [
      Column(
        children: item(titulo, contador, listaDB),
      ),
      Row(
        children: [
          Expanded(
              child: ElevatedButton(
            onPressed: () {},
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.pink)),
            child: const Icon(
              Icons.add_circle_outline,
            ),
          ))
        ],
      )
    ],
  );
}

// Otimização -> Funções reutilizadas
Container containerItens(Column coluna, String titulo) {
  return Container(
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.pink, width: 1),
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      children: [
        Text(titulo),
        const Divider(
          color: Colors.pink,
        ),
        Expanded(
            child: SizedBox(
          child: SingleChildScrollView(
            child: coluna,
          ),
        ))
      ],
    ),
  );
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<Map<String, Map<String, Map<String, String>>>>(
            future: db(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, Map<String, Map<String, String>>>>
                    snapshot) {
              Widget child;
              if (snapshot.hasData) {
                child = Expanded(
                    child: containerItens(
                        coluna(
                            'Compra',
                            snapshot.requireData.entries
                                .elementAt(0)
                                .value
                                .length,
                            snapshot.requireData),
                        'Compra'));
              } else {
                child = const CircularProgressIndicator();
              }
              return child;
            },
          ),
          FutureBuilder<Map<String, Map<String, Map<String, String>>>>(
            future: db(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, Map<String, Map<String, String>>>>
                    snapshot) {
              Widget child;
              if (snapshot.hasData) {
                child = Expanded(
                    child: containerItens(
                        coluna(
                            'Venda',
                            snapshot.requireData.entries
                                .elementAt(1)
                                .value
                                .length,
                            snapshot.requireData),
                        'Venda'));
              } else {
                child = const CircularProgressIndicator();
              }
              return child;
            },
          ),
          FutureBuilder<Map<String, Map<String, Map<String, String>>>>(
            future: db(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, Map<String, Map<String, String>>>>
                    snapshot) {
              Widget child;
              if (snapshot.hasData) {
                child = Expanded(
                    child: containerItens(
                        coluna(
                            'Gasto',
                            snapshot.requireData.entries
                                .elementAt(2)
                                .value
                                .length,
                            snapshot.requireData),
                        'Gasto'));
              } else {
                child = const CircularProgressIndicator();
              }
              return child;
            },
          )
        ],
      ),
    );
  }
}
