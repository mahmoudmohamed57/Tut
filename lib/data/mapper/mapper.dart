import 'package:tut/app/constant.dart';
import 'package:tut/app/extensions.dart';
import 'package:tut/data/response/responses.dart';
import 'package:tut/domain/model/models.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id.orEmpty() ?? Constant.empty,
      this?.name.orEmpty() ?? Constant.empty,
      this?.numOfNotifications.orZero() ?? Constant.zero,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.email.orEmpty() ?? Constant.empty,
      this?.phone.orEmpty() ?? Constant.empty,
      this?.link.orEmpty() ?? Constant.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer.toDomain(),
      this?.contacts.toDomain(),
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.password.orEmpty() ?? Constant.empty;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      this?.id.orZero() ?? Constant.zero,
      this?.title.orEmpty() ?? Constant.empty,
      this?.image.orEmpty() ?? Constant.empty,
    );
  }
}

extension BannersResponseMapper on BannersResponse? {
  BannerAd toDomain() {
    return BannerAd(
      this?.id.orZero() ?? Constant.zero,
      this?.title.orEmpty() ?? Constant.empty,
      this?.image.orEmpty() ?? Constant.empty,
      this?.link.orEmpty() ?? Constant.empty,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      this?.id.orZero() ?? Constant.zero,
      this?.title.orEmpty() ?? Constant.empty,
      this?.image.orEmpty() ?? Constant.empty,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> services = (this
                ?.data
                ?.services
                ?.map((serviceResponse) => serviceResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Service>()
        .toList();

    List<BannerAd> banners = (this
                ?.data
                ?.banners
                ?.map((bannersResponse) => bannersResponse.toDomain()) ??
            const Iterable.empty())
        .cast<BannerAd>()
        .toList();

    List<Store> stores = (this
                ?.data
                ?.stores
                ?.map((storesResponse) => storesResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Store>()
        .toList();

    var data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}

extension DetailsResponseMapper on DetailsResponse? {
  Details toDomain() {
    return Details(
      this?.id?.orZero() ?? Constant.zero,
      this?.title?.orEmpty() ?? Constant.empty,
      this?.image?.orEmpty() ?? Constant.empty,
      this?.details?.orEmpty() ?? Constant.empty,
      this?.services?.orEmpty() ?? Constant.empty,
      this?.about?.orEmpty() ?? Constant.empty,
    );
  }
}
