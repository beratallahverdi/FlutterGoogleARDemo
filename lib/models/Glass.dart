import 'dart:ui';

class Glass implements JSONable {
    final String documentID, description, arSupported;
    final String asin, model, title;
    final int sellCount, viewCount;
    final List<dynamic> images;
    final List<Comment> comments;
    final List<Seller> seller;
    final Map<String, dynamic> properties;
    final Color color;

    Glass ({this.documentID,
            this.images,
            this.comments,
            this.sellCount,
            this.description,
            this.arSupported,
            this.asin,
            this.model,
            this.title,
            this.properties,
            this.seller,
            this.viewCount,
            this.color
        });
    
    factory Glass.fromJson(Map<String,dynamic> json, String documentID){
        return Glass(
            documentID: documentID,
            images: json['images'],
            comments: Comment().dataToList(json['comments']),
            sellCount: json['sell_count'],
            description: json['description'],
            arSupported: json['ar_supported'],
            asin: json['asin'],
            model: json['model'],
            title: json['title'],
            properties: json['properties'],
            seller: Seller().dataToList(json["sellers"]),
            viewCount: json['view_count'],
            color: Glass.fromHex(json["color"])
        );
    }

    static Color fromHex(String hexString) {
        final buffer = StringBuffer();
        if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
        buffer.write(hexString.replaceFirst('#', ''));
        return Color(int.parse(buffer.toString(), radix: 16));
    }

    @override
    Map<String, dynamic> toJson() => {
        'documentID': documentID,
        'images': images,
        'comments': comments[0].toJson(),
        'sellCount': sellCount,
        'description': description,
        'arSupported': arSupported,
        'asin': asin,
        'model': model,
        'title': title,
        'properties': properties,
        'seller': seller,
        'viewCount': viewCount,
        'color': color.toString()
    };
}


class Comment implements Listable, JSONable {
    final int star;
    final String comment;
    final DateTime publishDate;
    final String username;

    Comment({this.star, this.comment, this.publishDate, this.username});

    @override
    List<Comment> dataToList(List<dynamic> datas) {
        List<Comment> allComment = new List<Comment>();
        datas.forEach((data) {
        allComment.add(Comment(
            star: data['star'],
            comment: data['comment'],
            publishDate: (data["publish_date"]).toDate(),
            username: data['username']));
        });

        return allComment;
    }

    @override
    Map<String, dynamic> toJson() => {
        'star': star,
        'comment': comment,
        'publishDate': publishDate,
        'username': username,
    };
}

class Seller implements Listable, JSONable {
    final bool cargo;
    final String marketName;
    final double price;
    final String exchange;

    Seller({this.cargo, this.marketName, this.price, this.exchange});

    @override
    List<Seller> dataToList(List<dynamic> datas) {
        List<Seller> allSellers = new List<Seller>();
        datas.forEach((data) {
        allSellers.add(Seller(
            cargo: data['cargo'],
            marketName: data['market_name'],
            price: (data["price"]),
            exchange: data['exchange']));
        });

        return allSellers;
    }

    @override
    Map<String, dynamic> toJson() => {
        'cargo': cargo,
        'market_name': marketName,
        'price': price,
        'exchange': exchange,
    };
}

// interface
class Listable {
    List dataToList(List<dynamic> datas) {return new List();}
}

// interface
class JSONable {
    Map<String, dynamic> toJson() => {};
}