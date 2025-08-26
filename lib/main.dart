import 'package:flutter/material.dart';

void main() {
  runApp(MaterialHome());
}

class MaterialHome extends StatelessWidget {
  const MaterialHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Título no App",
      routes: <String, WidgetBuilder>{
        "/": (context) => PrimeiraTela(),
        "/inserirDadosX": (context) => SegundaTela(varName: "X"),
        "/inserirDadosY": (context) => SegundaTela(varName: "Y"),
      },
    );
  }
}

class SegundaTela extends StatelessWidget {
  SegundaTela({super.key, required String this.varName});

  final String varName;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final varName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text("Segunda tela")),
      body: Column(
        children: [
          Row(
            children: [
              Text("$varName"),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () => {
              Navigator.pop(context, int.parse(controller.value.text)),
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}

class PrimeiraTela extends StatelessWidget {
  const PrimeiraTela({super.key});

  Future <void> navegaTela2(BuildContext context) async {
    var result  = await Navigator.pushNamed(context, "/inserirDadosX" /*, arguments: "X"*/);

    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Primeira Tela")),
      body: Column(
        children: [
          Row(
            children: [
              Text("X"),
              TextButton(
                onPressed: () => navegaTela2(context),
                child: Text("Informar X"),
              ),
            ],
          ),
          Row(
            children: [
              Text("Y"),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, "/inserirDadosY"),
                child: Text("Informar Y"),
              ),
            ],
          ),
          TextButton(onPressed: null, child: Text("Calcular")),
          Text("Resultado"),
        ],
      ),
    );
  }
}
