import 'package:flutter/material.dart';
import 'package:simple_form_flutter/components/contatos/field.dart';
import 'package:simple_form_flutter/database/dao/entity_dao.dart';
import 'package:simple_form_flutter/siddd/lib/library.dart';

class EntityForm extends StatefulWidget {
  final Entity? entityUpdate;
  final EntityDao dao;

  const EntityForm({
    Key? key,
    this.entityUpdate,
    required this.dao,
  }) : super(key: key);

  @override
  State<EntityForm> createState() => _EntityFormState(dao);
}

class _EntityFormState extends State<EntityForm> {
  final EntityDao _dao;

  _EntityFormState(this._dao);

  @override
  void initState() {
    super.initState();
    if (widget.entityUpdate != null) {
      _preencheCampos(widget.entityUpdate!);
    }
  }

  final _controllerNomeContato = TextEditingController();
  final _controllerTelefone = TextEditingController();

  bool _validateNumConta = false;
  bool _validateValorTransf = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Novo contato'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Field(
                  controller: _controllerNomeContato,
                  labelText: "Nome",
                  dica: "Fulano",
                  validate: _validateNumConta,
                  icon: Icons.person),
              Editor(
                controller: _controllerTelefone,
                rotulo: "Telefone",
                dica: "99 999999999",
                validate: _validateValorTransf,
                icon: Icons.phone,
                tipoInput: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    child: const Text('SALVAR'),
                    onPressed: () => widget.contatoUpdate != null
                        ? _atualizaContato(widget.contatoUpdate!.id)
                        : _criaContato(context),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  _preencheCampos(Contato contatoUpdate) {
    _controllerNomeContato.text = contatoUpdate.nomeContato;
    _controllerTelefone.text = contatoUpdate.telefone;
  }

  _atualizaContato(int idContato) {
    final String nomeContato = _controllerNomeContato.text;
    final String telefone = _controllerTelefone.text;

    final contatoUpdate = Contato(idContato, nomeContato, telefone);
    _dao.updateContact(contatoUpdate).then((id) => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ListaContatos()))
        });
  }

  _criaContato(BuildContext context) {
    final String nomeContato = _controllerNomeContato
        .text; //int.tryParse(_controllerNomeContato.text); //Tenta converter para int se não retorna nulo
    final String telefone = _controllerTelefone.text;

    _retornaErroCamposVazios(nomeContato, telefone);

    if (_verificaCamposVazios(nomeContato, telefone)) {
      final contatoCriado = Contato(0, nomeContato, telefone);
      _dao.save(contatoCriado).then((id) => Navigator.pop(context));
    }
  }

  _retornaErroCamposVazios(nomeContato, telefone) {
    setState(() {
      nomeContato != null && nomeContato != ""
          ? _validateNumConta = false
          : _validateNumConta = true;
      telefone != null && telefone != ""
          ? _validateValorTransf = false
          : _validateValorTransf = true;
    });
  }

  bool _verificaCamposVazios(nomeContato, telefone) {
    return ((nomeContato != null && nomeContato != "") &&
            telefone != null &&
            telefone != "")
        ? true
        : false;
  }
}
