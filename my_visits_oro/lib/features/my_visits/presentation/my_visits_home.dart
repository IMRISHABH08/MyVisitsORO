import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:unicards/features/my_visits/domain/entity/user_card.dart';
import 'package:unicards/features/my_visits/presentation/components/filter_chips.dart';
import 'package:unicards/features/my_visits/presentation/components/seacrh_screen.dart';
import 'package:unicards/global/design_system/colors/colors.dart';

import '../../../global/design_system/sizing/sizing.dart';
import '../../../resources/resources.dart';
import 'bloc/my_visits_bloc.dart';
import 'components/visitor_card.dart';

class AllVisits extends StatelessWidget {
  const AllVisits({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyVisitsBloc(usecase: GetIt.I.get()),
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (ctx, _) {
          return <Widget>[const _Header()];
        },
        body: BlocBuilder<MyVisitsBloc, MyVisitsState>(
          builder: (context, state) {
            final filteredList = context.read<MyVisitsBloc>().filteredData;

            if (filteredList.isEmpty) {
              return const Column(
                children: [
                  _FilterTile(),
                  Spacer(),
                  Text('No Entry Found'),
                  Spacer(),
                ],
              );
            }

            return Column(
              children: [
                const _FilterTile(),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, i) {
                      final item = filteredList[i];
                      return VisitorCard(userCard: item);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      )),
    );
  }
}

class _FilterTile extends StatefulWidget {
  const _FilterTile();

  @override
  State<_FilterTile> createState() => _FilterTileState();
}

class _FilterTileState extends State<_FilterTile> {
  VisitType? tempSelectedVisitType;

  VisitStatus? tempSelectedVisitStatus;

  @override
  void initState() {
    _insertOldSelection();
    super.initState();
  }

  void _insertOldSelection() {
    tempSelectedVisitStatus = bloc.selectedVisitStatus;
    tempSelectedVisitType = bloc.selectedVisitType;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey.shade200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Filtered: ${bloc.filteredData.length} Visits',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              _FilterButton(
                filterIcon: const Icon(
                  Icons.search,
                  color: Colors.black87,
                ),
                onPressed: () async {
                  final selectedUser = await showSearchScreen<UserCard>(
                    context,
                    hintText: 'Search by Name or Visit Id...',
                    itemBuilder: (p0, p1) => VisitorCard(userCard: p1),
                    producer: (p0) => bloc.onSearch(p0),
                    title: (item) => item.name,
                  );
                },
              ),
              _FilterButton(
                  filterIcon: const Icon(
                    Icons.filter_list,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    setState(() => _resetSelection());
                    showFilterOption(context);
                  }),
            ],
          )
        ],
      ),
    );
  }

  void _resetSelection() {
    if (!bloc.isVisitStatusSelected) {
      tempSelectedVisitStatus = null;
    }
    if (!bloc.isVisitTypeSelected) {
      tempSelectedVisitType = null;
    }
  }

  List<UserCard> get totalVisits => bloc.getAllVisits;

  MyVisitsBloc get bloc => context.read<MyVisitsBloc>();

  void showFilterOption(BuildContext context) {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        backgroundColor: Indra.white,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Sp.px8),
            topLeft: Radius.circular(Sp.px8),
          ),
        ),
        builder: (_) => StatefulBuilder(builder: (context, setState) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: Sp.px20,
                  horizontal: Sp.px30,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filter Visits',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CloseButton()
                      ],
                    ),
                    const SizedBox(height: Sp.px4),
                    const Divider(height: 1, color: Indra.grey),
                    const SizedBox(height: Sp.px20),
                    const Text(
                      'Visit Type',
                      style: TextStyle(fontSize: 16, color: Indra.grey),
                    ),
                    const SizedBox(height: Sp.px8),
                    FilterChipLists(
                      chips: VisitType.values.map((e) => e.title).toList(),
                      onTap: (p0) {
                        setState(() {
                          tempSelectedVisitType = VisitType.fromTitle(p0);
                        });
                      },
                      oldSelections: [tempSelectedVisitType?.title ?? ''],
                    ),
                    const SizedBox(height: Sp.px20),
                    const Text(
                      'Visit Status',
                      style: TextStyle(fontSize: 16, color: Indra.grey),
                    ),
                    const SizedBox(height: Sp.px8),
                    FilterChipLists(
                      chips: VisitStatus.values.map((e) => e.title).toList(),
                      onTap: (p0) {
                        setState(() {
                          tempSelectedVisitStatus = VisitStatus.fromTitle(p0);
                        });
                      },
                      oldSelections: [tempSelectedVisitStatus?.title ?? ''],
                    ),
                    const SizedBox(height: Sp.px20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: Navigator.of(context).pop,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black87,
                            side: const BorderSide(color: Colors.grey),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (tempSelectedVisitType != null ||
                                tempSelectedVisitStatus != null) {
                              bloc.add(OnFilterEvent(filters: (
                                tempSelectedVisitType,
                                tempSelectedVisitStatus,
                              )));
                            }
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 4,
                          ),
                          child: const Text(
                            'Apply Filter',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            }));
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({
    required this.filterIcon,
    required this.onPressed,
  });

  final Icon filterIcon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.only(right: 12),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: IconButton(
          onPressed: onPressed, icon: filterIcon, color: Colors.black87),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 180.0,
      backgroundColor: Indra.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                  color: Indra.black.withOpacity(1.0),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic),
            ),
            const Text(
              'Rishabh Gupta',
              style: TextStyle(
                color: Indra.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        background: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: SvgPicture.asset(
            Svgs.oroMoneyOnTheWay,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
