import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class InvestScreen extends StatefulWidget {
  const InvestScreen({Key? key}) : super(key: key);

  @override
  _InvestScreenState createState() => _InvestScreenState();
}

class _InvestScreenState extends State<InvestScreen> {
  final TextEditingController _investimentoMensalController = TextEditingController();
  final TextEditingController _numeroMesesController = TextEditingController();
  final TextEditingController _taxaJurosController = TextEditingController();

  double _valorTotalSemJuros = 0.0;
  double _valorTotalComJuros = 0.0;

  void _calcularInvestimento() {
    double investimentoMensal = double.tryParse(_investimentoMensalController.text) ?? 0.0;
    int numeroMeses = int.tryParse(_numeroMesesController.text) ?? 0;
    double taxaJuros = double.tryParse(_taxaJurosController.text) ?? 0.0;

    if (investimentoMensal > 0 && numeroMeses > 0) {
      double montanteSemJuros = investimentoMensal * numeroMeses;

      double montanteComJuros = 0.0;
 double taxaJurosDecimal = taxaJuros / 100.0;

      if (taxaJurosDecimal > 0) {
 montanteComJuros = investimentoMensal * ((pow(1 + taxaJurosDecimal, numeroMeses) - 1) / taxaJurosDecimal);
      }


      setState(() {
        _valorTotalSemJuros = montanteSemJuros;
        _valorTotalComJuros = montanteComJuros;
      });
    } else {
      setState(() {
        _valorTotalSemJuros = 0.0;
        _valorTotalComJuros = 0.0;
      });
    }

  }

  @override
  void dispose() {
    _investimentoMensalController.dispose();
    _numeroMesesController.dispose();
    _taxaJurosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulador de Investimento'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Investimento mensal:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _investimentoMensalController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
              decoration: InputDecoration(
                hintText: 'Digite o valor',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Número de meses:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _numeroMesesController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: 'Quantos meses deseja Investir',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Taxa de juros ao mês:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _taxaJurosController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
              decoration: InputDecoration(
                hintText: 'Digite a taxa de juros',
                suffixText: '%',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _calcularInvestimento,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 30.0),
            Text(
              'Valor total sem juros: R\$ ${_valorTotalSemJuros.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Valor total com juros compostos: R\$ ${_valorTotalComJuros.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
