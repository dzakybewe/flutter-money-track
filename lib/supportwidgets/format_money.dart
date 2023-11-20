import 'package:money_formatter/money_formatter.dart';
class FormatMoney {
  getAmount(double amount) {
    MoneyFormatter fmf = MoneyFormatter(
        amount: amount,
        settings: MoneyFormatterSettings(
          symbol: 'Rp',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: '',
        )
    );
    return fmf.output.symbolOnLeft;
  }
}
