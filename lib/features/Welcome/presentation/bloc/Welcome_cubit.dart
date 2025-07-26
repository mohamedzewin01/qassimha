import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:injectable/injectable.dart';
import '../../domain/useCases/Welcome_useCase_repo.dart';

part 'Welcome_state.dart';

@injectable
class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit(this._welcomeUseCaseRepo) : super(WelcomeInitial());
  final WelcomeUseCaseRepo _welcomeUseCaseRepo;
}
