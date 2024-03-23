class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String email;
  String phone;
  String link;

  Contacts(this.email, this.phone, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}

class Service {
  int id;
  String title;
  String image;

  Service(this.id, this.title, this.image);
}

class BannerAd {
  int id;
  String link;
  String title;
  String image;

  BannerAd(this.id, this.title, this.image, this.link);
}

class Store {
  int id;
  String title;
  String image;

  Store(this.id, this.title, this.image);
}

class HomeData {
  List<Service> services;
  List<BannerAd> banners;
  List<Store> stores;

  HomeData(this.services, this.banners, this.stores);
}

class HomeObject {
  HomeData? data;

  HomeObject(this.data);
}

class Details {
  int id;
  String title;
  String image;
  String details;
  String services;
  String about;

  Details(
    this.id,
    this.title,
    this.image,
    this.details,
    this.services,
    this.about,
  );
}
