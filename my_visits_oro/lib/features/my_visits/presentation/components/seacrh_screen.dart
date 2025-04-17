import 'dart:async';
import 'package:flutter/material.dart';
import 'package:unicards/global/design_system/colors/colors.dart';

class SearchScreen<T> extends StatefulWidget {
  const SearchScreen({
    required this.producer,
    required this.itemBuilder,
    this.hintText,
    this.controller,
    super.key,
  });

  final String? hintText;
  final TextEditingController? controller;
  final FutureOr<List<T>> Function(String) producer;
  final Widget Function(BuildContext, T) itemBuilder;

  @override
  State<SearchScreen<T>> createState() => _SearchScreenState<T>();
}

class _SearchScreenState<T> extends State<SearchScreen<T>> {
  final _results = <T>[];
  bool _isLoading = false;
  Timer? _debounce;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    onChanged('');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                TextField(
                  controller: controller,
                  autofocus: true,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? 'Search',
                    hintStyle: const TextStyle(
                      color: Indra.grey,
                    ),
                    disabledBorder: textFieldBorder(),
                    focusedBorder: textFieldBorder(),
                    border: textFieldBorder(),
                    filled: true,
                    enabledBorder: textFieldBorder(),
                    suffixIcon: controller.text.trim().isEmpty
                        ? null
                        : CloseButton(
                            onPressed: () {
                              controller.clear();
                              onChanged('');
                            },
                          ),
                    prefixIcon: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: Navigator.of(context).pop,
                    ),
                    counterText: '',
                  ),
                ),
              ],
            ),
            if (_isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Indra.black,
                  ),
                ),
              )
            else
              Expanded(
                child: _results.isEmpty && controller.text.trim().isNotEmpty
                    ? _buildNoResultScreen()
                    : ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemBuilder: (context, index) {
                          final result = _results[index];
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => Navigator.pop<T>(context, result),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.itemBuilder(context, result),
                                const Divider(
                                  color: Indra.grey,
                                  indent: 16,
                                  endIndent: 16,
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: _results.length,
                      ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResultScreen() {
    return Text('No results found for "${controller.text}');
  }

  UnderlineInputBorder textFieldBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(color: Indra.black),
    );
  }

  Future<void> _updateResults(String value) async {
    setState(() {
      _isLoading = true;
    });
    final results = await widget.producer(value);
    setState(
      () {
        if (controller.text == value) {
          _results
            ..clear()
            ..addAll(results);
        }
        _isLoading = false;
      },
    );
  }

  Future<void> onChanged(String value) async {
    setState(() {});
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
      _debounce = Timer(
        const Duration(milliseconds: 300),
        () async {
          if (value.isEmpty) {
            setState(_results.clear);
            return;
          }
          await _updateResults(value);
        },
      );
    } else {
      await _updateResults(value);
    }
  }
}

Future<T?> showSearchScreen<T>(
  BuildContext context, {
  String? hintText,
  required String Function(T) title,
  required Widget Function(BuildContext, T) itemBuilder,
  required FutureOr<List<T>> Function(String) producer,
}) async {
  return Navigator.push<T>(
    context,
    MaterialPageRoute<T>(
      builder: (ctx) => SearchScreen<T>(
        itemBuilder: itemBuilder,
        producer: producer,
        hintText: hintText ?? 'Search',
      ),
    ),
  );
}
