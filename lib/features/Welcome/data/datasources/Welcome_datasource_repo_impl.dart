import 'Welcome_datasource_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_manager/api_manager.dart';

@Injectable(as: WelcomeDatasourceRepo)
class WelcomeDatasourceRepoImpl implements WelcomeDatasourceRepo {
  final ApiService apiService;
  WelcomeDatasourceRepoImpl(this.apiService);
}
