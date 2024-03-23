import 'package:tut/data/network/app_api.dart';
import 'package:tut/data/network/requests.dart';
import 'package:tut/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  Future<ForgotPasswordResponse> forgotPassword(String email);

  Future<AuthenticationResponse> register(RegisterRequest registerRequest);

  Future<HomeResponse> getHomeData();

  Future<DetailsResponse> getDetails();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
    );
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
    RegisterRequest registerRequest,
  ) async {
    return await _appServiceClient.register(
      registerRequest.userName,
      registerRequest.countryMobileCode,
      registerRequest.mobileNumber,
      registerRequest.email,
      registerRequest.password,
    );
  }

  @override
  Future<HomeResponse> getHomeData() async {
    return await _appServiceClient.getHomeData();
  }

  @override
  Future<DetailsResponse> getDetails() async {
    return await _appServiceClient.getDetails();
  }
}
