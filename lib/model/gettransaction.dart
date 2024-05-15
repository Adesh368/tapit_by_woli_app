class GetTransaction {
  const GetTransaction({
    required this.date,
    required this.amount,
    required this.type,
    required this.status,
    required this.network,
    required this.s,
  });
  final String date;
  final String type;
  final String status;
  final String amount;
  final dynamic network;
  final String s;
}
