import 'package:mini_store/data/transaction.dart';

import 'money.dart';

class Wallet {
  static Money money = Money.initial();

  static Map<String, Money> weekMoney = {
    'monday': Money.initial(),
    'tuesday': Money.initial(),
    'wednesday': Money.initial(),
    'thursday': Money.initial(),
    'friday': Money.initial(),
    'saturday': Money.initial(),
    'sunday': Money.initial(),
  };

  static Map<int, Money> hourTransactions = {
    0: Money.initial(),
    1: Money.initial(),
    2: Money.initial(),
    3: Money.initial(),
    4: Money.initial(),
    5: Money.initial(),
    6: Money.initial(),
    7: Money.initial(),
    8: Money.initial(),
    9: Money.initial(),
    10: Money.initial(),
    11: Money.initial(),
    12: Money.initial(),
    13: Money.initial(),
    14: Money.initial(),
    15: Money.initial(),
    16: Money.initial(),
    17: Money.initial(),
    18: Money.initial(),
    19: Money.initial(),
    20: Money.initial(),
    21: Money.initial(),
    22: Money.initial(),
    23: Money.initial(),
  };

  static void insertHourMoney(DateTime dateTime, Transaction transaction) {
    int hour = dateTime.hour;
    hourTransactions[hour]?.transactions.add(transaction);
  }

  static void insertWeekMoney(DateTime dateTime, Transaction transaction) {
    switch (dateTime.weekday) {
      case 1:
        weekMoney['monday']?.transactions.add(transaction);
        break;
      case 2:
        weekMoney['tuesday']?.transactions.add(transaction);
        break;
      case 3:
        weekMoney['wednesday']?.transactions.add(transaction);
        break;
      case 4:
        weekMoney['thursday']?.transactions.add(transaction);
        break;
      case 5:
        weekMoney['friday']?.transactions.add(transaction);
        break;
      case 6:
        weekMoney['saturday']?.transactions.add(transaction);
        break;
      case 7:
        weekMoney['sunday']?.transactions.add(transaction);
        break;
    }
  }
}
