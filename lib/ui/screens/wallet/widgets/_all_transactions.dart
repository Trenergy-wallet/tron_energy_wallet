part of '../current_asset.cg.dart';

class _AllTransactions extends ConsumerWidget {
  const _AllTransactions({
    this.transactions,
    this.title = 'mobile.all_transactions',
    this.textEmptyList = 'mobile.displayed_here_transactions',
  });

  final List<TransactionsData>? transactions;

  final String? title;
  final String? textEmptyList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountService = ref.watch(accountServiceProvider);
    final account = accountService.valueOrNull ?? Account.empty;
    final transService = ref.watch(transactionsServiceProvider);
    final m = transService.valueOrNull ?? Transactions.empty;

    final list = transactions ?? m.data;
    // Группировка транзакций по дате
    final transactionsByDate = groupTransactionsByDate(list);

    final addresses = <String>[];

    for (final w in account.wallets) {
      addresses.add(w.address);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.titleH1(title?.tr().capitalizeWords),
          16.sbHeight,
          if (accountService.isLoading || transService.isLoading)
            const Preloader()
          else if (list.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactionsByDate.keys.length,
                itemBuilder: (context, index) {
                  final date = transactionsByDate.keys.elementAt(index);
                  final transactionsForDate = transactionsByDate[date]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Заголовок с датой
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: AppText.bodyCaption(
                          DateFormat('dd.MM.yyyy').format(date),
                          color: AppColors.bwGrayBright,
                        ),
                      ),
                      // Список транзакций для этой даты
                      ...transactionsForDate.map(
                        (t) {
                          final isRisky = t.isRisky;
                          if (isRisky) const SizedBox.shrink();
                          // Type:
                          // 1 - transfer
                          // 2 - energy

                          final isNegative = addresses.contains(t.fromAddress);

                          final fromWhom = isNegative
                              ? 'mobile.transfer_out'
                              : 'mobile.transfer_in';

                          final isTransfer = t.type == Consts.typeTransfer;
                          final title = isTransfer
                              ? '${'mobile.transfer'.tr()} ${fromWhom.tr()}'
                              : 'mobile.energy'.tr();

                          final ta = isNegative ? t.toAddress : t.fromAddress;
                          final address = '${isNegative ? 'To:' : 'From:'} '
                              '${ta.shortAddressWallet}';

                          return _Transaction(
                            title: title,
                            address: isTransfer ? address : '',
                            amount: numbWithoutZero(
                              t.amount,
                              precision: isTransfer ? 6 : 0,
                            ),
                            currency: t.token.shortName,
                            isRisky: t.isRisky,
                            isNegative: isNegative,
                            onTap: () {
                              ref
                                  .read(appBottomSheetCtrlProvider.notifier)
                                  .transaction(t);
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            )
          else ...[
            Center(child: AppIcons.blank()),
            16.sbHeight,
            Center(
              child: AppText.bodySmallTextCond(
                textEmptyList?.tr(),
                color: AppColors.bwGrayMid,
                textAlign: TextAlign.center,
              ),
            ),
            // 40.sbHeight,
          ],
        ],
      ),
    );
  }
}

class _Transaction extends StatelessWidget {
  const _Transaction({
    required this.title,
    required this.address,
    required this.amount,
    required this.currency,
    required this.isRisky,
    required this.isNegative,
    this.onTap,
  });

  final String title;
  final String address;
  final String amount;
  final String currency;
  final bool isRisky;
  final bool isNegative;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ColoredBox(
        color: AppColors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primaryBright,
                  borderRadius: Consts.borderRadiusAll8,
                ),
                child: isNegative ? AppIcons.sendUp() : AppIcons.receiveDown(),
              ),
              8.sbWidth,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.bodyMedium(
                      title,
                      color: isRisky
                          ? AppColors.bwGrayMid
                          : AppColors.bwBrightPrimary,
                    ),
                    if (address.isNotEmpty)
                      AppText.bodyCaption(
                        address,
                        color: AppColors.bwGrayMid,
                      ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (isRisky)
                    Transform.translate(
                      offset: const Offset(0, -13),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.negativeLightMid,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: AppText.bodyCaption(
                          'scam',
                          color: AppColors.negativeBright,
                        ),
                      ),
                    ),
                  AppText.bodyRegularCond(
                    '${isNegative ? '-' : '+'}'
                    '$amount $currency',
                    color: isRisky
                        ? AppColors.bwGrayMid
                        : isNegative
                            ? AppColors.bwBrightPrimary
                            : AppColors.positiveBright,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
