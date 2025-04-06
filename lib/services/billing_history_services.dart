import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwy/model/billing_record.dart';

class BillingHistoryServices {
  static const String _key = 'billing_history';

  // Save billing data
  Future<void> saveBilling(BillingRecord record) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_key) ?? [];
    history.add(jsonEncode(record.toJson()));
    await prefs.setStringList(_key, history);
  }

  // Retrieve paginated billing history with search, filter, and sort
  Future<List<BillingRecord>> getBillingHistory({
    int page = 1,
    int limit = 10,
    String? searchQuery,
    String? sortBy, // e.g., 'total', 'date', 'productName'
    bool ascending = true,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_key) ?? [];
    List<BillingRecord> records =
        history.map((item) => BillingRecord.fromJson(jsonDecode(item))).toList();

    // Search by product name
    if (searchQuery != null && searchQuery.isNotEmpty) {
      records = records
          .where((record) => record.productName.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    // Sort
    if (sortBy != null) {
      records.sort((a, b) {
        int comparison;
        switch (sortBy) {
          case 'total':
            comparison = a.total.compareTo(b.total);
            break;
          case 'date':
            comparison = a.date.compareTo(b.date);
            break;
          case 'productName':
            comparison = a.productName.compareTo(b.productName);
            break;
          default:
            comparison = 0;
        }
        return ascending ? comparison : -comparison;
      });
    }

    // Pagination
    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;
    if (startIndex >= records.length) return [];
    return records.sublist(startIndex, endIndex.clamp(0, records.length));
  }

  // Get total number of records (for pagination)
  Future<int> getTotalRecords({String? searchQuery}) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_key) ?? [];
    List<BillingRecord> records =
        history.map((item) => BillingRecord.fromJson(jsonDecode(item))).toList();

    if (searchQuery != null && searchQuery.isNotEmpty) {
      records = records
          .where((record) => record.productName.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    return records.length;
  }
}