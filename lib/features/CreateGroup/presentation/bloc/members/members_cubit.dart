import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:qassimha/features/CreateGroup/domain/entities/members_entity.dart';
import 'package:qassimha/features/CreateGroup/domain/useCases/CreateGroup_useCase_repo.dart';

import '../../../../../core/common/api_result.dart';

part 'members_state.dart';
@injectable
class MembersCubit extends Cubit<MembersState> {
  MembersCubit(this._createGroupUseCaseRepo) : super(MembersInitial());
  final CreateGroupUseCaseRepo _createGroupUseCaseRepo;

  static MembersCubit get(context) => BlocProvider.of(context);

  Future<void> getMembers(String search) async {
    emit(GetMembersLoading());
    var result = await _createGroupUseCaseRepo.getMembers(search);
    switch (result) {
      case Success<GetMembersEntity?>():
        {
          if (!isClosed) {
            emit(GetMembersSuccess(result.data!));
          }
        }
        break;
      case Fail<GetMembersEntity?>():
        {
          if (!isClosed) {
            emit(GetMembersFailure(result.exception));
          }
        }
        break;
    }
  }



}
