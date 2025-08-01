import 'package:flutter/material.dart';
import 'package:qassimha/features/EditGroupPage/presentation/pages/EditGroupPage_page.dart';
import 'package:qassimha/features/Groups/data/models/response/get_groups_model.dart';
import 'package:qassimha/features/Groups/presentation/bloc/Groups_cubit.dart';

import 'package:qassimha/features/Groups/presentation/widgets/empty_state.dart';

import 'group_card_widget.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({
    super.key,
    required this.groups,
    required this.onRefresh,
    required this.navigateToCreateGroup,
    required this.viewModel,
  });

  final GroupsCubit viewModel;
  final List<CreatedGroups> groups;
  final VoidCallback onRefresh;
  final VoidCallback navigateToCreateGroup;


  @override
  Widget build(BuildContext context) {
    return groups.isEmpty
        ? EmptyStateWidget(navigateToCreateGroup: navigateToCreateGroup)
        : RefreshIndicator(
      onRefresh: () async {
        onRefresh();
        // context.read<GroupsCubit>().getGroups();
      },
      color: const Color(0xFF667EEA),
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];
          return GroupCardWidget(
            group: group,
            onEdit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditGroupPage(group: group,),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
