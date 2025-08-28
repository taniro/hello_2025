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

class PrimeiraTela extends StatefulWidget {
  const PrimeiraTela({super.key});

  @override
  State<PrimeiraTela> createState() => _PrimeiraTelaState();
}

class _PrimeiraTelaState extends State<PrimeiraTela> {

  Future <void> navegaTela2(BuildContext context, String rota) async {
    var result  = await Navigator.pushNamed(context, rota /*, arguments: "X"*/);
    if (!mounted) return;
    setState(() {
      if (rota == "/inserirDadosX"){
        valorX = result as int;
      }else{
        valorY = result as int;
      }
    });

  }

  late int valorX;
  late int valorY;
  late int resultado;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valorX = 0;
    valorY = 0;
    resultado = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Primeira Tela")),
      body: Column(
        children: [
          Row(
            children: [
              Text("X = $valorX"),
              TextButton(
                onPressed: () => navegaTela2(context, "/inserirDadosX") ,
                child: Text("Informar X"),
              ),
            ],
          ),
          Row(
            children: [
              Text("Y = $valorY"),
              TextButton(
                onPressed: () => navegaTela2(context, "/inserirDadosY"),
                child: Text("Informar Y"),
              ),
            ],
          ),
          TextButton(onPressed: () => {
            setState(() {
              resultado = valorX + valorY;
            })
          } , child: Text("Calcular")),
          Text("Resultado = $resultado"),
        ],
      ),
    );
  }
}
