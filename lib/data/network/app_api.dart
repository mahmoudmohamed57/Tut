import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tut/app/constant.dart';
import 'package:tut/data/response/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field('email') String email,
    @Field('password') String password,
  );

  @POST("/customers/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(
    @Field("email") String email,
  );

  @POST("/customers/register")
  Future<AuthenticationResponse> register(
    @Field("user_name") String userName,
    @Field("country_mobile_code") String countryMobileCode,
    @Field("mobile_number") String mobileNumber,
    @Field("email") String email,
    @Field("password") String password,
  );

  @GET("/home")
  Future<HomeResponse> getHomeData();

  @GET("/homeDetails/1")
  Future<DetailsResponse> getDetails();
}
