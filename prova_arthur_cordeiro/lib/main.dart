import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Aluno: Arthur Cordeiro Ferreira Souza
void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController quantidadeFilhosController = TextEditingController() ;
  int _vacinadoOuNao = 0;
  int _maeSolteira = 0;
  int _EstudanteOuNao = 0;
  String _dadosFamilia = "";
  String _infoText = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields (){
    _formKey = GlobalKey<FormState>();
    quantidadeFilhosController.text = "";
    setState (() {
      _infoText = "";
      _dadosFamilia = '';
    });
  }
  void _calculate (){
    setState ((){
      int quantidadeFilhos = int.parse(quantidadeFilhosController.text);
      double auxilio_total = 0;
      double salarioMinimo = 1212.0;



      if(_maeSolteira == 1){

        auxilio_total = auxilio_total + 600;
      }

      if(_dadosFamilia == "Abaixo de 2 Salários Mínimos" && quantidadeFilhos <= 2 && quantidadeFilhos > 0 && _EstudanteOuNao == 0 && _vacinadoOuNao == 0) {

        auxilio_total = auxilio_total + 1.5*salarioMinimo;
      }

      if(_dadosFamilia == "Abaixo de 1 Salário Mínimo" && quantidadeFilhos <= 2 && quantidadeFilhos > 0 && _EstudanteOuNao == 0 && _vacinadoOuNao == 0) {

        auxilio_total = auxilio_total + 2.5*salarioMinimo;
      }

      if((_dadosFamilia == "Abaixo de 2 Salários Mínimos" || _dadosFamilia == "Abaixo de 1 Salário Mínimo" )&& quantidadeFilhos >= 3 && _EstudanteOuNao == 0 && _vacinadoOuNao == 0) {

        auxilio_total = auxilio_total + 3*salarioMinimo;
      }

      if(_dadosFamilia == "") {
        _infoText = 'Selecione sua renda.';
      } else{
        _infoText = 'Valor a receber: $auxilio_total reais.';
      }
      _vacinadoOuNao = 0;
      _maeSolteira = 0;
      _EstudanteOuNao = 0;


    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (

        title : Text("YSolutions"),
        centerTitle : true ,
        backgroundColor: Colors .purple,
        actions : <Widget>[
          IconButton(icon: Icon(Icons . refresh ),
              onPressed: _resetFields),
        ],

      ) ,
      backgroundColor: Colors .white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment. stretch,
              children : <Widget>[

                Icon(Icons .monetization_on, size : 120.0, color : Colors .purple,)
                ,
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton(icon: const Icon(Icons.monetization_on),
                    isExpanded: true,
                    style: const TextStyle(color: Colors.purple, fontSize: 18),
                    dropdownColor: Colors.white,
                    items: const [
                      DropdownMenuItem(child: Text("Selecionar renda familiar"), value: ""),
                      DropdownMenuItem(child: Text("Abaixo de 1 Salário Mínimo"), value: "Abaixo de 1 Salário Mínimo"),
                      DropdownMenuItem(child: Text("Abaixo de 2 Salários Mínimos"), value: "Abaixo de 2 Salários Mínimos"),
                      DropdownMenuItem(child: Text("Maior que 2 Salários Mínimos"), value: "Maior que 2 Salários Mínimos"),
                    ],
                    value: _dadosFamilia,
                    onChanged: (String? value) {
                      if(value is String){

                        setState(() {
                          _dadosFamilia = value;
                        });
                      }
                    },),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("A chefe da família é mãe solteira?", textAlign : TextAlign. center ,style: TextStyle(fontSize: 18, color: Colors.purple),),
                ),

                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Center(
                    child: ToggleSwitch(
                      minWidth: 140.0,
                      initialLabelIndex: 0,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      labels: ['Não', 'Sim'],
                      icons: [Icons.man, Icons.woman],
                      activeBgColors: [[Colors.purple],[Colors.purple]],
                      onToggle: (maeSolteira) {

                        _maeSolteira = maeSolteira!;

                      },
                    ),
                  ),
                ),

                Center(
                  child: TextFormField (
                      keyboardType: TextInputType.number,

                      decoration : InputDecoration(
                        labelText : "Quantos Filhos:",

                        labelStyle : TextStyle ( color :
                        Colors .purple,),
                      ),

                      style : TextStyle ( color : Colors .purple,
                          fontSize : 18.0),
                      controller : quantidadeFilhosController,
                      validator: (value) {

                        if (value.toString().isEmpty) {
                          return " Insira um valor";
                        }
                        if (double.parse(value.toString())< 0) {
                          return " Insira um valor válido";
                        }


                      }
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Center(
                    child: ToggleSwitch(
                      minWidth: 140.0,
                      initialLabelIndex: 0,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      labels: ['Estudantes', 'Não estudam'],
                      icons: [Icons.book, Icons.book],
                      activeBgColors: [[Colors.purple],[Colors.purple]],
                      onToggle: (studanteOuNao) {

                        _EstudanteOuNao = studanteOuNao!;

                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Center(
                    child: ToggleSwitch(
                      minWidth: 140.0,
                      initialLabelIndex: 0,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      labels: ['Vacinados', 'Não Vacinados'],
                      icons: [Icons.vaccines, Icons.vaccines],
                      activeBgColors: [[Colors.purple],[Colors.purple]],
                      onToggle: (vacinadoOuNao) {

                        _vacinadoOuNao = vacinadoOuNao!;

                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10.0, bottom:15.0),
                  child: Container(
                      height : 50.0,
                      child : ElevatedButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()) _calculate();
                        },
                        child : Text("Calcular", style : TextStyle ( color : Colors .white, fontSize : 16.0), ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors .purple
                        ),
                      )
                  ),
                ),
                Text(_infoText, textAlign : TextAlign. center ,style: TextStyle(fontSize: 20, color: Colors.purple),)
              ]
          ),
        ),
      ),
    );
  }
}