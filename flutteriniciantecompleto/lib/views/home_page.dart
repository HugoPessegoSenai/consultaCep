import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutteriniciantecompleto/services/via_cep_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _searchCepController = TextEditingController();
  bool _loading = false;
  bool _enableField = true;
  String _result = "";


void dispose(){
  super.dispose();
  _searchCepController.clear();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar CEP'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCampoCepTextField(),
            _buildPesquisaCepButton(),
            _buildResultForm()
          ],
        ),
      ),
      
    );
  }

  Widget _buildCampoCepTextField(){
   return TextField(
     autofocus: true,
     keyboardType: TextInputType.number,
     textInputAction: TextInputAction.done,
     decoration: InputDecoration(labelText: 'Cep'),
     controller: _searchCepController,
     enabled: _enableField,
   );
 }

  Widget _buildPesquisaCepButton(){
    return Padding(padding: const EdgeInsets.only(top: 20),
    child: RaisedButton(
      onPressed:_searchCep,
      child: _loading ? _circularLoading(): Text('Consultar'),
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
    ),
    );
    
  }

  void _searching(bool enable){
    setState(() {
      _result = enable ? '' : _result;
      _loading = enable;
      _enableField = !enable;
    });
  }

  Widget _circularLoading(){
    return Container(
      height: 15,
      width: 15,
      child: CircularProgressIndicator(),
    );
  }

  Future _searchCep() async{
    _searching(true);
    final cep = _searchCepController.text;

    final resultCep = await ViaCepService.ReqCep(cep: cep);
    debugPrint(resultCep.localidade);

    setState(() {
      _result = resultCep.toJson();
    });

    _searching(false);
  }

  Widget _buildResultForm(){
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Text(_result==null?'':_result)
    );
  }
}