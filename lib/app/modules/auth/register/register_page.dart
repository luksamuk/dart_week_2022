import 'package:flutter/material.dart';
import 'package:vakinha_mobile/app/core/ui/vakinha_state.dart';
import 'package:vakinha_mobile/app/core/ui/vakinha_ui.dart';
import 'package:vakinha_mobile/app/core/ui/widgets/vakinha_appbar.dart';
import 'package:vakinha_mobile/app/core/ui/widgets/vakinha_button.dart';
import 'package:vakinha_mobile/app/core/ui/widgets/vakinha_textformfield.dart';
import 'package:vakinha_mobile/app/modules/auth/register/register_controller.dart';
import 'package:vakinha_mobile/main.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends VakinhaState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VakinhaAppbar(
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.primaryColorDark,
                    ),
                  ),
                  Text(
                    'Preencha os campos abaixo para criar o seu cadastro.',
                    style: context.textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  VakinhaTextformfield(
                    label: 'Nome',
                    controller: _nameEC,
                    validator: Validatorless.required('Nome obrigat??rio'),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  VakinhaTextformfield(
                    label: 'E-mail',
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail obrigat??rio'),
                      Validatorless.email('E-mail inv??lido'),
                    ]),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  VakinhaTextformfield(
                    label: 'Senha',
                    obscureText: true,
                    controller: _passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigat??ria'),
                      Validatorless.min(6, 'Senha deve conter pelo menos seis caracteres'),
                    ]),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  VakinhaTextformfield(
                    label: 'Confirmar senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirma????o de senha obrigat??ria'),
                      Validatorless.compare(_passwordEC, 'Senha difere da confirma????o'),
                    ]),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Center(
                    child: VakinhaButton(
                      width: context.width,
                      label: 'CADASTRAR',
                      onPressed: () {
                        final formValid = _formKey.currentState?.validate() ?? false;
                        if(formValid) {
                          controller.register(
                            name: _nameEC.text,
                            email: _emailEC.text,
                            password: _passwordEC.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
