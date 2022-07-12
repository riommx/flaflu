import 'package:flutter/material.dart';
import 'package:simple_form_flutter/components/contatos/field.dart';
import 'package:simple_form_flutter/database/dao/entity_dao.dart';
import 'package:simple_form_flutter/siddd/lib/library.dart';

class EntityForm extends StatefulWidget {
  final Entity? entityUpdate;
  final EntityDao dao;
  final Map<String, dynamic> params;

  const EntityForm({
    Key? key,
    this.entityUpdate,
    required this.dao,
    required this.params,
  }) : super(key: key);

  @override
  State<EntityForm> createState() => _EntityFormState();
}

class _EntityFormState extends State<EntityForm> {
  @override
  void initState() {
    super.initState();
    if (widget.entityUpdate != null) {
      _preencheCampos(widget.entityUpdate!);
    }
  }

  final _controllerNome = TextEditingController();
  final _controllerTelefone = TextEditingController();

  bool _validateNumConta = false;
  bool _validateValorTransf = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Novo entity'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Field(
                controller: _controllerNome,
                labelText: widget.params['name']['labelText'],
                hintText: widget.params['name']['hintText'],
                validate: _validateNumConta,
                icon: Icons.person,
              ),
              Field(
                controller: _controllerTelefone,
                labelText: widget.params['name']['labelText'],
                hintText: widget.params['name']['hintText'],
                validate: _validateValorTransf,
                icon: Icons.phone,
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    child: const Text('SALVAR'),
                    onPressed: () => widget.entityUpdate != null
                        ? _updateEntity(widget.entityUpdate!.uid.getOrCrash)
                        : _createEntity(context),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  _preencheCampos(Entity entityUpdate) {
    _controllerNome.text = entityUpdate.;
    _controllerTelefone.text = entityUpdate.telefone;
  }

  _updateEntity(String idEntity) {
    final String nomeEntity = _controllerNome.text;
    final String telefone = _controllerTelefone.text;

    final entityUpdate = Entity(idEntity, nomeEntity, telefone);
    _dao.updateContact(entityUpdate).then((id) => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ListaEntitys()))
        });
  }

  _createEntity(BuildContext context) {
    final String nomeEntity = _controllerNome
        .text; //int.tryParse(_controllerNome.text); //Tenta converter para int se não retorna nulo
    final String telefone = _controllerTelefone.text;

    _retornaErroCamposVazios(nomeEntity, telefone);

    if (_verificaCamposVazios(nomeEntity, telefone)) {
      final entityCriado = Entity(0, nomeEntity, telefone);
      _dao.save(entityCriado).then((id) => Navigator.pop(context));
    }
  }

  _retornaErroCamposVazios(nomeEntity, telefone) {
    setState(() {
      nomeEntity != null && nomeEntity != ""
          ? _validateNumConta = false
          : _validateNumConta = true;
      telefone != null && telefone != ""
          ? _validateValorTransf = false
          : _validateValorTransf = true;
    });
  }

  bool _verificaCamposVazios(nomeEntity, telefone) {
    return ((nomeEntity != null && nomeEntity != "") &&
            telefone != null &&
            telefone != "")
        ? true
        : false;
  }
}
