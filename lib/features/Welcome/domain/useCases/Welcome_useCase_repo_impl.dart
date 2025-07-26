import '../repositories/Welcome_repository.dart';
import 'package:injectable/injectable.dart';
import '../useCases/Welcome_useCase_repo.dart';

@Injectable(as: WelcomeUseCaseRepo)
class WelcomeUseCase implements WelcomeUseCaseRepo {
  final WelcomeRepository repository;

  WelcomeUseCase(this.repository);

  // Future<Result<T>> call(...) async {
  //   return await repository.get...();
  // }
}
