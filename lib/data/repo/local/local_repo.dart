import 'package:trenergy_wallet/data/repo/local/models/account_model.cg.dart';

/// Абстрактный интерфейс локальной репы
abstract interface class LocalRepo {
  /// Выбрать аккаунт
  void chooseAccount(AccountModel account);

  /// Сохраняем аккаунт
  void saveAccount(AccountModel account);

  /// Получаем аккаунт
  AccountModel getAccount({required String sk, AccountModel? account});

  /// Получаем аккаунты
  List<AccountModel> getAccountList({required String sk});

  /// Удаляем аккаунты
  void deleteAccountList(AccountModel account);

  /// Обновить аккаунт
  void updateAccount({
    String? name,
    String? description,
    String? iconPath,
    String? iconColorBg,
  });

  /// Сохраняем auth message
  void saveAuthMessage(String value);

  /// Получаем auth message
  String getAuthMessage();

  /// Сохраняем mnemonic
  void saveMnemonic(String value, String secretKey);

  /// Получаем mnemonic
  Future<String> getMnemonic(String secretKey);

  /// Сохраняем secret key.
  void saveSecretKey(String value);

  /// Получаем secret key.
  String getSecretKey();

  /// Сохраняем secret key.
  void savePin(String value);

  /// Получаем secret key.
  String getPin();

  /// Сохраняем token
  void saveToken(String value);

  /// Получаем token
  String getToken();

  /// Сохраняем флаг только избранный список
  void saveOnlyFavorites(bool value);

  /// Получаем флаг только избранный список
  bool getOnlyFavorites();

  /// Сохраняем флаг только избранный список
  void saveBuyEnergyFaq(bool value);

  /// Получаем флаг только избранный список
  bool getBuyEnergyFaq();

  /// Сохраняем флаг пуша уведомлений.
  void savePushFlag(bool value);

  /// Получаем флаг пуша уведомлений.
  bool getPushFlag();

  /// Обновляем все сервисы
  void updateAllService();
}
