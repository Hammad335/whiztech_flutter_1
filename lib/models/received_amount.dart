class ReceivedAmount {
  String? id;
  String contractId;
  String contract;
  String contractDate;
  double contractAmount;
  double receiveAmount;
  double balanceAmount;

  ReceivedAmount({
    this.id,
    required this.contractId,
    required this.contract,
    required this.contractDate,
    required this.contractAmount,
    required this.receiveAmount,
    required this.balanceAmount,
  });

  Map<String, Object> toJson() {
    return {
      'contract': contract,
      'contract id': contractId,
      'contract date': contractDate,
      'contract amount': contractAmount,
      'receive amount': receiveAmount,
      'balance amount': balanceAmount,
    };
  }

  static ReceivedAmount fromJson(Map<String, dynamic> json) {
    return ReceivedAmount(
      id: json['id'] as String,
      contract: json['contract'] as String,
      contractId: json['contract id'] as String,
      contractDate: json['contract date'] as String,
      contractAmount: json['contract amount'].toDouble(),
      receiveAmount: json['receive amount'].toDouble(),
      balanceAmount: json['balance amount'].toDouble(),
    );
  }
}
