import 'dart:convert';

GoogleNearByPlacesModel googleNearByPlacesModelFromJson(String str) => GoogleNearByPlacesModel.fromJson(json.decode(str));

String googleNearByPlacesModelToJson(GoogleNearByPlacesModel data) => json.encode(data.toJson());

class GoogleNearByPlacesModel {
    GoogleNearByPlacesModel({
        this.htmlAttributions,
        this.results,
        this.status,
    });

    List<dynamic> htmlAttributions;
    List<Result> results;
    String status;

    factory GoogleNearByPlacesModel.fromJson(Map<String, dynamic> json) => GoogleNearByPlacesModel(
        htmlAttributions: List<dynamic>.from(json["html_attributions"].map((x) => x)),
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "status": status,
    };
}

class Result {
    Result({
        this.businessStatus,
        this.geometry,
        this.icon,
        this.iconBackgroundColor,
        this.iconMaskBaseUri,
        this.name,
        this.openingHours,
        this.photos,
        this.placeId,
        this.plusCode,
        this.rating,
        this.reference,
        this.scope,
        this.types,
        this.userRatingsTotal,
        this.vicinity,
    });

    String businessStatus;
    Geometry geometry;
    String icon;
    String iconBackgroundColor;
    String iconMaskBaseUri;
    String name;
    OpeningHours openingHours;
    List<Photo> photos;
    String placeId;
    PlusCode plusCode;
    double rating;
    String reference;
    String scope;
    List<String> types;
    int userRatingsTotal;
    String vicinity;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        businessStatus: json["business_status"],
        geometry: Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor: json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        name: json["name"],
        openingHours: json["opening_hours"] == null ? null : OpeningHours.fromJson(json["opening_hours"]),
        photos: json["photos"] == null ? null : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        placeId: json["place_id"],
        plusCode: PlusCode.fromJson(json["plus_code"]),
        rating: json["rating"].toDouble(),
        reference: json["reference"],
        scope: json["scope"],
        types: List<String>.from(json["types"].map((x) => x)),
        userRatingsTotal: json["user_ratings_total"],
        vicinity: json["vicinity"],
    );

    Map<String, dynamic> toJson() => {
        "business_status": businessStatus,
        "geometry": geometry.toJson(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "name": name,
        "opening_hours": openingHours == null ? null : openingHours.toJson(),
        "photos": photos == null ? null : List<dynamic>.from(photos.map((x) => x.toJson())),
        "place_id": placeId,
        "plus_code": plusCode.toJson(),
        "rating": rating,
        "reference": reference,
        "scope": scope,
        "types": List<dynamic>.from(types.map((x) => x)),
        "user_ratings_total": userRatingsTotal,
        "vicinity": vicinity,
    };
}

class Geometry {
    Geometry({
        this.location,
        this.viewport,
    });

    Location location;
    Viewport viewport;

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport.toJson(),
    };
}

class Location {
    Location({
        this.lat,
        this.lng,
    });

    double lat;
    double lng;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}

class Viewport {
    Viewport({
        this.northeast,
        this.southwest,
    });

    Location northeast;
    Location southwest;

    factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
    );

    Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
    };
}

class OpeningHours {
    OpeningHours({
        this.openNow,
    });

    bool openNow;

    factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"],
    );

    Map<String, dynamic> toJson() => {
        "open_now": openNow,
    };
}

class Photo {
    Photo({
        this.height,
        this.htmlAttributions,
        this.photoReference,
        this.width,
    });

    int height;
    List<String> htmlAttributions;
    String photoReference;
    int width;

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"],
        htmlAttributions: List<String>.from(json["html_attributions"].map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
    };
}

class PlusCode {
    PlusCode({
        this.compoundCode,
        this.globalCode,
    });

    String compoundCode;
    String globalCode;

    factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
    );

    Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
    };
}
