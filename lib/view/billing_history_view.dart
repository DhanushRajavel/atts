import 'package:flutter/material.dart';
import 'package:jwy/services/billing_history_services.dart';
import 'package:jwy/model/billing_record.dart';
import 'package:jwy/utils/constants.dart';
import 'package:jwy/view/widgets/billing_history_card.dart';

class BillingHistoryView extends StatefulWidget {
  const BillingHistoryView({super.key});

  @override
  _BillingHistoryViewState createState() => _BillingHistoryViewState();
}

class _BillingHistoryViewState extends State<BillingHistoryView> {
  final BillingHistoryServices _billingHistoryServices =
      BillingHistoryServices();
  final ScrollController _scrollController = ScrollController();
  final List<BillingRecord> _billingRecords = [];
  int _currentPage = 1;
  final int _limit = 10;
  bool _isLoading = false;
  bool _hasMore = true;
  String _searchQuery = '';
  String? _sortBy = 'date';
  bool _ascending = false;

  @override
  void initState() {
    super.initState();
    _loadMoreRecords();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMore) {
        _loadMoreRecords();
      }
    });
  }

  Future<void> _loadMoreRecords() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final newRecords = await _billingHistoryServices.getBillingHistory(
      page: _currentPage,
      limit: _limit,
      searchQuery: _searchQuery,
      sortBy: _sortBy,
      ascending: _ascending,
    );

    final totalRecords = await _billingHistoryServices.getTotalRecords(
      searchQuery: _searchQuery,
    );
    setState(() {
      _billingRecords.addAll(newRecords);
      _currentPage++;
      _hasMore = _billingRecords.length < totalRecords;
      _isLoading = false;
    });
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
      _billingRecords.clear();
      _currentPage = 1;
      _hasMore = true;
    });
    _loadMoreRecords();
  }

  void _onSort(String? sortBy) {
    setState(() {
      if (_sortBy == sortBy) {
        _ascending = !_ascending;
      } else {
        _sortBy = sortBy;
        _ascending = true;
      }
      _billingRecords.clear();
      _currentPage = 1;
      _hasMore = true;
    });
    _loadMoreRecords();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(title: const Text('Billing History')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by Product Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _onSearch,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _sortBy,
                  items: const [
                    DropdownMenuItem(value: 'date', child: Text('Date')),
                    DropdownMenuItem(value: 'total', child: Text('Total')),
                    DropdownMenuItem(
                      value: 'productName',
                      child: Text('Product Name'),
                    ),
                  ],
                  onChanged: _onSort,
                  hint: const Text('Sort By'),
                ),
                IconButton(
                  icon: Icon(
                    _ascending ? Icons.arrow_upward : Icons.arrow_downward,
                  ),
                  onPressed: () => _onSort(_sortBy),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                _billingRecords.isEmpty && !_isLoading
                    ? const Center(child: Text('No billing records found.'))
                    : ListView.builder(
                      controller: _scrollController,
                      itemCount: _billingRecords.length + (_hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _billingRecords.length) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final record = _billingRecords[index];
                        return BillingHistoryCard(record: record);
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
