import 'dart:developer';

import 'package:get/get.dart';
import 'package:vakinha_mobile/app/core/mixins/loader_mixin.dart';
import 'package:vakinha_mobile/app/core/mixins/messages_mixin.dart';
import 'package:vakinha_mobile/app/core/rest_client/rest_client.dart';
import 'package:vakinha_mobile/app/repositories/auth/auth_repository.dart';
import 'package:vakinha_mobile/app/repositories/auth/auth_repository_impl.dart';

class RegisterController extends GetxController
    with LoaderMixin, MessagesMixin {
  final AuthRepository _authRepository;
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  RegisterController({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      _loading.toggle();
      await _authRepository.register(name, email, password);
      _loading.toggle();
      Get.back(); // Redirecionar para o login
      // TODO: Modificar a lógica desta página para login
      _message(MessageModel(
        title: 'Sucesso',
        message: 'Cadastro realizado com sucesso!',
        type: MessageType.info,
      ));
    } on RestClientException catch (e, s) {
      _loading.toggle();
      log('Erro ao registrar usuario', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'Erro',
        message: e.message,
        type: MessageType.error,
      ));
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao registrar usuario', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'Erro',
        message: 'Erro ao registrar usuário',
        type: MessageType.error,
      ));
    }
  }
}