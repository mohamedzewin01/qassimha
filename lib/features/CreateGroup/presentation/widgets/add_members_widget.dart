import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qassimha/core/di/di.dart';
import 'package:qassimha/features/CreateGroup/presentation/bloc/members/members_cubit.dart';

class AddMembersWidget extends StatefulWidget {
  const AddMembersWidget({super.key});

  @override
  State<AddMembersWidget> createState() => _AddMembersWidgetState();
}

class _AddMembersWidgetState extends State<AddMembersWidget> {
  late MembersCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<MembersCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: TextFormField(

      ),
    );
  }
}
