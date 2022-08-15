class Contract {
  String clientSelection;
  String propertySelection;
  String contractStartDate;
  String contractEndDate;
  double amount;
  double taxVatPercentage;
  double taxVatAmount;
  double discountPercentage;
  double discountAmount;

  Contract({
    required this.clientSelection,
    required this.propertySelection,
    required this.contractStartDate,
    required this.contractEndDate,
    required this.amount,
    required this.taxVatPercentage,
    required this.taxVatAmount,
    required this.discountPercentage,
    required this.discountAmount,
  });

  Map<String, Object> toJson() {
    return {
      'client selection': clientSelection,
      'property selection': propertySelection,
      'contract start date': contractStartDate,
      'contract end Date': contractEndDate,
      'amount': amount,
      'tax/vat percentage': taxVatPercentage,
      'tax/vat amount': taxVatAmount,
      'discount percentage': discountPercentage,
      'discount amount': discountAmount,
    };
  }

  static Contract fromJson(Map<String, dynamic> jsonContract) {
    return Contract(
      clientSelection: jsonContract['client selection'] as String,
      propertySelection: jsonContract['property selection'] as String,
      contractStartDate: jsonContract['contract start date'] as String,
      contractEndDate: jsonContract['contract end date'] as String,
      amount: jsonContract['amount'] as double,
      taxVatPercentage: jsonContract['tax/vat percentage'] as double,
      taxVatAmount: jsonContract['tax/vat amount'] as double,
      discountPercentage: jsonContract['discount percentage'] as double,
      discountAmount: jsonContract['discount amount'] as double,
    );
  }
}