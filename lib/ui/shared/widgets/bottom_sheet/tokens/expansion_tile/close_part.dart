import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/domain/account/account.cg.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/account_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/info/blockchains_provider.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/img_network.dart';
import 'package:trenergy_wallet/ui/shared/widgets/rive/switch.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

part '_open_part.dart';

///
class ClosePart extends ConsumerStatefulWidget {
  ///
  const ClosePart(this.model, {super.key});

  ///
  final AppBlockchain model;

  @override
  ConsumerState<ClosePart> createState() => ClosePartState();
}

///
class ClosePartState extends ConsumerState<ClosePart> {
  /// открыт или закрыт
  bool isOpen = false;

  /// идентификатор кошелька
  int walletId = Consts.invalidIntValue;

  ///  аккаунт
  Account account = Account.empty;

  /// список токенов от блокчейна
  AppBlockchain appBlockchain = AppBlockchain.empty;

  @override
  void initState() {
    super.initState();
    appBlockchain = widget.model;
    account = ref.read(accountServiceProvider).valueOrNull ?? Account.empty;
  }

  /// переключаться открыт/закрыт
  void toggle() {
    setState(() {
      isOpen = !isOpen;

      if (isOpen) {
        for (final w in account.wallets) {
          if (appBlockchain.name == w.blockchain.name) {
            walletId = w.id;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const duration = Consts.humanFriendlyDelay * 2;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primaryMid,
        border: Border.all(color: AppColors.bwBrightPrimary),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: toggle,
            child: ColoredBox(
              color: Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImgNetwork(
                    width: 40,
                    height: 40,
                    pathImg: appBlockchain.icon,
                  ),
                  8.sbWidth,
                  AppText.bodyMedium(
                    '${appBlockchain.name} ${'mobile.network'.tr()}',
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    duration:
                        const Duration(milliseconds: Consts.humanFriendlyDelay),
                    turns: isOpen ? 0 : -0.5,
                    curve: Curves.easeInOut,
                    child: AppIcons.chevronUp(),
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: duration),

            /// 32 - высота блока
            /// 16 - отступ между блоками
            height: isOpen ? appBlockchain.tokens.length * 48 : 0,
            curve: Curves.linearToEaseOut,
            alignment: Alignment.topCenter,

            child: _OpenPart(
              list: widget.model.tokens,
              walletId: walletId,
              isOpen: isOpen,
            ),
          ),
        ],
      ),
    );
  }
}
