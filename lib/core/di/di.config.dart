// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/Auth/singin_singup/data/datasources/Auth_datasource_repo.dart'
    as _i879;
import '../../features/Auth/singin_singup/data/datasources/Auth_datasource_repo_impl.dart'
    as _i686;
import '../../features/Auth/singin_singup/data/repositories_impl/Auth_repo_impl.dart'
    as _i776;
import '../../features/Auth/singin_singup/domain/repositories/Auth_repository.dart'
    as _i555;
import '../../features/Auth/singin_singup/domain/useCases/Auth_useCase_repo.dart'
    as _i570;
import '../../features/Auth/singin_singup/domain/useCases/Auth_useCase_repo_impl.dart'
    as _i810;
import '../../features/Auth/singin_singup/presentation/bloc/Auth_cubit.dart'
    as _i284;
import '../../features/Groups/data/datasources/Groups_datasource_repo.dart'
    as _i321;
import '../../features/Groups/data/datasources/Groups_datasource_repo_impl.dart'
    as _i65;
import '../../features/Groups/data/repositories_impl/Groups_repo_impl.dart'
    as _i300;
import '../../features/Groups/domain/repositories/Groups_repository.dart'
    as _i892;
import '../../features/Groups/domain/useCases/Groups_useCase_repo.dart'
    as _i758;
import '../../features/Groups/domain/useCases/Groups_useCase_repo_impl.dart'
    as _i430;
import '../../features/Groups/presentation/bloc/Groups_cubit.dart' as _i114;
import '../../features/Home/data/datasources/Home_datasource_repo.dart'
    as _i827;
import '../../features/Home/data/datasources/Home_datasource_repo_impl.dart'
    as _i97;
import '../../features/Home/data/repositories_impl/Home_repo_impl.dart' as _i60;
import '../../features/Home/domain/repositories/Home_repository.dart' as _i126;
import '../../features/Home/domain/useCases/Home_useCase_repo.dart' as _i543;
import '../../features/Home/domain/useCases/Home_useCase_repo_impl.dart'
    as _i557;
import '../../features/Home/presentation/bloc/Home_cubit.dart' as _i371;
import '../../features/Welcome/data/datasources/Welcome_datasource_repo.dart'
    as _i136;
import '../../features/Welcome/data/datasources/Welcome_datasource_repo_impl.dart'
    as _i809;
import '../../features/Welcome/data/repositories_impl/Welcome_repo_impl.dart'
    as _i915;
import '../../features/Welcome/domain/repositories/Welcome_repository.dart'
    as _i582;
import '../../features/Welcome/domain/useCases/Welcome_useCase_repo.dart'
    as _i157;
import '../../features/Welcome/domain/useCases/Welcome_useCase_repo_impl.dart'
    as _i970;
import '../../features/Welcome/presentation/bloc/Welcome_cubit.dart' as _i405;
import '../api/api_manager/api_manager.dart' as _i680;
import '../api/dio_module.dart' as _i784;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.providerDio());
    gh.factory<_i126.HomeRepository>(() => _i60.HomeRepositoryImpl());
    gh.factory<_i543.HomeUseCaseRepo>(
        () => _i557.HomeUseCase(gh<_i126.HomeRepository>()));
    gh.factory<_i680.ApiService>(() => _i680.ApiService(gh<_i361.Dio>()));
    gh.factory<_i827.HomeDatasourceRepo>(
        () => _i97.HomeDatasourceRepoImpl(gh<_i680.ApiService>()));
    gh.factory<_i582.WelcomeRepository>(() => _i915.WelcomeRepositoryImpl());
    gh.factory<_i136.WelcomeDatasourceRepo>(
        () => _i809.WelcomeDatasourceRepoImpl(gh<_i680.ApiService>()));
    gh.factory<_i879.AuthDatasourceRepo>(
        () => _i686.AuthDatasourceRepoImpl(gh<_i680.ApiService>()));
    gh.factory<_i371.HomeCubit>(
        () => _i371.HomeCubit(gh<_i543.HomeUseCaseRepo>()));
    gh.factory<_i321.GroupsDatasourceRepo>(
        () => _i65.GroupsDatasourceRepoImpl(gh<_i680.ApiService>()));
    gh.factory<_i157.WelcomeUseCaseRepo>(
        () => _i970.WelcomeUseCase(gh<_i582.WelcomeRepository>()));
    gh.factory<_i555.AuthRepository>(
        () => _i776.AuthRepositoryImpl(gh<_i879.AuthDatasourceRepo>()));
    gh.factory<_i570.AuthUseCaseRepo>(
        () => _i810.AuthUseCase(gh<_i555.AuthRepository>()));
    gh.factory<_i284.AuthCubit>(
        () => _i284.AuthCubit(gh<_i570.AuthUseCaseRepo>()));
    gh.factory<_i892.GroupsRepository>(
        () => _i300.GroupsRepositoryImpl(gh<_i321.GroupsDatasourceRepo>()));
    gh.factory<_i405.WelcomeCubit>(
        () => _i405.WelcomeCubit(gh<_i157.WelcomeUseCaseRepo>()));
    gh.factory<_i758.GroupsUseCaseRepo>(
        () => _i430.GroupsUseCase(gh<_i892.GroupsRepository>()));
    gh.factory<_i114.GroupsCubit>(
        () => _i114.GroupsCubit(gh<_i758.GroupsUseCaseRepo>()));
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
